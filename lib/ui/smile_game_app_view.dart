import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smile_game/theme/primary_theme.dart';
import 'package:smile_game/theme/styled_colors.dart';
import 'package:smile_game/ui/auth_page/login_page/login_view.dart';
import 'package:smile_game/ui/root_page/root_cubit.dart';
import 'package:smile_game/ui/root_page/root_view.dart';
import 'package:smile_game/util/routes.dart';



class SmileGameAppView extends StatelessWidget {

  const SmileGameAppView(
      this.email,
      );

  final String? email;

  @override
  Widget build(BuildContext context) {

    final materialApp = MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Smile Game",
      theme: PrimaryTheme.generateTheme(context),
      onGenerateRoute: Routes.generator,
      home: RootView(email: email,),
    );


    return MultiBlocProvider(
      providers: <BlocProvider>[
        BlocProvider<RootCubit>(create: (context) => RootCubit(context)),
      ],
      child: materialApp,
    );
  }
}
