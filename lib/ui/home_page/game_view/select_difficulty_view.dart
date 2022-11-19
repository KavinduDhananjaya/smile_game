import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:page_transition/page_transition.dart';
import 'package:smile_game/ui/home_page/game_view/game_complete_view.dart';
import 'package:smile_game/ui/home_page/home_page_cubit.dart';
import 'package:smile_game/ui/home_page/home_page_provider.dart';
import 'package:smile_game/ui/root_page/root_cubit.dart';
import 'package:smile_game/ui/widgets/context_extension.dart';

import 'game_view.dart';
import '../../widgets/custom_stack.dart';
import 'level_complete_view.dart';

class SelectDifficultyView extends StatelessWidget {
  const SelectDifficultyView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final rootCubit = BlocProvider.of<RootCubit>(context);
    final gameCubit = BlocProvider.of<HomePageCubit>(context);

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
                  autoPlay: false,
                  autoPlayInterval: const Duration(seconds: 10),
                  height: 350,
                  enlargeCenterPage: true,
                  padEnds: true,
                  viewportFraction: .6,
                  onPageChanged: (index,reason){
                    gameCubit.setDifficulty(index);
                  }
                ),
                items: [
                  Padding(
                    padding: const EdgeInsets.only(top: 25),
                    child: InkWell(
                      onTap: () {
                      },
                      child: const CustomStack(
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
            SizedBox(
              height: context.dynamicHeight(0.2),
            ),
            Padding(
              padding:
                  EdgeInsets.symmetric(horizontal: context.dynamicWidth(0.1)),
              child: SizedBox(
                height: context.dynamicHeight(0.09),
                width: context.dynamicWidth(0.8),
                child: InkWell(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>BlocProvider.value(
                        value: gameCubit, child: const GameView())));
                    // Navigator.of(context).push(PageTransition(
                    //     child: BlocProvider.value(
                    //         value: gameCubit, child: const GameView()),
                    //     type: PageTransitionType.bottomToTop,
                    //     duration: const Duration(milliseconds: 500),
                    //     reverseDuration: const Duration(milliseconds: 400)));
                  },
                  child: Card(
                    color: Colors.deepPurpleAccent,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                    child: Center(
                      child: Text(
                        "Select",
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
}
