import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smile_game/ui/widgets/context_extension.dart';

import '../../../theme/text_constants.dart';

class LeaderboardView extends StatelessWidget {
  const LeaderboardView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        backgroundColor: const Color(0xff1F1147),
        elevation: 0,
        title: Text(
          'Leaderboard',
          style: TextConstants.leaderboardAppBarTextStyle(context),
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xff1F1147), Color(0xff362679)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          children: [
            SizedBox(height: context.dynamicHeight(0.05)),
            Expanded(
              flex: 1,
              child: Stack(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [FirstPlayer('names', 'scores', 'avatar')],
                  ),
                  Positioned(
                    top: 100,
                    left: .0,
                    right: .0,
                    child: Row(
                      children: [
                        const Spacer(),
                        SecondPlayer('', 'scores', 'avatar'),
                        const Spacer(
                          flex: 2,
                        ),
                        ThirdPlayer('names', 'scores', 'avatar'),
                        const Spacer(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: Container(
                      decoration: const BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Colors.deepPurple,
                              Colors.deepPurpleAccent,
                            ],
                            begin: FractionalOffset(0.0, 0.0),
                            end: FractionalOffset(0.0, 1.0),
                            stops: [0.0, 1.0],
                            tileMode: TileMode.clamp,
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                      width: context.contextWidth(),
                      height: 68,
                      child: Row(
                        children: [
                          const Spacer(),
                          Text(
                            '3',
                            style: TextConstants.leaderboardUserTextStyleGreen(
                                context),
                          ),
                          const Spacer(),
                          CircleAvatar(
                            radius: 26,
                            backgroundColor: const Color(0xffA6BAFC),
                            child: CircleAvatar(
                              backgroundColor: Colors.transparent,
                              child: Image.asset(
                                'assets/images/avatar.png',
                              ),
                              radius: 21,
                            ),
                          ),
                          const Spacer(),
                          Text(
                            "User Name",
                            style: GoogleFonts.openSans(
                                color: const Color(0xffE8E8E8),
                                fontWeight: FontWeight.w700,
                                fontSize: 20),
                          ),
                          const Spacer(
                            flex: 5,
                          ),
                          const Align(
                            alignment: Alignment.centerRight,
                            child: const Text(
                              '#001',
                            ),
                          ),
                          const Spacer(),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: context.dynamicHeight(0.02)),
                  Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: Container(
                      decoration: const BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Colors.deepPurple,
                              Colors.deepPurpleAccent,
                            ],
                            begin: FractionalOffset(0.0, 0.0),
                            end: FractionalOffset(0.0, 1.0),
                            stops: [0.0, 1.0],
                            tileMode: TileMode.clamp,
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                      width: context.contextWidth(),
                      height: 68,
                      child: Row(
                        children: [
                          const Spacer(),
                          Text(
                            '3',
                            style: TextConstants.leaderboardUserTextStyleGreen(
                                context),
                          ),
                          const Spacer(),
                          CircleAvatar(
                            radius: 26,
                            backgroundColor: const Color(0xffA6BAFC),
                            child: CircleAvatar(
                              backgroundColor: Colors.transparent,
                              child: Image.asset(
                                'assets/images/avatar.png',
                              ),
                              radius: 21,
                            ),
                          ),
                          const Spacer(),
                          Text(
                            "User Name",
                            style: GoogleFonts.openSans(
                                color: const Color(0xffE8E8E8),
                                fontWeight: FontWeight.w700,
                                fontSize: 20),
                          ),
                          const Spacer(
                            flex: 5,
                          ),
                          const Align(
                            alignment: Alignment.centerRight,
                            child: const Text(
                              '#001',
                            ),
                          ),
                          const Spacer(),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: context.dynamicHeight(0.02)),
                  Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: Container(
                      decoration: const BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Colors.deepPurple,
                              Colors.deepPurpleAccent,
                            ],
                            begin: FractionalOffset(0.0, 0.0),
                            end: FractionalOffset(0.0, 1.0),
                            stops: [0.0, 1.0],
                            tileMode: TileMode.clamp,
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                      width: context.contextWidth(),
                      height: 68,
                      child: Row(
                        children: [
                          const Spacer(),
                          Text(
                            '3',
                            style: TextConstants.leaderboardUserTextStyleGreen(
                                context),
                          ),
                          const Spacer(),
                          CircleAvatar(
                            radius: 26,
                            backgroundColor: const Color(0xffA6BAFC),
                            child: CircleAvatar(
                              backgroundColor: Colors.transparent,
                              child: Image.asset(
                                'assets/images/avatar.png',
                              ),
                              radius: 21,
                            ),
                          ),
                          const Spacer(),
                          Text(
                            "User Name",
                            style: GoogleFonts.openSans(
                                color: const Color(0xffE8E8E8),
                                fontWeight: FontWeight.w700,
                                fontSize: 20),
                          ),
                          const Spacer(
                            flex: 5,
                          ),
                          const Align(
                            alignment: Alignment.centerRight,
                            child: const Text(
                              '#001',
                            ),
                          ),
                          const Spacer(),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Expanded FirstPlayer(names, scores, avatar) {
  return Expanded(
    child: Column(
      children: [
        Stack(
          children: [
            Container(
              margin: const EdgeInsets.only(top: 20),
              child: CircleAvatar(
                radius: 68,
                backgroundColor: const Color(0xffFFE54D),
                child: CircleAvatar(
                  radius: 65,
                  backgroundColor: const Color(0xff86A0FA),
                  child: CircleAvatar(
                    backgroundColor: Colors.transparent,
                    radius: 50,
                    child: Image.asset('assets/images/avatar.png'),
                  ),
                ),
              ),
            ),
            Positioned(
              top: .0,
              left: .0,
              right: .0,
              child: Center(
                child: CircleAvatar(
                  backgroundColor: const Color(0xffFFCC4D),
                  radius: 19,
                  child: CircleAvatar(
                    radius: 15,
                    child: Text(
                      "1",
                      style: GoogleFonts.openSans(
                          fontSize: 20,
                          color: const Color(0xffF99D26),
                          fontWeight: FontWeight.bold),
                    ),
                    backgroundColor: const Color(0xffFDE256),
                  ),
                ),
              ),
            )
          ],
        ),
        Text(
          'Name 1',
          style: GoogleFonts.openSans(
              color: const Color(0xffE8E8E8),
              fontWeight: FontWeight.w700,
              fontSize: 20),
        ),
        Text(
          '1000',
          style: GoogleFonts.openSans(
            color: const Color(0xffE8E8E8),
            fontWeight: FontWeight.w700,
            fontSize: 20,
          ),
        ),
      ],
    ),
  );
}

Column ThirdPlayer(names, scores, avatar) {
  return Column(
    children: [
      Stack(
        children: [
          Container(
            margin: const EdgeInsets.only(top: 20),
            child: CircleAvatar(
              radius: 48,
              backgroundColor: const Color(0xff8B5731),
              child: CircleAvatar(
                radius: 45,
                backgroundColor: const Color(0xffF5A6FC),
                child: CircleAvatar(
                  radius: 33,
                  backgroundColor: Colors.transparent,
                  child: Image.asset('assets/images/avatar.png'),
                ),
              ),
            ),
          ),
          Positioned(
            top: .0,
            left: .0,
            right: .0,
            child: Center(
              child: CircleAvatar(
                radius: 19,
                backgroundColor: const Color(0xff8B5731),
                child: CircleAvatar(
                  radius: 15,
                  child: Text(
                    "3",
                    style: GoogleFonts.openSans(
                        fontSize: 20,
                        color: const Color(0xff8B5731),
                        fontWeight: FontWeight.bold),
                  ),
                  backgroundColor: const Color(0xffBF7540),
                ),
              ),
            ),
          )
        ],
      ),
      Text(
        'Name 2',
        style: GoogleFonts.openSans(
            color: const Color(0xffE8E8E8),
            fontWeight: FontWeight.w700,
            fontSize: 20),
      ),
      Text(
        '500',
        style: GoogleFonts.openSans(
            color: const Color(0xffE8E8E8),
            fontWeight: FontWeight.w700,
            fontSize: 20),
      ),
    ],
  );
}

Column SecondPlayer(names, scores, avatar) {
  return Column(
    children: [
      Stack(
        children: [
          Container(
            margin: const EdgeInsets.only(top: 20),
            child: CircleAvatar(
              radius: 48,
              backgroundColor: const Color(0xffCED5E0),
              child: CircleAvatar(
                radius: 45,
                backgroundColor: const Color(0xff26CE55),
                child: CircleAvatar(
                  backgroundColor: Colors.transparent,
                  radius: 33,
                  child: Image.asset('assets/images/avatar.png'),
                ),
              ),
            ),
          ),
          Positioned(
            top: .0,
            left: .0,
            right: .0,
            child: Center(
              child: CircleAvatar(
                backgroundColor: const Color(0xffCED5E0),
                radius: 19,
                child: CircleAvatar(
                  radius: 15,
                  child: Text(
                    "2",
                    style: GoogleFonts.openSans(
                        fontSize: 20,
                        color: const Color(0xffB3BAC3),
                        fontWeight: FontWeight.bold),
                  ),
                  backgroundColor: const Color(0xffEFF1F4),
                ),
              ),
            ),
          )
        ],
      ),
      Text(
        "Name 3",
        style: GoogleFonts.openSans(
            color: const Color(0xffE8E8E8),
            fontWeight: FontWeight.w700,
            fontSize: 20),
      ),
      Text(
        '233',
        style: GoogleFonts.openSans(
            color: const Color(0xffE8E8E8),
            fontWeight: FontWeight.w700,
            fontSize: 20),
      ),
    ],
  );
}
