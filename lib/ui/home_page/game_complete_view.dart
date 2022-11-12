import 'dart:math';
import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:smile_game/ui/widgets/context_extension.dart';

import '../widgets/reusable_widgets.dart';

class GameCompleteView extends StatefulWidget {
  final int score;

  const GameCompleteView({Key? key, required this.score}) : super(key: key);

  @override
  State<GameCompleteView> createState() => _GameCompleteViewState();
}

class _GameCompleteViewState extends State<GameCompleteView> {
  late ConfettiController _controllerTopCenter;

  @override
  void dispose() {
    _controllerTopCenter.dispose();
    super.dispose();
  }

  @override
  void initState() {
    _controllerTopCenter =
        ConfettiController(duration: const Duration(seconds: 5));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    setState(() {
      _controllerTopCenter.play();
    });

    return Stack(
      alignment: Alignment.topCenter,
      children: [
        Scaffold(
          body: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xff1F1147), Color(0xff362679)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            padding: EdgeInsets.only(top: context.dynamicHeight(0.05)),
            child: Column(
              children: [
                Center(
                    child: Column(
                  children: [
                    SizedBox(height: context.dynamicHeight(0.05)),
                    Text(
                      "Congratulations!",
                      style: Theme.of(context).textTheme.headline3?.copyWith(
                          color: const Color(0xffFFBA07),
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: context.dynamicHeight(0.05)),
                    CircleAvatar(
                      backgroundColor: const Color(0xff5A88B0),
                      radius: 120,
                      child: ReusableWidgets.getImageAsset("kupa.png"),
                    ),
                    SizedBox(height: context.dynamicHeight(0.05)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: context.dynamicWidth(0.4),
                          height: context.dynamicHeight(0.15),
                          child: Card(
                            color: const Color(0xff14154F),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25),
                                side: const BorderSide(
                                    color: Color(0xffFF5ED2), width: 3)),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  widget.score.toString(),
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline5
                                      ?.copyWith(
                                          color: const Color(0xffFF5ED2),
                                          fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  "Total",
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline5
                                      ?.copyWith(
                                          color: const Color(0xffFF5ED2),
                                          fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          width: context.dynamicWidth(0.4),
                          height: context.dynamicHeight(0.15),
                          child: Card(
                            color: const Color(0xff14154F),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25),
                                side: const BorderSide(
                                    color: Color(0xff00B2FF), width: 3)),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "1",
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline5
                                      ?.copyWith(
                                          color: const Color(0xff00B2FF),
                                          fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  "Rank",
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline5
                                      ?.copyWith(
                                          color: const Color(0xff00B2FF),
                                          fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: context.dynamicHeight(0.05)),
                    SizedBox(
                      height: context.dynamicHeight(0.09),
                      width: context.dynamicWidth(0.8),
                      child: InkWell(
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        child: Card(
                          color: const Color(0xff26CE55),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15)),
                          child: Center(
                            child: Text(
                              "Play Again",
                              style: Theme.of(context)
                                  .textTheme
                                  .headline5
                                  ?.copyWith(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                )),
              ],
            ),
          ),
        ),
        ConfettiWidget(
          numberOfParticles: 50,
          blastDirectionality: BlastDirectionality.explosive,
          confettiController: _controllerTopCenter,
        )
      ],
    );
  }
}
