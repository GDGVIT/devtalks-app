import 'package:devtalks/src/presentation/animations/show_up.dart';
import 'package:devtalks/src/presentation/screens/main/base_screen.dart';
import 'package:devtalks/src/presentation/themes/text_styles.dart';
import 'package:devtalks/src/presentation/widgets/bg_gradient.dart';
import 'package:devtalks/src/utils/shared_prefs.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthScreen extends StatefulWidget {
  static const routename = "/auth";

  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  bool _isLoading = false;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  Future<void> _signInWithGoogle(BuildContext context) async {
    try {
      setState(() {
        _isLoading = true;
      });
      final GoogleSignInAccount googleSignInAccount =
          await _googleSignIn.signIn();
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );

      final UserCredential authResult =
          await _auth.signInWithCredential(credential);
      final User user = authResult.user;

      if (user != null) {
        final User currentUser = _auth.currentUser;
        print(currentUser.email);
        SharedPrefs.setLoggedInStatus(true);
        Navigator.pushNamedAndRemoveUntil(
          context,
          BaseScreen.routename,
          (route) => false,
        );
        setState(() {
          _isLoading = false;
        });
      }
    } catch (err) {
      setState(() {
        _isLoading = false;
      });
      final snackBar = SnackBar(
        content: Text(
          'Something went wrong!',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.red,
      );
      Scaffold.of(context).showSnackBar(snackBar);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Container(),
        elevation: 0,
        centerTitle: true,
        title: Container(
          width: 120,
          child: Image.asset("assets/images/devstack.png"),
        ),
      ),
      body: Builder(
        builder: (context) => Stack(
          children: [
            BgGradient(),
            Container(
              width: double.infinity,
              height: double.infinity,
              child: ShowUp(
                delay: Duration(milliseconds: 600),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      height: 50,
                      width: MediaQuery.of(context).size.width * 0.5,
                      child: RaisedButton(
                        onPressed: () async {
                          if (!_isLoading) {
                            await _signInWithGoogle(context);
                          }
                        },
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: (!_isLoading)
                            ? Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Text('Login with Google'),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  Image.network(
                                    "https://upload.wikimedia.org/wikipedia/commons/thumb/5/53/Google_%22G%22_Logo.svg/1004px-Google_%22G%22_Logo.svg.png",
                                    fit: BoxFit.contain,
                                    height: 24,
                                  )
                                ],
                              )
                            : Container(
                                height: 35,
                                width: 35,
                                child: CircularProgressIndicator(),
                              ),
                      ),
                    ),
                    SizedBox(height: 100),
                    RichText(
                      text: TextSpan(
                        text: 'Click here to know about ',
                        style: WhiteText.copyWith(
                          fontSize: 17,
                          decoration: TextDecoration.underline,
                        ),
                        children: [
                          TextSpan(
                            text: 'DevTalks',
                            style: PalePinkText.copyWith(
                              fontWeight: FontWeight.bold,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
