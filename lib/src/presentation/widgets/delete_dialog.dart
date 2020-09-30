import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class DeleteDialog extends StatelessWidget {
  final String _questionID;

  DeleteDialog(this._questionID);

  @override
  Widget build(BuildContext context) {
    Future<void> deleteQuestion() {
      CollectionReference questions =
          FirebaseFirestore.instance.collection("questions");
      return questions.doc(_questionID).delete();
    }

    return AlertDialog(
      title: Text(
        "Are you sure you want to delete the question?",
        style: TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      actions: [
        Container(
          margin: EdgeInsets.symmetric(horizontal: 8),
          child: OutlineButton(
            child: Container(
              padding: EdgeInsets.all(8),
              child: Text(
                "Cancel",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14),
            ),
            textColor: Colors.grey[800],
            highlightedBorderColor: Colors.grey[800],
            borderSide: BorderSide(
              color: Colors.grey[800],
              width: 2,
            ),
          ),
        ),
        OutlineButton(
          child: Container(
            padding: EdgeInsets.all(8),
            child: Text(
              "Delete",
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          onPressed: () {
            deleteQuestion();
            Navigator.of(context).pop();
          },
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
          textColor: Colors.red,
          highlightedBorderColor: Colors.red,
          borderSide: BorderSide(
            color: Colors.red,
            width: 2,
          ),
        )
      ],
      actionsPadding: EdgeInsets.all(16),
    );
  }
}
