import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:smile_game/theme/styled_colors.dart';

class SocalIcon extends StatelessWidget {
  final String? iconSrc;
  final Function? press;
  const SocalIcon({
    Key? key,
    this.iconSrc,
    this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press as void Function()?,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          border: Border.all(
            width: 2,
            color: StyledColors.primaryLight,
          ),
          shape: BoxShape.circle,
        ),
        child: SvgPicture.asset(
          iconSrc!,
          height: 20,
          width: 20,
          color: Colors.white,
        ),
      ),
    );
  }
}
