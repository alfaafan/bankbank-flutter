import 'package:flutter/material.dart';

class AppColors{
  static const Color primaryColor = Colors.blueAccent;
  static const Color secondaryColor = Colors.greenAccent;
}

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    colorScheme: ColorScheme.fromSwatch().copyWith(secondary: AppColors.secondaryColor),
    useMaterial3: true,
  );
  static ThemeData darkTheme = ThemeData(
    colorScheme: ColorScheme.fromSwatch().copyWith(secondary: AppColors.secondaryColor),
    useMaterial3: true,
  );
}