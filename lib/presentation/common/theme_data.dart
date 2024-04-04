import 'package:flutter/material.dart';

class AppColors {
  // Primary color (main branding color)
  static const Color primary = Color(0xFF0000FF); // #0000FF
  static const Color extraLight = Color(0xFF1600CC); // #1600CC
  static const Color blueLight = Color(0xFF110099); // #110099
  static const Color blueMedium = Color(0xFF0B0066); // #0B0066
  static const Color blueDark = Color(0xFF060033); // #060033

  // Custom material color based on primary
  static MaterialColor primaryMaterialColor =
  MaterialColor(primary.value, <int, Color>{
    50: primary.withOpacity(0.1),
    100: primary.withOpacity(0.2),
    200: primary.withOpacity(0.3),
    300: primary.withOpacity(0.4),
    400: primary.withOpacity(0.5),
    500: primary.withOpacity(0.6),
    600: primary.withOpacity(0.7),
    700: primary.withOpacity(0.8),
    800: primary.withOpacity(0.9),
    900: primary.withOpacity(1),
  });
}

// class AppTheme {
//   static ThemeData lightTheme = ThemeData(
//     colorScheme: ColorScheme.fromSwatch().copyWith(secondary: AppColors.secondary),
//     useMaterial3: true,
//   );
//   static ThemeData darkTheme = ThemeData(
//     colorScheme: ColorScheme.fromSwatch().copyWith(secondary: AppColors.secondary),
//     useMaterial3: true,
//   );
// }