import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:devtalks/src/presentation/animations/show_up.dart';
import 'package:devtalks/src/presentation/themes/themes.dart';
import 'package:devtalks/src/presentation/widgets/bg_gradient.dart';
import 'package:devtalks/src/presentation/widgets/notification_card.dart';
import 'package:flutter/material.dart';

class NotificationScreen extends StatelessWidget {
  final Query _talks = FirebaseFirestore.instance.collection("notifications");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          BgGradient(),
          SafeArea(
            child: Column(
              children: [
                SizedBox(height: 40),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 32),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: ClipOval(
                            child: Container(
                              height: 25,
                              width: 25,
                              child: Material(
                                color: Colors.transparent,
                                child: InkWell(
                                  onTap: () {
                                    Navigator.pop(context);
                                  },
                                  splashColor: Colors.white,
                                  child: Icon(
                                    Icons.arrow_back,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        width: 120,
                        child: Image.asset("assets/images/devtalks.png"),
                      ),
                      Expanded(child: Container()),
                    ],
                  ),
                ),
                Expanded(child: _buildNotifUI(context)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNotifUI(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 32),
        Container(
          margin: EdgeInsets.symmetric(vertical: 16, horizontal: 32),
          child: Text(
            "Notifications",
            style: TextStyle(
              color: palePink,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        StreamBuilder<QuerySnapshot>(
          stream: _talks.snapshots(includeMetadataChanges: true),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return Expanded(
                child: Center(child: Text("Something went wrong")),
              );
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Expanded(child: Container());
            }
            snapshot.data.docs.forEach((element) {
              print(element.data());
            });
            return Expanded(
              child: ShowUp(
                delay: Duration(milliseconds: 200),
                child: ListView.builder(
                  physics: BouncingScrollPhysics(),
                  padding: EdgeInsets.only(bottom: 16),
                  itemBuilder: (context, index) => NotificationCard(
                    title: snapshot.data.docs[index].data()["title"],
                    body: snapshot.data.docs[index].data()["body"],
                    time: snapshot.data.docs[index].data()["time"],
                  ),
                  itemCount: snapshot.data.docs.length,
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
