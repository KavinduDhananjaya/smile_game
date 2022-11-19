import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smile_game/ui/auth_page/login_page/login_cubit.dart';
import 'package:smile_game/ui/auth_page/login_page/login_view.dart';
import 'package:smile_game/ui/home_page/game_view/game_view.dart';
import 'package:smile_game/ui/home_page/game_view/select_difficulty_view.dart';
import 'package:smile_game/ui/home_page/home_page_cubit.dart';

class HomePageProvider extends BlocProvider<HomePageCubit> {
  HomePageProvider({
    Key? key,
  }) : super(
    key: key,
    create: (context) => HomePageCubit(context),
    child:  const SelectDifficultyView(),
  );
}
