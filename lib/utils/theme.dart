import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData light() {
    final ThemeData lightTheme = ThemeData.light();
    return lightTheme.copyWith(
        textTheme: lightTheme.textTheme.apply(fontFamily: 'Poppins'));
  }

  static ThemeData dark() {
    final ThemeData darkTheme = ThemeData.dark();
    return darkTheme.copyWith(
        textTheme: darkTheme.textTheme.apply(fontFamily: 'Poppins'));
  }
}
