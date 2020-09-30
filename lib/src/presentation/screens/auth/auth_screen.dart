import 'package:devtalks/src/presentation/animations/show_up.dart';
import 'package:devtalks/src/presentation/screens/main/base_screen.dart';
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
      body: Builder(
        builder: (context) => Stack(
          children: [
            BgGradient(),
            Container(
              width: double.infinity,
              height: double.infinity,
              child: SafeArea(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 40),
                    Container(
                      width: 120,
                      child: Image.asset("assets/images/devtalks.png"),
                    ),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ShowUp(
                            delay: Duration(milliseconds: 200),
                            child: Container(
                              alignment: Alignment.center,
                              margin: EdgeInsets.symmetric(horizontal: 32),
                              width: 200,
                              child: Image.asset(
                                "assets/images/devtalks_logo.png",
                              ),
                            ),
                          ),
                          SizedBox(
                              height: MediaQuery.of(context).size.height / 6),
                          ShowUp(
                            delay: Duration(milliseconds: 600),
                            child: Container(
                              height: 50,
                              width: MediaQuery.of(context).size.width * 0.6,
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
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: <Widget>[
                                          Text('Login with Google'),
                                          SizedBox(
                                            width: 20,
                                          ),
                                          Image.asset(
                                            "assets/images/g_logo.png",
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
                          ),
                          SizedBox(height: 100),
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
