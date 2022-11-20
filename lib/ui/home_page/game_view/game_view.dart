import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:smile_game/ui/home_page/home_page_cubit.dart';
import 'package:smile_game/ui/home_page/home_page_state.dart';
import 'package:smile_game/ui/root_page/root_cubit.dart';
import 'package:smile_game/ui/widgets/answer_card.dart';
import 'package:smile_game/ui/widgets/common_snack_bar.dart';
import 'package:smile_game/ui/widgets/context_extension.dart';
import 'package:smile_game/ui/widgets/custom_timer.dart';

import '../../../theme/text_constants.dart';
import '../../widgets/decoration.dart';
import '../../widgets/reusable_widgets.dart';

class GameView extends StatefulWidget {
  const GameView({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => GameViewState();
}

class GameViewState extends State<GameView> {
  @override
  Widget build(BuildContext context) {
    final rootCubit = BlocProvider.of<RootCubit>(context);
    final gameCubit = BlocProvider.of<HomePageCubit>(context);

    final scaffold = WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
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
          child: BlocBuilder<HomePageCubit, HomePageState>(
              buildWhen: (pre, current) =>
                  pre.currentLevel != current.currentLevel ||
                  pre.currentIndex != current.currentIndex ||
                  pre.isProcessing != current.isProcessing ||
                  pre.currentQuestionImage != current.currentQuestionImage ||
                  pre.currentAnswer != current.currentAnswer ||
                  pre.isProcessing != current.isProcessing,
              builder: (context, state) {
                if (state.isProcessing) {

                  final spinkit = SpinKitCircle(
                    color: Colors.white,
                    size: 70.0,
                  );

                  return Column(
                    children:  [
                      Spacer(),
                      spinkit,
                      Spacer(),
                    ],
                  );
                }
                return Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Row(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(
                                    top: context.dynamicHeight(0.056)),
                                child: IconButton(
                                  icon: const Icon(
                                    Icons.clear,
                                    color: Colors.white,
                                    size: 30,
                                  ),
                                  onPressed: () => {
                                    gameCubit.closeTimer(),
                                    Navigator.pop(context)
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.only(
                                top: context.dynamicHeight(0.07)),
                            child: Text(
                              'Level ${state.currentLevel}',
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 25,
                                  letterSpacing: 1),
                            ),
                          ),
                        ),
                        Expanded(child: Container())
                      ],
                    ),
                    SizedBox(
                      height: context.dynamicHeight(0.02),
                    ),
                    BlocBuilder<HomePageCubit, HomePageState>(
                        buildWhen: (pre, current) =>
                            pre.initialTime != current.initialTime ||
                            pre.time != current.time,
                        builder: (context, snapshot) {
                          return Center(
                            child: Text(
                              '${snapshot.time.toInt()}  Seconds',
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 23),
                            ),
                          );
                        }),
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
                        padding:
                            EdgeInsets.only(top: context.dynamicHeight(0.03)),
                        child: state.currentQuestionImage == ''
                            ? ReusableWidgets.getImageAsset("og-img.png")
                            : Image.network(state.currentQuestionImage),
                      ),
                    ),
                    BlocBuilder<HomePageCubit, HomePageState>(
                        buildWhen: (pre, current) =>
                            pre.currentQuestionImage !=
                                current.currentQuestionImage ||
                            pre.currentAnswer != current.currentAnswer,
                        builder: (context, st) {
                          final answers = [];
                          final correct = st.currentAnswer;

                          answers.add(correct);
                          var rng = Random();

                          final range = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9];


                          if (range.contains(correct)) {
                            int randomNumber = rng.nextInt(10);
                            range.remove(correct);
                            range.add(randomNumber);
                            if (range.contains(correct)) {
                              int randomNumber = rng.nextInt(10);
                              range.remove(correct);
                              range.add(randomNumber);
                            }
                          }

                          range.shuffle();

                          int num1 = range[0];
                          int num2 = range[4];
                          int num3 = range[7];

                          answers.addAll([num1, num2, num3]);

                          answers.shuffle();

                          return Expanded(
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16),
                              child: BlocBuilder<HomePageCubit, HomePageState>(
                                  buildWhen: (pre, current) =>
                                      pre.isClicked != current.isClicked,
                                  builder: (context, snapshot) {
                                    return Row(
                                      children: [
                                        Expanded(
                                          child: Column(
                                            children: [
                                              AnswerCard(
                                                answer: answers[0],
                                                correctAnswer: st.currentAnswer,
                                                onTap: () {
                                                  gameCubit
                                                      .checkAnswer(answers[0]);
                                                },
                                                isClicked: snapshot.isClicked,
                                              ),
                                              AnswerCard(
                                                answer: answers[1],
                                                correctAnswer: st.currentAnswer,
                                                onTap: () {
                                                  gameCubit
                                                      .checkAnswer(answers[1]);
                                                },
                                                isClicked: snapshot.isClicked,
                                              ),
                                            ],
                                          ),
                                        ),
                                        Expanded(
                                          child: Column(
                                            children: [
                                              AnswerCard(
                                                answer: answers[2],
                                                correctAnswer: st.currentAnswer,
                                                onTap: () {
                                                  gameCubit
                                                      .checkAnswer(answers[2]);
                                                },
                                                isClicked: snapshot.isClicked,
                                              ),
                                              AnswerCard(
                                                answer: answers[3],
                                                correctAnswer: st.currentAnswer,
                                                onTap: () {
                                                  gameCubit
                                                      .checkAnswer(answers[3]);
                                                },
                                                isClicked: snapshot.isClicked,
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    );
                                  }),
                            ),
                          );
                        }),

                    BlocBuilder<HomePageCubit, HomePageState>(
                        buildWhen: (pre, current) =>
                        pre.isClicked != current.isClicked,
                      builder: (context, snapshot) {
                        return Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: context.dynamicWidth(0.1),
                              vertical: context.dynamicHeight(0.04)),
                          child: SizedBox(
                            height: context.dynamicHeight(0.08),
                            width: context.dynamicWidth(0.8),
                            child: InkWell(
                              onTap: () {
                                snapshot.isClicked?gameCubit.getQuestionData(false):null;
                              },
                              child: Card(
                                color:  !snapshot.isClicked?Colors.deepPurpleAccent.withOpacity(0.3):Colors.deepPurpleAccent,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15)),
                                child: Center(
                                  child: Text(
                                    "Next Quiz",
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline5
                                        ?.copyWith(
                                            color:snapshot.isClicked? Colors.white:Colors.white.withOpacity(0.1),
                                            fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      }
                    ),
                  ],
                );
              }),
        ),
      ),
    );

    return MultiBlocListener(listeners: [
      BlocListener<HomePageCubit, HomePageState>(
        listenWhen: (pre, current) => pre.error != current.error,
        listener: (context, state) {
          if (state.error.isNotEmpty) {
            ScaffoldMessenger.of(context).removeCurrentSnackBar();
            ScaffoldMessenger.of(context)
                .showSnackBar(AppSnackBar.showErrorSnackBar(state.error));
          } else {
            ScaffoldMessenger.of(context).removeCurrentSnackBar();
          }
        },
      ),
      BlocListener<HomePageCubit, HomePageState>(
        listenWhen: (pre, current) =>
            pre.isClicked != current.isClicked ||
            pre.isCorrect != current.isCorrect,
        listener: (context, state) async {
          if (state.isClicked && state.isCorrect == 0) {
            _showMyDialog(true);
            await Future.delayed(
              const Duration(seconds: 2),
              () {
                Navigator.pop(context);
              },
            );
          } else if (state.isClicked && state.isCorrect == 1) {
            _showMyDialog(false);
            await Future.delayed(
              const Duration(seconds: 2),
              () {
                Navigator.pop(context);
              },
            );
          }
        },
      ),
      BlocListener<HomePageCubit, HomePageState>(
        listenWhen: (pre, current) =>
        pre.isClicked != current.isClicked ||
            pre.isCorrect != current.isCorrect || pre.isTimeOut !=current.isTimeOut,
        listener: (context, state) async {
         if(state.isTimeOut){
           ScaffoldMessenger.of(context).removeCurrentSnackBar();
           ScaffoldMessenger.of(context)
               .showSnackBar(AppSnackBar.showErrorSnackBar('Time is over..Try next one'));
         }
        },
      ),
    ], child: scaffold);
  }

  Future<void> _showMyDialog(bool val) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: val
              ? Colors.greenAccent.withOpacity(0.8)
              : Colors.redAccent.withOpacity(0.8),
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
            side: BorderSide(color: val ? Colors.green : Colors.red, width: 2),
          ),
          child: SizedBox(
            width: 100,
            height: 200,
            child: val
                ? const Icon(
                    Icons.check,
                    size: 60,
                    color: Colors.white,
                  )
                : const Icon(
                    Icons.close,
                    size: 60,
                    color: Colors.white,
                  ),
          ),
        );
      },
    );
  }

  void showAlertDialog(BuildContext context) {
    Widget cancelButton = TextButton(
      child: const Text(
        "Testten çık",
        style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
      ),
      onPressed: () {
        Navigator.pop(context);
        Navigator.of(context, rootNavigator: true).pop('dialog');
      },
    );
    Widget continueButton = TextButton(
      child: const Text("Devam et",
          style: const TextStyle(
              color: const Color(0xff26CE55), fontWeight: FontWeight.bold)),
      onPressed: () {
        Navigator.of(context, rootNavigator: true).pop('dialog');
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      backgroundColor: const Color(0xff14154F),
      title: const Text(
        "Uyarı!",
        style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
      ),
      content: const Text(
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
