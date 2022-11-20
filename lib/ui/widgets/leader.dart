import 'package:flutter/material.dart';

import '../home_page/game_view/leaderboard_view.dart';

class Leader extends StatelessWidget {
  const Leader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return  const LeaderboardView();
            },
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20),
        padding: const EdgeInsets.symmetric(horizontal: 20),
        width: double.infinity,
        height: 100,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Row(
          children: <Widget>[
            SizedBox(
              width: 100,
              child: Stack(
                children: const [
                  // Positioned(
                  //   left: 40,
                  //   child: CircleAvatar(
                  //     backgroundImage: AssetImage(
                  //         'assets/images/avatar.png'),
                  //     radius: 25,
                  //   ),
                  // ),
                  Positioned(
                    left: 20,
                    child: CircleAvatar(
                      backgroundImage: AssetImage(
                          'assets/images/categories_bg.png'),
                      radius: 25,
                    ),
                  ),
                  CircleAvatar(
                    backgroundImage: AssetImage(
                              'assets/images/edit_profile_bg.png'),
                    radius: 25,
                  ),
                ],
              ),
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    'Leaderboard',
                    style: TextStyle(
                      fontSize: 23,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  Text(
                    'see player rank',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: Color(0xff767070)),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
