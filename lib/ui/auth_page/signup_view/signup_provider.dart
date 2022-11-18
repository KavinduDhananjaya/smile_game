import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smile_game/ui/auth_page/signup_view/signup_cubit.dart';
import 'package:smile_game/ui/auth_page/signup_view/signup_view.dart';


class SignUpProvider extends BlocProvider<SignUpCubit> {
  SignUpProvider({
    Key? key,
  }) : super(
          key: key,
          create: (context) => SignUpCubit(context),
          child: const SignUpView(),
        );
}
