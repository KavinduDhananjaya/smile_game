import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:smile_game/ui/home_page/game_complete_view.dart';
import 'package:smile_game/ui/home_page/leaderboard_view.dart';
import 'package:smile_game/ui/home_page/home_screen.dart';
import 'package:smile_game/ui/home_page/select_difficulty_view.dart';
import 'package:smile_game/ui/main_pages/quiz_screen.dart';
import '../widgets/custom_button.dart';
import 'level_complete_view.dart';

class HomePageView extends StatelessWidget {
  const HomePageView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Welcome Back'),
        centerTitle: true,
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            const Text("Welcome Back"),
            const Spacer(),

            CustomButton(onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return const LevelCompleteView();
                  },
                ),
              );
            }, text: 'Level Complete'),
            CustomButton(onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return const GameCompleteView(score: 12);
                  },
                ),
              );
            }, text: 'Game Complete'),
            CustomButton(onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return  HomeScreen();
                  },
                ),
              );
            }, text: 'Start Game'),
            CustomButton(onPressed: () {

              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return  LeaderboardView();
                  },
                ),
              );
            }, text: 'Leader Board'),

            CustomButton(onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return  QuizScreen(quizTitle: "Level One", quizId: '1', isSolved: false, quizCategory: 'quizCategory', iconListener: 1);
                  },
                ),
              );
            }, text: 'View 4'),

            CustomButton(onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return  const SelectDifficultyView();
                  },
                ),
              );
            }, text: 'View 4'),


            SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}
