import 'package:flutter/material.dart';
import 'package:smile_game/theme/styled_colors.dart';

class AppSnackBar {
  static final loadingSnackBar = SnackBar(
    content: Row(
      children: const <Widget>[
        CircularProgressIndicator(),
        SizedBox(width: 10.0),
        Text(
          "Loading...",
          style: TextStyle(color: Colors.white),
        ),
      ],
    ),
    backgroundColor: StyledColors.primaryColor,
    duration: const Duration(seconds: 14),
  );

  static SnackBar showErrorSnackBar(String error) {
    return SnackBar(
      content: Row(
        children: [
          const SizedBox(
            height: 28,
          ),
          Expanded(
            child: Text(
              error,
              maxLines: 4,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
      backgroundColor: Colors.redAccent,
      duration: const Duration(seconds: 2),
    );
  }

  static SnackBar showSnackBar(String text) {
    return SnackBar(
      content: Row(
        children: [
          const SizedBox(
            height: 28,
          ),
          Expanded(
            child: Text(
              text,
              maxLines: 4,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
      backgroundColor: StyledColors.primaryColor,
      behavior: SnackBarBehavior.floating,
      duration: const Duration(seconds: 3),
    );
  }
}
