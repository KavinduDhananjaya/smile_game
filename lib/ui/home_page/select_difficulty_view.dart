import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../main_pages/quiz_screen.dart';
import '../widgets/custom_stack.dart';
import 'game_complete_view.dart';
import 'level_complete_view.dart';

class SelectDifficultyView extends StatelessWidget{
  const SelectDifficultyView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xff1F1147), Color(0xff362679)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: ListView(
          physics: const BouncingScrollPhysics(),
          children: [

            const Padding(
              padding: EdgeInsets.only(top: 30),
              child: Text(
                'Choose your difficulty',
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.white, fontSize: 25, letterSpacing: 1),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            const SizedBox(
              width: double.infinity,
              height: 30,
              child: Icon(
                Icons.keyboard_arrow_down,
                size: 64,
                color: Colors.white,
              ),
            ),
            CarouselSlider(
                options: CarouselOptions(
                  autoPlay: true,
                  autoPlayInterval: const Duration(seconds: 5),
                  height: 350,
                  enlargeCenterPage: true,
                  padEnds: true,
                  viewportFraction: .6,
                ),
                items: [
                  Padding(
                    padding: const EdgeInsets.only(top: 25),
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return  QuizScreen(quizTitle: "Level One", quizId: '1', isSolved: false, quizCategory: 'quizCategory', iconListener: 1);
                            },
                          ),
                        );
                      },
                      child:  CustomStack(
                        image: 'assets/images/quiz_background.png',
                        text1: 'Easy',
                        padding_left: 5,
                        padding_top: 45,
                        padding: 0,
                        color: Color(0xff2D2D2D),

                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return const GameCompleteView(score: 12);
                          },
                        ),
                      );
                    },
                    child: const CustomStack(
                      image: 'assets/images/Component_4.png',
                      text1: 'Normal',
                      padding_left: 7,
                      padding_top: 80,
                      padding: 28,
                      color: Color(0xff444444),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return const LevelCompleteView();
                          },
                        ),
                      );
                    },
                    child: const CustomStack(
                      image: 'assets/images/Component_6.png',
                      text1: 'Hard',
                      padding_left: 8,
                      padding_top: 70,
                      padding: 25,
                      color: Color(0xff444444),
                    ),
                  ),
                ]),

          ],
        ),
      ),
    );
  }

}