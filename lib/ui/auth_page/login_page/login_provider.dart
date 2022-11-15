import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smile_game/ui/auth_page/login_page/login_cubit.dart';
import 'package:smile_game/ui/auth_page/login_page/login_view.dart';

class LoginProvider extends BlocProvider<LoginCubit> {
  LoginProvider({
    Key? key,
  }) : super(
    key: key,
    create: (context) => LoginCubit(context),
    child:  const LoginView(),
  );
}
