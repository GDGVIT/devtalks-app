import 'package:devtalks/src/presentation/themes/themes.dart';
import 'package:devtalks/src/presentation/widgets/delete_dialog.dart';
import 'package:devtalks/src/presentation/widgets/stonks_dialog.dart';
import 'package:flutter/material.dart';

class QuestionCard extends StatelessWidget {
  final String question;
  final String description;
  final int upvotes;
  final bool isUpvoted;
  final bool isOwnQuestion;
  final String questionID;
  final Function onCancelUpvote;
  final Function onUpvote;

  QuestionCard({
    this.question,
    this.description,
    this.upvotes,
    this.onUpvote,
    this.onCancelUpvote,
    this.isUpvoted,
    this.isOwnQuestion,
    this.questionID,
  });

  void _makeSnackbar(BuildContext context) {
    final snackBar = SnackBar(
      content: Text(
        "Don't try so hard to upvote your own question 😉",
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
      backgroundColor: darkBlue,
    );
    Scaffold.of(context).showSnackBar(snackBar);
  }

  Widget _buildUpvoteUI(BuildContext context) {
    if (isOwnQuestion) {
      return ClipOval(
        child: Container(
          height: 38,
          width: 38,
          child: InkWell(
            child: Image.asset(
              "assets/images/thumbsUpFill.png",
              color: Color(0xFF8c8cba),
              scale: 4.5,
            ),
            onLongPress: () => _makeSnackbar(context),
          ),
        ),
      );
    } else {
      if (isUpvoted) {
        return ClipOval(
          child: Container(
            height: 38,
            width: 38,
            child: Material(
              color: lightGrey,
              child: InkWell(
                splashColor: lightBlue,
                onTap: onCancelUpvote,
                child: Image.asset(
                  "assets/images/thumbsUpFill.png",
                  scale: 4.5,
                ),
              ),
            ),
          ),
        );
      } else {
        return ClipOval(
          child: Container(
            height: 38,
            width: 38,
            child: Material(
              color: lightGrey,
              child: InkWell(
                splashColor: lightBlue,
                onTap: onUpvote,
                child: Image.asset(
                  "assets/images/thumbsUpOutline.png",
                  scale: 4.5,
                ),
                onLongPress: () => showDialog(
                  context: context,
                  child: StonksDialog(),
                ),
              ),
            ),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 32, vertical: 8),
      child: Row(
        children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 24, vertical: 32),
            height: 40,
            width: 40,
            child: Image.asset("assets/images/question_icon.png"),
          ),
          Expanded(
            child: Container(
              margin: EdgeInsets.only(right: 24, top: 16, bottom: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    question,
                    style: TextStyle(
                      color: lightBlue,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    description,
                    style: TextStyle(
                      color: lightBlue,
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(height: 16),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Visibility(
                            visible: isOwnQuestion,
                            child: InkWell(
                              child: Icon(Icons.delete, color: lightBlue),
                              onTap: () {
                                showDialog(
                                  context: context,
                                  builder: (context) =>
                                      DeleteDialog(questionID),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Column(
                            children: [
                              Text(
                                upvotes.toString(),
                                style: TextStyle(
                                  color: lightBlue,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ),
                              SizedBox(height: 4),
                            ],
                          ),
                          SizedBox(width: 8),
                          _buildUpvoteUI(context),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(16),
      ),
    );
  }
}
