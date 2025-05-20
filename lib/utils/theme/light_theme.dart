import 'package:flutter/material.dart';
import 'package:myegym/utils/app_constants.dart';

ThemeData light = ThemeData(
  useMaterial3: false,
  fontFamily: AppConstants.fontFamily,
  primaryColor: const Color(0xFF8E1616),
  scaffoldBackgroundColor: Color(0xFF0E0E0E),
  secondaryHeaderColor: const Color(0xFF000743),
  disabledColor: const Color(0xFF000000),
  brightness: Brightness.light,
  progressIndicatorTheme: const ProgressIndicatorThemeData(
    color: Colors.red, // 👈 Your desired progress color
  ),
  highlightColor: Color(0xffF34E3A),
  dividerColor: Color(0xffFFFFFF),
  hintColor: Colors.white.withOpacity(0.60),
  cardColor: Colors.white,
  textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(foregroundColor: const Color(0xFF3B9EFB))),
  colorScheme: const ColorScheme.light(
          primary: Color(0xFF3B9EFB), secondary: Color(0xFF3B9EFB))
      .copyWith(error: const Color(0xFF3B9EFB)),
);
const Color redColor = Colors.redAccent;
const Color brownColor = Color(0xff977663);
const Color greenColor = Color(0xff5BC679);
const Color greyColor = Color(0xff83A2AF);
const Color skyColor = Color(0xff46C8D0);
const Color darkBlueColor = Color(0xff517DA5);
const Color darkPinkColor = Color(0xffBC6868);
