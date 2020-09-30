import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:devtalks/src/presentation/animations/show_up.dart';
import 'package:devtalks/src/presentation/themes/text_styles.dart';
import 'package:devtalks/src/presentation/themes/themes.dart';
import 'package:devtalks/src/presentation/widgets/meme_dialog.dart';
import 'package:devtalks/src/utils/contact_info.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactScreen extends StatelessWidget {
  final List<ContactInfo> _contactInfo = [
    ContactInfo(
      "assets/images/web_icon.png",
      "https://dscvit.com/",
    ),
    ContactInfo(
      "assets/images/instagram_icon.png",
      "https://www.instagram.com/dscvitvellore/",
    ),
    ContactInfo(
      "assets/images/twitter_icon.png",
      "https://twitter.com/dscvit",
    ),
    ContactInfo(
      "assets/images/linkedin_icon.png",
      "https://www.linkedin.com/company/dscvit/",
    ),
    ContactInfo(
      "assets/images/facebook_icon.png",
      "https://www.facebook.com/dscvitvellore",
    ),
    ContactInfo(
      "assets/images/github_icon.png",
      "https://github.com/GDGVIT",
    ),
    ContactInfo(
      "assets/images/medium_icon.png",
      "https://medium.com/gdg-vit",
    ),
    ContactInfo(
      "assets/images/youtube_icon.png",
      "https://www.youtube.com/channel/UCvT-ZJF7fXHJi9kDeCPR-zg",
    ),
  ];

  void _makeSuccessSnackbar(BuildContext context, String msg) {
    final snackBar = SnackBar(
      content: Text(
        msg,
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.green,
    );
    Scaffold.of(context).showSnackBar(snackBar);
  }

  void _makeErrorSnackbar(BuildContext context) {
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

  @override
  Widget build(BuildContext context) {
    void addToMailingList() async {
      bool emailExists = false;
      final String userEmail = FirebaseAuth.instance.currentUser.email;

      CollectionReference emailsRef =
          FirebaseFirestore.instance.collection("mailingList");
      final snapshots = await emailsRef.get();

      snapshots.docs.forEach((doc) {
        if (doc.data()["email"] == userEmail) {
          emailExists = true;
        }
      });

      if (emailExists) {
        _makeSuccessSnackbar(
          context,
          "Hooray, You are already in our mailing list. Stay tuned!",
        );
      } else {
        await emailsRef.add({
          "email": userEmail,
        });
        _makeSuccessSnackbar(
          context,
          "We will keep you updated. Stay tuned!",
        );
      }
    }

    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      padding: EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ---------- Interested in devjams section -----------
          SizedBox(height: 32),
          ShowUp(
            delay: Duration(milliseconds: 200),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.symmetric(vertical: 16, horizontal: 32),
                  child: Text(
                    "Interested in DevJams?",
                    style: TextStyle(
                      color: palePink,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 16),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 32),
                  child: MaterialButton(
                    child: Text(
                      "Keep me notified 😊",
                      style: WhiteText.copyWith(fontSize: 16),
                    ),
                    color: lightBlue,
                    onPressed: () {
                      addToMailingList();
                    },
                  ),
                ),
              ],
            ),
          ),
          // --------- DSC Events section -------
          SizedBox(height: 48),
          ShowUp(
            delay: Duration(milliseconds: 300),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.symmetric(vertical: 16, horizontal: 32),
                  child: Text(
                    "Want to know about upcoming DSC events?",
                    style: TextStyle(
                      color: palePink,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 32),
                      child: MaterialButton(
                        child: Text(
                          "Yes",
                          style: WhiteText.copyWith(fontSize: 16),
                        ),
                        color: lightBlue,
                        onPressed: () async {
                          const URL =
                              "https://dsc.community.dev/vellore-institute-of-technology/";
                          if (await canLaunch(URL)) {
                            await launch(URL);
                          } else {
                            _makeErrorSnackbar(context);
                          }
                        },
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 16),
                      child: MaterialButton(
                        child: Text(
                          "Definitely Yes 🔥",
                          style: WhiteText.copyWith(fontSize: 16),
                        ),
                        color: lightBlue,
                        onPressed: () async {
                          const URL =
                              "https://dsc.community.dev/vellore-institute-of-technology/";
                          if (await canLaunch(URL)) {
                            await launch(URL);
                          } else {
                            _makeErrorSnackbar(context);
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          // ---------- Connect with us section ---------
          SizedBox(height: 48),
          ShowUp(
            delay: Duration(milliseconds: 400),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.symmetric(vertical: 16, horizontal: 32),
                  child: Text(
                    "Connect with us!",
                    style: TextStyle(
                      color: palePink,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 16),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 32),
                  child: Container(
                    margin: EdgeInsets.all(0),
                    width: double.infinity,
                    child: GridView.count(
                      shrinkWrap: true,
                      crossAxisCount: 4,
                      crossAxisSpacing: 32,
                      mainAxisSpacing: 16,
                      physics: BouncingScrollPhysics(),
                      children: List.generate(
                        8,
                        (index) {
                          return Container(
                            margin: EdgeInsets.all(8),
                            child: ClipOval(
                              child: InkWell(
                                child: Container(
                                  color: Colors.white,
                                  padding: EdgeInsets.all(12),
                                  child: Image.asset(_contactInfo[index].asset),
                                ),
                                onTap: () async {
                                  if (await canLaunch(
                                      _contactInfo[index].url)) {
                                    await launch(_contactInfo[index].url);
                                  } else {
                                    _makeErrorSnackbar(context);
                                  }
                                },
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          // ---------- Made with love section ---------
          SizedBox(height: 64),
          ShowUp(
            delay: Duration(milliseconds: 500),
            child: InkWell(
              onLongPress: () => showDialog(
                context: context,
                child: MemeDialog(),
              ),
              child: Container(
                alignment: Alignment.center,
                child: Text("Made with ❤ by DSC-VIT", style: WhiteText),
              ),
            ),
          ),
          SizedBox(height: 16),
        ],
      ),
    );
  }
}
