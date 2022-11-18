import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:smile_game/ui/widgets/answer_card.dart';
import 'package:smile_game/ui/widgets/context_extension.dart';
import 'package:smile_game/ui/widgets/custom_timer.dart';

import '../../../theme/text_constants.dart';
import '../../widgets/decoration.dart';
import '../../widgets/reusable_widgets.dart';


class GameView extends StatefulWidget {
  final String quizTitle;
  final String quizId;
  final bool isSolved;
  final String quizCategory;
  final int iconListener;

  const GameView({
    Key? key,
    required this.quizTitle,
    required this.quizId,
    required this.isSolved,
    required this.quizCategory,
    required this.iconListener,
  }) : super(key: key);

  @override
  State<GameView> createState() => _GameViewState();
}

class _GameViewState extends State<GameView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xff1F1147), Color(0xff362679)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(top: context.dynamicHeight(0.07)),
              child: const Text(
                'Level 1',
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.white, fontSize: 25, letterSpacing: 1),
              ),
            ),
            SizedBox(
              height: context.dynamicHeight(0.04),
            ),
            LinearPercentIndicator(
              animation: true,
              lineHeight: 25.0,
              barRadius: Radius.circular(12),
              animationDuration: 2500,
              percent: 1,
              center: Text("80 Seconds"),
              linearStrokeCap: LinearStrokeCap.roundAll,
              progressColor: Colors.white,
            ),
            // SizedBox(
            //   height: context.dynamicHeight(0.01),
            // ),
            // Container(
            //   padding: const EdgeInsets.symmetric(horizontal: 16),
            //   width: double.infinity,
            //   child: const Text(
            //     'Question ${ 1}/7',
            //     textAlign: TextAlign.start,
            //     style: TextStyle(fontSize: 25,color: Colors.white),
            //   ),
            // ),
            Expanded(
              flex: 2,
              child: Padding(
                padding: EdgeInsets.only(top: context.dynamicHeight(0.03)),
                child: ReusableWidgets.getImageAsset("og-img.png"),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          AnswerCard(
                              answer: 'a',
                              answerCardStatus: AnswerCardStatus.right,
                              onTap: () {
                                print("DDDDDDDDDDDDDDDD");
                              }),
                          AnswerCard(
                              answer: 'a',
                              answerCardStatus: AnswerCardStatus.normal,
                              onTap: () {}),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          AnswerCard(
                              answer: 'a',
                              answerCardStatus: AnswerCardStatus.error,
                              onTap: () {}),
                          AnswerCard(
                              answer: 'a',
                              answerCardStatus: AnswerCardStatus.normal,
                              onTap: () {}),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: context.dynamicWidth(0.1),
                  vertical: context.dynamicHeight(0.04)),
              child: SizedBox(
                height: context.dynamicHeight(0.08),
                width: context.dynamicWidth(0.8),
                child: InkWell(
                  onTap: () {},
                  child: Card(
                    color: Colors.deepPurpleAccent,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                    child: Center(
                      child: Text(
                        "Next Quiz",
                        style: Theme.of(context).textTheme.headline5?.copyWith(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void showAlertDialog(BuildContext context) {
    Widget cancelButton = TextButton(
      child: Text(
        "Testten çık",
        style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
      ),
      onPressed: () {
        Navigator.pop(context);
        Navigator.of(context, rootNavigator: true).pop('dialog');
      },
    );
    Widget continueButton = TextButton(
      child: Text("Devam et",
          style:
              TextStyle(color: Color(0xff26CE55), fontWeight: FontWeight.bold)),
      onPressed: () {
        Navigator.of(context, rootNavigator: true).pop('dialog');
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      backgroundColor: Color(0xff14154F),
      title: Text(
        "Uyarı!",
        style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
      ),
      content: Text(
          "Testten çıkarsanız bir daha bu testten puan kazanamayacaksınız!!",
          style: TextStyle(color: Colors.white)),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
