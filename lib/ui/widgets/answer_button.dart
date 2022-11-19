import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:smile_game/theme/styled_colors.dart';

class AnswerButton extends StatelessWidget {
  final String title;
  final int correct;
  final GestureTapCallback onTap;
  final int btnIndex;
  final int correctIndex;
  final int clickedIndex;

  AnswerButton({
    required this.title,
    required this.correct,
    required this.onTap,
    required this.btnIndex,
    required this.correctIndex,
    required this.clickedIndex,
  });

  @override
  Widget build(BuildContext context) {
    bool check = false;
    bool value = false;
    bool isCorrect = false;

    if (clickedIndex > -1) {
      if (title == correct && correctIndex == clickedIndex) {
        check = true;
        isCorrect = true;
      } else if (title == correct) {
        check = true;
      } else if (clickedIndex == btnIndex) {
        value = true;
      }
    }

    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: InkWell(
        onTap: onTap,
        child: Container(
          constraints: BoxConstraints(maxWidth: 240, maxHeight: 40),
          decoration: BoxDecoration(
            color: value || isCorrect
                ? Colors.white
                : Colors.cyan.withOpacity(0.2),
            borderRadius: BorderRadius.circular(30),
          ),
          child: Padding(
            padding: const EdgeInsets.only(top: 8, left: 40, bottom: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child: Container(),
                ),
                Text(
                  title,
                  style: TextStyle(
                    color: value || isCorrect
                        ? StyledColors.primaryColor
                        : StyledColors.primaryLight,
                    fontWeight: FontWeight.w700,
                    fontSize: 16,
                    decoration: value ? TextDecoration.lineThrough : null,
                  ),
                ),
                Expanded(
                  child: Container(),
                ),
                check
                    ? CircleAvatar(
                        backgroundColor: isCorrect
                            ? Color(0xFF51899E).withOpacity(0.4)
                            : StyledColors.primaryLight.withOpacity(0.4),
                        child: FaIcon(
                          FontAwesomeIcons.check,
                          size: 14,
                          color: Colors.white,
                        ),
                      )
                    : Container(
                        width: 40,
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
