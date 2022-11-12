import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smile_game/theme/styled_colors.dart';


abstract class PrimaryTheme {
  PrimaryTheme._();

  static ThemeData generateTheme(BuildContext context) {
    return ThemeData(
      snackBarTheme: const SnackBarThemeData(actionTextColor: Colors.white),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        selectedLabelStyle: TextStyle(color: StyledColors.primaryColor),
        unselectedLabelStyle: TextStyle(color:Colors.red),
      ),
      brightness: Brightness.light,
      primaryColorBrightness: Brightness.light,
      // inputDecorationTheme: InputDecorationTheme(
      //   labelStyle: const TextStyle(color: StyledColors.primaryColor,fontSize: 17),
      //   hintStyle: const TextStyle(color:  StyledColors.primaryColor, fontSize: 17),
      //   filled: true,
      //   fillColor: StyledColors.primaryColor.withOpacity(0.3),
      //   focusedBorder: OutlineInputBorder(
      //     borderRadius: const BorderRadius.all(const Radius.circular(10.0)),
      //     borderSide: BorderSide(color: StyledColors.primaryColor.withOpacity(0.3), width: 1),
      //   ),
      //   alignLabelWithHint: false,
      //
      //   enabledBorder: OutlineInputBorder(
      //     borderRadius: const BorderRadius.all(Radius.circular(10.0)),
      //     borderSide: BorderSide(color: StyledColors.primaryColor.withOpacity(0.3), width: 1),
      //   ),
      //
      // ),
      textTheme: GoogleFonts.cabinTextTheme(
        Theme.of(context).textTheme,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          elevation: 0,
          primary: StyledColors.primaryColor,
          shape: const StadiumBorder(),
          maximumSize: const Size(double.infinity, 56),
          minimumSize: const Size(double.infinity, 56),
        ),
      ),
      inputDecorationTheme: const InputDecorationTheme(
        filled: true,
        fillColor: StyledColors.primaryLight,
        iconColor: StyledColors.primaryColor,
        prefixIconColor: StyledColors.primaryColor,
        contentPadding: EdgeInsets.symmetric(
            horizontal: 16, vertical: 16),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(30)),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
