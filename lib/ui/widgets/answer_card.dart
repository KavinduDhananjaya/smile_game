import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smile_game/theme/styled_colors.dart';

enum AnswerCardStatus {
  normal,
  disabled,
  error,
  right,
}

Color textColor(AnswerCardStatus answerCardStatus) {
  switch (answerCardStatus) {
    case AnswerCardStatus.error:
      return Colors.redAccent;
    case AnswerCardStatus.right:
      return Colors.green;
    case AnswerCardStatus.disabled:
      return Colors.black26;
    default:
      return Colors.black54;
  }
}

Color borderColor(AnswerCardStatus answerCardStatus) {
  switch (answerCardStatus) {
    case AnswerCardStatus.error:
      return Colors.redAccent;
    case AnswerCardStatus.right:
      return Colors.green;
    case AnswerCardStatus.disabled:
      return Colors.grey.shade100;

    default:
      return Colors.grey.shade300;
  }
}

Color bgColor(AnswerCardStatus answerCardStatus) {
  switch (answerCardStatus) {
    case AnswerCardStatus.error:
      return const Color.fromARGB(71, 255, 79, 62);
    case AnswerCardStatus.right:
      return const Color.fromARGB(55, 69, 255, 76);

    default:
      return Colors.white;
  }
}

IconData adaptiveIcon(AnswerCardStatus answerCardStatus) {
  switch (answerCardStatus) {
    case AnswerCardStatus.error:
      return Icons.error;
    case AnswerCardStatus.right:
      return Icons.check_circle;

    default:
      return Icons.circle_outlined;
  }
}

class AnswerCard extends ConsumerWidget {
  const AnswerCard({
    required this.answer,
    required this.onTap,
    required this.correctAnswer,
    this.isClicked = false,
    // required this.clickedAnswer,
  });

  final int answer;
  final int correctAnswer;
  final VoidCallback? onTap;
  final bool isClicked;

  // final int clickedAnswer;

  @override
  Widget build(BuildContext context, ref) {
    AnswerCardStatus answerCardStatus = AnswerCardStatus.normal;

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: !isClicked ? onTap : null,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 100),
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 10),
          decoration: BoxDecoration(
            // color: isClicked ? Colors.grey : bgColor(answerCardStatus),
            color: isClicked
                ? answer == correctAnswer
                    ? Colors.green
                    : Colors.grey
                : StyledColors.primaryColor,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
                color: isClicked
                    ? answer == correctAnswer
                        ? Colors.green
                        : borderColor(answerCardStatus)
                    : Colors.white,
                width: 3),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Center(
                  child: Text(
                    answer.toString(),
                    style: const TextStyle(color: Colors.white, fontSize: 23),
                  ),
                ),
              ),
              // Icon(
              //   adaptiveIcon(answerCardStatus),
              //   color: textColor(answerCardStatus),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
