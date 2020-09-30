import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:devtalks/src/presentation/animations/show_up.dart';
import 'package:devtalks/src/presentation/themes/themes.dart';
import 'package:devtalks/src/presentation/widgets/timeline_card.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Query _talks =
        FirebaseFirestore.instance.collection("talks").orderBy("order");

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Column(
        children: [
          SizedBox(height: 32),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Timeline:  ",
                  style: TextStyle(
                    color: palePink,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "4th October",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    decoration: TextDecoration.underline,
                    decorationThickness: 4,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
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
                    itemBuilder: (context, index) => TimelineCard(
                      talkName: snapshot.data.docs[index].data()["talkName"],
                      timings: snapshot.data.docs[index].data()["talkTime"],
                    ),
                    itemCount: snapshot.data.docs.length,
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
