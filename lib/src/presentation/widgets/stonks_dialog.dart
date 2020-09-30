import 'package:devtalks/src/presentation/themes/text_styles.dart';
import 'package:flutter/material.dart';

class StonksDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        margin: EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              child: Text(
                "Ah yes, trying to pull a stonks move?",
                style: BlueText.copyWith(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 24),
            Image.asset("assets/images/stonks.jpg"),
          ],
        ),
      ),
    );
  }
}
