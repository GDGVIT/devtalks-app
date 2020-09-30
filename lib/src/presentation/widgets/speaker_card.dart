import 'package:auto_size_text/auto_size_text.dart';
import 'package:devtalks/src/presentation/themes/text_styles.dart';
import 'package:flutter/material.dart';

class SpeakerCard extends StatelessWidget {
  final String speakerName;
  final String speakerPosition;
  final String speakerImage;
  final String speakerDescription;

  SpeakerCard({
    this.speakerName,
    this.speakerPosition,
    this.speakerImage,
    this.speakerDescription,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      child: ClipRRect(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.only(bottom: 16),
                height: 100,
                child: ClipOval(
                  child: Image.asset(speakerImage),
                ),
              ),
              SizedBox(height: 8),
              AutoSizeText(
                speakerName,
                maxLines: 1,
                style: BlackHeadingText,
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 4),
              AutoSizeText(
                speakerPosition,
                maxLines: 1,
                textAlign: TextAlign.center,
                style: BlueText.copyWith(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 32),
              AutoSizeText(
                speakerDescription,
                maxLines: 6,
                style: TextStyle(fontSize: 16),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 24),
            ],
          ),
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
    );
  }
}
