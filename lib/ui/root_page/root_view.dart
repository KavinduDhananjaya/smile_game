import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smile_game/ui/root_page/root_cubit.dart';
import 'package:smile_game/util/routes.dart';


class RootView extends StatelessWidget {
  final String? email;
  final bool fromSignUp;

  RootView({
    Key? key,
    this.email,
    this.fromSignUp = false,
  }) : super(key: key);

  static const loadingWidget = Center(
    child: CircularProgressIndicator(),
  );

  @override
  Widget build(BuildContext context) {
    final rootCubit = BlocProvider.of<RootCubit>(context);

    const scaffold = Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );

    if (email == null) {
      Future.microtask(
            () => Navigator.pushReplacementNamed(context, Routes.LOGIN_ROUTE),
      );
    }

    if (email != null && !rootCubit.state.userLogged) {
      rootCubit.handleUserLogged(email!);
    }

    if (email != null) {
      Future.microtask(
              () => Navigator.pushReplacementNamed(context, Routes.HOME_ROUTE));
    }

    return scaffold;
  }
}
