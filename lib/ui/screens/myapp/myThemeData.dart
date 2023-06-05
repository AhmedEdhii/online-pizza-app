import 'package:flutter/material.dart';
import 'package:online_pizza/constant/colors.dart';
import 'package:online_pizza/constant/styles.dart';

class MyThemeData {
  ThemeData themedata = ThemeData(
      snackBarTheme: SnackBarThemeData(
        backgroundColor: Color.fromARGB(255, 28, 28, 30),
        actionTextColor: Colors.white,
        contentTextStyle: Styles.buttonText,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        behavior: SnackBarBehavior.floating,
      ),
      colorScheme: ColorScheme.fromSeed(
        seedColor: MyColors.primaryColor,
        primary: MyColors.primaryColor, //<-- SEE HERE
      ),
      textButtonTheme: TextButtonThemeData(
        style: ButtonStyle(
          overlayColor:
              MaterialStateProperty.all(const Color.fromARGB(18, 0, 0, 0)),
        ),
      ),
      scaffoldBackgroundColor: Colors.white,
      textSelectionTheme: const TextSelectionThemeData(
        cursorColor: MyColors.primaryColor,
      ),
      appBarTheme: AppBarTheme(
        elevation: 1, // This removes the shadow from all App Bars.
      ));
}
