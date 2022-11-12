
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';
import 'package:smile_game/ui/widgets/context_extension.dart';

import '../../theme/text_constants.dart';
import '../widgets/decoration.dart';
import '../home_page/game_complete_view.dart';

class QuizScreen extends StatefulWidget {
  final String quizTitle;
  final String quizId;
  final bool isSolved;
  final String quizCategory;
  final int iconListener;

  const QuizScreen({
    Key? key,
    required this.quizTitle,
    required this.quizId,
    required this.isSolved,
    required this.quizCategory,
    required this.iconListener,
  }) : super(key: key);

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  String categoryId(String input) {
    switch (input) {
      case "Kültür":
        return "0";
      case "Çevre":
        return "1";
      case "İnsan Hakları":
        return "2";
      default:
        return "0";
    }
  }

  Color colorControllerA = Colors.white;
  Color colorControllerB = Colors.white;
  Color colorControllerC = Colors.white;
  Color colorControllerD = Colors.white;

  TextEditingController answerTextController = TextEditingController();
  TextEditingController optionController = TextEditingController();
  TextEditingController correctAnswerTextController = TextEditingController();
  TextEditingController optionControllerA = TextEditingController();
  TextEditingController optionControllerB = TextEditingController();
  TextEditingController optionControllerC = TextEditingController();
  TextEditingController optionControllerD = TextEditingController();
  bool continueButtonState = false;
  bool buttonVisibilitiyState = true;

  bool optionColorController =
      true; //şıklara tıklandığında renk değiştirecek fakat devam butonuna bastıktan sonra renk değiştirmeyecek

  int score = 0;

  int indexs = 0;

  late Icon categoryIcon;

