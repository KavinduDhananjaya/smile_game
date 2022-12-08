import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:smile_game/ui/home_page/home_page_cubit.dart';
import 'package:smile_game/ui/root_page/root_cubit.dart';
import 'package:smile_game/ui/widgets/context_extension.dart';
import '../../widgets/score_card.dart';

class LevelCompleteView extends StatelessWidget {
  const LevelCompleteView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final rootCubit = BlocProvider.of<RootCubit>(context);
    final gameCubit = BlocProvider.of<HomePageCubit>(context);

    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      children: [
        SizedBox(height: context.dynamicHeight(0.05)),
        Center(
          child: Text(
            "Level Complete !",
            style: Theme.of(context).textTheme.headline3?.copyWith(
                color: const Color(0xffFFBA07), fontWeight: FontWeight.bold),
          ),
        ),
        Container(
          margin: const EdgeInsets.symmetric(vertical: 20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            gradient: const LinearGradient(
              colors: [Color(0xff7A5CFB), Color(0xff44348C)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: Stack(
            children: [
              Positioned(
                bottom: -5,
                left: -5,
                right: -5,
                child: SvgPicture.asset(
                  'assets/images/score-circles.svg',
                  fit: BoxFit.fitWidth,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: const [
                    Text(
                      'Your final score is',
                      style: TextStyle(fontSize: 25),
                    ),
                    ScoreCard(
                      score: 123,
                      stars: 3,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: context.dynamicHeight(0.05)),
        SizedBox(height: context.dynamicHeight(0.05)),
        const Spacer(),
        SizedBox(
          height: context.dynamicHeight(0.09),
          width: context.dynamicWidth(0.8),
          child: InkWell(
            onTap: () {
              gameCubit.getQuestionData(false);
              gameCubit.nextLevel();
            },
            child: Card(
              color: const Color(0xff26CE55),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
              child: Center(
                child: Text(
                  "Next Level",
                  style: Theme.of(context).textTheme.headline5?.copyWith(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
        ),
        SizedBox(height: context.dynamicHeight(0.03)),
      ],
    );
  }
}
