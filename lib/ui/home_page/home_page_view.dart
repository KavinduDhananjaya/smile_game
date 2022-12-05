import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smile_game/ui/home_page/game_view/game_view.dart';
import 'package:smile_game/ui/home_page/home_page_cubit.dart';
import 'package:smile_game/ui/home_page/home_page_provider.dart';
import 'package:smile_game/ui/root_page/root_cubit.dart';
import 'package:smile_game/ui/root_page/root_state.dart';
import 'package:smile_game/ui/widgets/context_extension.dart';
import 'package:smile_game/ui/widgets/leader.dart';
import 'package:smile_game/ui/widgets/reusable_widgets.dart';
import 'package:smile_game/util/routes.dart';
import 'game_view/leaderboard_view.dart';

class HomePageView extends StatelessWidget {
  const HomePageView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final rootCubit = BlocProvider.of<RootCubit>(context);



    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xff1F1147), Color(0xff362679)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          actions: [
            IconButton(
              iconSize: 20,
              color: const Color(0xff14154F),
              onPressed: () {
                _showDialog(context);
              },
              icon: const Icon(
                Icons.info,
                size: 30,
                color: Colors.white,
              ),
            ),
          ],
        ),
        drawer: Drawer(
          elevation: 10,
          backgroundColor: const Color(0xff1F1147),
          // Add a ListView to the drawer. This ensures the user can scroll
          // through the options in the drawer if there isn't enough vertical
          // space to fit everything.
          child: ListView(
            // Important: Remove any padding from the ListView.
            padding: EdgeInsets.zero,
            children: [
              const DrawerHeader(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xff1F1147), Color(0xff362679)],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
                child: Text(
                  'Smile Game',
                  style: TextStyle(color: Colors.white, fontSize: 34),
                ),
              ),
              ListTile(
                leading: const Icon(
                  Icons.person,
                  size: 30,
                  color: Colors.white,
                ),
                title: const Text(
                  'Profile',
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
                onTap: () {
                  // Update the state of the app.
                  // ...
                },
              ),
              ListTile(
                leading: const Icon(
                  Icons.stacked_bar_chart,
                  size: 30,
                  color: Colors.white,
                ),
                title: const Text(
                  'Leaderboard',
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return const LeaderboardView();
                      },
                    ),
                  );
                },
              ),
              ListTile(
                leading: const Icon(
                  Icons.exit_to_app,
                  size: 30,
                  color: Colors.redAccent,
                ),
                title: const Text(
                  'Logout',
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
                onTap: () {
                  rootCubit.handleUserLoggedOut();
                  Navigator.pushNamedAndRemoveUntil(
                      context, Routes.LOGIN_ROUTE, (route) => false);
                },
              )
            ],
          ),
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(
              vertical: context.dynamicHeight(0.1),
              horizontal: context.dynamicWidth(0.1)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              LogoImage(),
              const Spacer(
                flex: 3,
              ),
              BlocBuilder<RootCubit, RootState>(
                  buildWhen: (pre, current) =>
                      pre.currentUser != current.currentUser ||
                      pre.rank != current.rank,
                  builder: (context, snapshot) {
                    return Row(
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
                                  '${snapshot.currentUser?.score ?? 0}',
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline5
                                      ?.copyWith(
                                          color: const Color(0xffFF5ED2),
                                          fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  "Marks",
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
                                  '${snapshot.rank == -1 ? '-' : snapshot.rank}',
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
                    );
                  }),
              const Spacer(
                flex: 3,
              ),
              const Leader(),
              const Spacer(
                flex: 4,
              ),
              BlocBuilder<RootCubit, RootState>(
                  buildWhen: (pre, current) =>
                      pre.currentUser != current.currentUser,
                  builder: (context, state) {
                    return SizedBox(
                      height: context.dynamicHeight(0.09),
                      width: context.dynamicWidth(0.8),
                      child: InkWell(
                        onTap: () {
                          if (state.currentUser?.difficulty == -1) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => HomePageProvider(),
                              ),
                            );
                          } else {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    BlocProvider<HomePageCubit>(
                                  create: (context) => HomePageCubit(context),
                                  child: const GameView(),
                                ),
                              ),
                            );
                          }
                        },
                        child: Card(
                          color: const Color(0xff26CE55),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15)),
                          child: Center(
                            child: Text(
                              "Play",
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
                    );
                  }),
            ],
          ),
        ),
      ),
    );
  }

  Expanded LogoImage() {
    return Expanded(
        flex: 10, child: ReusableWidgets.getImageAsset("logo_shadow.png"));
  }

  _showDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20))),
            backgroundColor: const Color(0xff14154F),
            title: Column(
              children: [
                Text(
                  "How to play",
                  style: GoogleFonts.montserrat(
                      textStyle: Theme.of(context).textTheme.headline4,
                      color: const Color(0xff595CFF),
                      fontWeight: FontWeight.w600),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 10,
                ),
                const Divider(
                  height: 2,
                  thickness: 2,
                  color: const Color(0xff595CFF),
                )
              ],
            ),
            content: const Text(
              "Onurhan KAYA\nSelçuk Üniversitesi 3.Sınıf\n\nKaan Güler\nKocaeli Üniversitesi 3.Sınıf\n\nDurmuş Cem Koca\nKocaeli Üniversitesi 4.Sınıf\n\nÇiğdem Bircan\nPamukkale Üniversitesi 4.Sınıf\n\nAvni Burak Çıtlak\nBilgi Üniversitesi 4.Sınıf",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white),
            ),
            actions: <Widget>[
              FlatButton(
                child: const Text(
                  "Ok",
                  style: TextStyle(color: Color(0xff00B2FF), fontSize: 20),
                ),
                onPressed: () {
                  //Navigator.pushNamed(context, "/screen1");
                  Navigator.pop(context);
                },
              ),
            ],
          );
        });
  }
}
