import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:devtalks/src/presentation/animations/show_up.dart';
import 'package:devtalks/src/presentation/themes/text_styles.dart';
import 'package:devtalks/src/presentation/themes/themes.dart';
import 'package:devtalks/src/presentation/widgets/add_question_dialog.dart';
import 'package:devtalks/src/presentation/widgets/question_card.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firestore_ui/animated_firestore_list.dart';
import 'package:flutter/material.dart';

class QuestionsScreen extends StatelessWidget {
  final String _userID = FirebaseAuth.instance.currentUser.uid;

  @override
  Widget build(BuildContext context) {
    Query _questions = FirebaseFirestore.instance
        .collection("questions")
        .orderBy("upvotes", descending: true);

    Future<void> upVote(questionID) {
      CollectionReference questions =
          FirebaseFirestore.instance.collection("questions");
      return questions.doc(questionID).update(
        {
          "upvotes": FieldValue.increment(1),
          "usersUpvoted": FieldValue.arrayUnion([_userID]),
        },
      );
    }

    Future<void> cancelUpVote(questionID) {
      CollectionReference questions =
          FirebaseFirestore.instance.collection("questions");
      return questions.doc(questionID).update({
        "upvotes": FieldValue.increment(-1),
        "usersUpvoted": FieldValue.arrayRemove([_userID]),
      });
    }

    return Scaffold(
      backgroundColor: Colors.transparent,
      floatingActionButton: FloatingActionButton(
        backgroundColor: lightBlue,
        child: Icon(Icons.add, color: palePink),
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => AddQuestionDialog(),
            barrierDismissible: false,
          );
        },
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 32),
          Container(
            margin: EdgeInsets.symmetric(vertical: 16, horizontal: 32),
            child: Text(
              "Questions",
              style: TextStyle(
                color: palePink,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            child: ShowUp(
              delay: Duration(milliseconds: 200),
              child: FirestoreAnimatedList(
                physics: BouncingScrollPhysics(),
                padding: EdgeInsets.only(bottom: 56),
                query: _questions,
                emptyChild: Center(
                  child: Container(
                    margin: EdgeInsets.all(16),
                    child: Text(
                      "Looks like no question has been posted yet!",
                      textAlign: TextAlign.center,
                      style: WhiteText,
                    ),
                  ),
                ),
                itemBuilder: (context, snapshot, animation, index) {
                  final question = snapshot;
                  List<String> usersUpvoted =
                      List.from(question.data()["usersUpvoted"]);
                  bool hasUserUpvoted = usersUpvoted.contains(_userID);
                  return QuestionCard(
                    question: question.data()["title"],
                    description: question.data()["description"],
                    upvotes: question.data()["upvotes"],
                    onUpvote: (question.data()["createdBy"] == _userID)
                        ? null
                        : () => upVote(question.id),
                    isUpvoted: hasUserUpvoted,
                    onCancelUpvote: () => cancelUpVote(question.id),
                    isOwnQuestion: question.data()["createdBy"] == _userID,
                    questionID: question.id,
                  );
                },
              ),
              // ListView.builder(
              //   padding: EdgeInsets.only(bottom: 56),
              //   itemBuilder: (context, index) {
              //     final question = snapshot.data.docs[index];
              //     List<String> usersUpvoted =
              //         List.from(question.data()["usersUpvoted"]);
              //     bool hasUserUpvoted = usersUpvoted.contains(_userID);
              //     return QuestionCard(
              //       question: question.data()["title"],
              //       description: question.data()["description"],
              //       upvotes: question.data()["upvotes"],
              //       onUpvote: (question.data()["createdBy"] == _userID)
              //           ? null
              //           : () => upVote(question.id),
              //       isUpvoted: hasUserUpvoted,
              //       onCancelUpvote: () => cancelUpVote(question.id),
              //       isOwnQuestion: question.data()["createdBy"] == _userID,
              //       questionID: question.id,
              //     );
              //   },
              //   itemCount: snapshot.data.docs.length,
              // ),
            ),
          ),
        ],
      ),
    );
  }
}