  @override
  Widget build(BuildContext context) {
    if (widget.iconListener == 0) {
      categoryIcon = Icon(FontAwesomeIcons.earthAmericas);
    } else if (widget.iconListener == 1) {
      categoryIcon = Icon(FontAwesomeIcons.seedling);
    } else if (widget.iconListener == 2) {
      categoryIcon = Icon(FontAwesomeIcons.dove);
    } else if (widget.iconListener == 3) {
      categoryIcon = Icon(FontAwesomeIcons.boltLightning);
    } else if (widget.iconListener == 4) {
      categoryIcon = Icon(FontAwesomeIcons.droplet);
    } else {
      categoryIcon = Icon(FontAwesomeIcons.earthAmericas);
    }

    return Container(
      decoration: DecorationProperties.quizBackgroundDecoration,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          actions: <Widget>[
            categoryIcon,
            SizedBox(
              width: 10,
            )
          ],
          elevation: 0,
          backgroundColor: Color(0xff14154F),
          centerTitle: true,
          leading: IconButton(
            onPressed: () {
              showAlertDialog(context);
            },
            icon: Icon(Icons.clear),
          ),
          title: Text(widget.quizTitle,
              style: TextConstants.leaderboardAppBarTextStyle(context)),
        ),
        body: Padding(
          padding: const EdgeInsets.only(),
          child: ListView(
            children: [
              Column(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Row(
                      children: [
                        AnimatedContainer(
                          color: Colors.green,
                          width: context
                              .contextProgressBarWidth(indexs + 1.toDouble()),
                          height: 20,
                          duration: Duration(milliseconds: 500),
                        ),
                        AnimatedContainer(
                          color: Colors.white.withOpacity(0.75),
                          width: context.contextProgressBarWidthGrey(
                              indexs + 1.toDouble()),
                          height: 20,
                          duration: Duration(milliseconds: 500),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: Column(
                      children: [
                        SizedBox(
                          width: context.dynamicWidth(1),
                          height: context.dynamicHeight(0.35),
                          child: Container(
                            alignment: Alignment.centerLeft,
                            decoration: DecorationProperties
                                .questionBackgroundDecoration,
                            child: Padding(
                              padding: const EdgeInsets.all(40.0),
                              child: Text("question",
                                  style: TextConstants.quizTextStyle),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 5),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20.0),
                            child: Card(
                              shape: Border(
                                  left: BorderSide(
                                      color: Color(0xffFFCC4D), width: 8)),
                              child: AnimatedContainer(
                                curve: Curves.linearToEaseOut,
                                duration: Duration(milliseconds: 900),
                                color: colorControllerA,
                                child: InkWell(
                                  onTap: () {},
                                  child: SizedBox(
                                    height: isBigScreen() ? 50 : 40,
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 20),
                                      child: Row(
                                        children: [
                                          Text("A-)  " + "'answers'][0]}",
                                              style: TextConstants
                                                  .quizTextStyleAnswers)
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              elevation: 5,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 5),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20.0),
                            child: Card(
                              shape: Border(
                                  left: BorderSide(
                                      color: Color(0xffFFCC4D), width: 8)),
                              child: AnimatedContainer(
                                curve: Curves.linearToEaseOut,
                                duration: Duration(milliseconds: 900),
                                color: colorControllerB,
                                child: InkWell(
                                  onTap: () {},
                                  child: SizedBox(
                                    height: isBigScreen() ? 50 : 40,
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 20),
                                      child: Row(
                                        children: [
                                          Text("B-)  " + "fesg",
                                              style: TextConstants
                                                  .quizTextStyleAnswers)
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              elevation: 5,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 5),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20.0),
                            child: Card(
                              shape: Border(
                                  left: BorderSide(
                                      color: Color(0xffFFCC4D), width: 8)),
                              child: AnimatedContainer(
                                curve: Curves.linearToEaseOut,
                                duration: Duration(milliseconds: 900),
                                color: colorControllerC,
                                child: InkWell(
                                  onTap: () {},
                                  child: SizedBox(
                                    height: isBigScreen() ? 50 : 40,
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 20),
                                      child: Row(
                                        children: [
                                          Text("C-)  " + "fds",
                                              style: TextConstants
                                                  .quizTextStyleAnswers)
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              elevation: 5,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 5),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20.0),
                            child: Card(
                              shape: Border(
                                  left: BorderSide(
                                      color: Color(0xffFFCC4D), width: 8)),
                              child: AnimatedContainer(
                                curve: Curves.linearToEaseOut,
                                duration: Duration(milliseconds: 900),
                                color: colorControllerD,
                                child: InkWell(
                                  onTap: () {},
                                  child: SizedBox(
                                    height: isBigScreen() ? 50 : 40,
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 20),
                                      child: Row(
                                        children: [
                                          Text("D-)  " + "vd",
                                              style: TextConstants
                                                  .quizTextStyleAnswers)
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              elevation: 5,
                            ),
                          ),
                        ),
                        SizedBox(
                            height: isBigScreen()
                                ? context.dynamicHeight(0.01)
                                : context.dynamicHeight(0.005)),
                        continueButtonState
                            ? Card(
                                color: Colors.yellow,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                child: InkWell(
                                  onTap: () {
                                    optionColorController = false;

                                    continueButtonState = false;
                                    answerControl(answerTextController.text);

                                    showModalBottomSheet<void>(
                                      backgroundColor: Colors.transparent,
                                      isScrollControlled: false,
                                      isDismissible: false,
                                      enableDrag: false,
                                      context: context,
                                      builder: (context) {
                                        return WillPopScope(
                                          onWillPop: () async {
                                            return false;
                                          },
                                          child: Container(
                                            decoration: BoxDecoration(
                                                color: Color(0XFF3A3A69),
                                                borderRadius:
                                                    const BorderRadius.only(
                                                        topRight:
                                                            Radius.circular(20),
                                                        topLeft:
                                                            Radius.circular(
                                                                20))),
                                            height: 160,
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 15, right: 15),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                mainAxisSize: MainAxisSize.min,
                                                children: <Widget>[
                                                  Text(
                                                    "fsaf",
                                                    style: TextConstants
                                                        .popupTextTheme(
                                                            context),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            top: 15),
                                                    child: InkWell(
                                                      child: Container(
                                                          decoration: BoxDecoration(
                                                              color: Color(
                                                                  0xff26CE55),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          15)),
                                                          alignment:
                                                              Alignment.center,
                                                          width: 350,
                                                          height: 50,
                                                          child: Text(
                                                            'Anladım',
                                                            style: GoogleFonts
                                                                .openSans(
                                                                    fontSize:
                                                                        35,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    color: Colors
                                                                        .white,
                                                                    letterSpacing:
                                                                        2),
                                                          )),
                                                      onTap: () {},
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                    ).whenComplete(() => print("medal bitti"));
                                  },
                                  child: SizedBox(
                                    height: 60,
                                    child: Center(child: Text("DEVAM")),
                                  ),
                                ),
                                elevation: 5,
                              )
                            : Text(''),
                      ],
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  void answerControl(String answer) {
    //firebasede bir answer olucak şıktaki texti buraya yollayıp kontrol sağlanması gerekiyor

    //if içerisindeki tırnaklı yere firebaseden gelecek cevap fieldını koymak gerek
    if (correctAnswerTextController.text == answer) {
      switch (optionController.text) {
        case "A":
          {
            setState(() {
              colorControllerA = Colors.green;
              score += 10;
              print("skor=" + score.toString());
            });
          }
          break;

        case "B":
          {
            setState(() {
              colorControllerB = Colors.green;
              score += 10;
              print("skor=" + score.toString());
            });
          }
          break;

        case "C":
          {
            setState(() {
              colorControllerC = Colors.green;
              score += 10;
              print("skor=" + score.toString());
            });
          }
          break;
        case "D":
          {
            setState(() {
              colorControllerD = Colors.green;
              score += 10;
              print("skor=" + score.toString());
            });
          }
          break;
        default:
          {}
          break;
      }
    } else {
      switch (optionController.text) {
        case "A":
          {
            setState(() {
              colorControllerA = Colors.red;
            });
          }
          break;

        case "B":
          {
            setState(() {
              colorControllerB = Colors.red;
            });
          }
          break;

        case "C":
          {
            setState(() {
              colorControllerC = Colors.red;
            });
          }
          break;
        case "D":
          {
            setState(() {
              colorControllerD = Colors.red;
            });
          }
          break;
        default:
          {}
          break;
      }
      correctAnswerControl();
    }
    setState(() {});
  }

  void correctAnswerControl() {
    if (correctAnswerTextController.text == optionControllerA.text) {
      colorControllerA = Colors.green;
    } else if (correctAnswerTextController.text == optionControllerB.text) {
      colorControllerB = Colors.green;
    } else if (correctAnswerTextController.text == optionControllerC.text) {
      colorControllerC = Colors.green;
    } else if (correctAnswerTextController.text == optionControllerD.text) {
      colorControllerD = Colors.green;
    }
  }

  bool isBigScreen() {
    if (context.contextHeight() > 700) {
      return true;
    } else {
      return false;
    }
  }

  void cleanOptionColors() {
    colorControllerA = Colors.white;
    colorControllerB = Colors.white;
    colorControllerC = Colors.white;
    colorControllerD = Colors.white;
  }

  Future showChoiseDialog(BuildContext contextt) {
    return showDialog(
        context: contextt,
        builder: (contextt) {
          return AlertDialog(
              title: const Text(
                "Testten çıkmak istediğinize emin misiniz?",
                textAlign: TextAlign.center,
              ),
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(const Radius.circular(8.0))),
              content: Container(
                  height: 30,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(contextt);
                        },
                        child: const Text(
                          "Evet",
                          style: TextStyle(
                              color: Colors.blue, fontWeight: FontWeight.bold),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: const Text(
                          "Vazgeç",
                          style: TextStyle(
                              color: Colors.blue, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  )));
        });
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
