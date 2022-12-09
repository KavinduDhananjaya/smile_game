import 'package:flutter/material.dart';
import 'package:smile_game/ui/home_page/game_view/game_view.dart';

class CustomStack extends StatelessWidget {
  const CustomStack({
    required this.image,
    required this.text1,
    required this.padding_top,
    required this.padding_left,
    required this.padding,
    required this.color,


  });

  final String image;
  final String text1;
  final double padding_top;
  final double padding_left;
  final double padding;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: padding_top),
      child: Container(
        alignment: Alignment.center,
        width: 250,
        // height: 100,
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(20)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            // const Spacer(),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Text(
                text1,
                style: const TextStyle(
                  color: Color(0xff2D2D2D),
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
