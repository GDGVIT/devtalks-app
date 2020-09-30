import 'package:cached_network_image/cached_network_image.dart';
import 'package:devtalks/src/presentation/animations/show_up.dart';
import 'package:devtalks/src/presentation/screens/auth/auth_screen.dart';
import 'package:devtalks/src/presentation/themes/text_styles.dart';
import 'package:devtalks/src/presentation/themes/themes.dart';
import 'package:devtalks/src/utils/shared_prefs.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class ProfilePage extends StatelessWidget {
  final User _user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ShowUp(
        delay: Duration(milliseconds: 200),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: MediaQuery.of(context).size.height / 8),
            CircleAvatar(
              radius: 68,
              backgroundColor: lightBlue,
              child: CircleAvatar(
                radius: 60,
                backgroundImage: CachedNetworkImageProvider(_user.photoURL),
              ),
            ),
            SizedBox(height: 56),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 8),
              child: Text(
                _user.displayName,
                textAlign: TextAlign.center,
                style: WhiteText.copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                ),
              ),
            ),
            SizedBox(height: 16),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 8),
              child: Text(
                _user.email,
                textAlign: TextAlign.center,
                style: WhiteText.copyWith(
                  fontSize: 18,
                ),
              ),
            ),
            Expanded(
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 16, vertical: 64),
                alignment: Alignment.bottomCenter,
                child: InkWell(
                  child: Text(
                    "Log Out? You will be missed!",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: palePink,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  onTap: () {
                    FirebaseAuth.instance.signOut();
                    GoogleSignIn().signOut();
                    SharedPrefs.setLoggedInStatus(false);
                    Navigator.pushNamedAndRemoveUntil(
                      context,
                      AuthScreen.routename,
                      (route) => false,
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
