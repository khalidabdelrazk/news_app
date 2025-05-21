import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news/core/theme/app_colors.dart';

class AppTheme {
  static TextStyle lightMedium24 = GoogleFonts.inter(
    color: AppColors.light,
    fontWeight: FontWeight.w500,
    fontSize: 24,
  );

  static TextStyle lightMedium20 = GoogleFonts.inter(
    color: AppColors.light,
    fontWeight: FontWeight.w500,
    fontSize: 20,
  );

  static TextStyle lightGrayMedium12 = GoogleFonts.inter(
    color: AppColors.lightGray,
    fontWeight: FontWeight.w500,
    fontSize: 12,
  );
  static TextStyle lightMedium14 = GoogleFonts.inter(
    color: AppColors.light,
    fontWeight: FontWeight.w500,
    fontSize: 14,
  );

  static TextStyle lightMedium12 = GoogleFonts.inter(
    color: AppColors.light,
    fontWeight: FontWeight.w500,
    fontSize: 12,
  );

  static TextStyle lightBold16 = GoogleFonts.inter(
    color: AppColors.light,
    fontWeight: FontWeight.w700,
    fontSize: 16,
  );

  static TextStyle lightBold20 = GoogleFonts.inter(
    color: AppColors.light,
    fontWeight: FontWeight.w700,
    fontSize: 20,
  );

  static TextStyle darkMedium24 = GoogleFonts.inter(
    color: AppColors.dark,
    fontWeight: FontWeight.w500,
    fontSize: 24,
  );

  static TextStyle darkMedium20 = GoogleFonts.inter(
    color: AppColors.dark,
    fontWeight: FontWeight.w500,
    fontSize: 20,
  );

  static TextStyle darkMedium14 = GoogleFonts.inter(
    color: AppColors.dark,
    fontWeight: FontWeight.w500,
    fontSize: 14,
  );

  static TextStyle darkMedium12 = GoogleFonts.inter(
    color: AppColors.dark,
    fontWeight: FontWeight.w500,
    fontSize: 12,
  );

  static TextStyle darkBold16 = GoogleFonts.inter(
    color: AppColors.dark,
    fontWeight: FontWeight.w700,
    fontSize: 16,
  );

  static TextStyle darkBold20 = GoogleFonts.inter(
    color: AppColors.dark,
    fontWeight: FontWeight.w700,
    fontSize: 20,
  );

  ThemeData lightTheme = ThemeData(
    scaffoldBackgroundColor: AppColors.light,
    fontFamily: GoogleFonts.inter().fontFamily,
    primaryColor: AppColors.dark,
    indicatorColor: AppColors.lightGray,
    cardColor: AppColors.light,
    colorScheme: ColorScheme(
      brightness: Brightness.light,
      primary: AppColors.dark,
      onPrimary: AppColors.dark,
      secondary: AppColors.lightGray,
      onSecondary: AppColors.lightGray,
      error: Colors.red,
      onError: Colors.red,
      surface: AppColors.light,
      onSurface: AppColors.light,
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.light,
      elevation: 0,
      centerTitle: true,
      titleTextStyle: darkMedium20,
      iconTheme: IconThemeData(color: AppColors.dark),
    ),
    bottomAppBarTheme: BottomAppBarTheme(color: AppColors.dark),
    textTheme: TextTheme(
      bodySmall: darkMedium14,
      labelSmall: darkMedium12,
      bodyMedium: darkMedium20,
      bodyLarge: darkMedium24,
      headlineSmall: lightGrayMedium12,
    ),
  );

  ThemeData darkTheme = ThemeData(
    scaffoldBackgroundColor: AppColors.dark,
    fontFamily: GoogleFonts.inter().fontFamily,
    primaryColor: AppColors.light,
    indicatorColor: AppColors.lightGray,
    cardColor: AppColors.dark,
    colorScheme: ColorScheme(
      brightness: Brightness.dark,
      primary: AppColors.light,
      onPrimary: AppColors.light,
      secondary: AppColors.lightGray,
      onSecondary: AppColors.lightGray,
      error: Colors.red,
      onError: Colors.red,
      surface: AppColors.dark,
      onSurface: AppColors.dark,
    ),
    appBarTheme: AppBarTheme(
      // color: AppColors.light,
      backgroundColor: AppColors.dark,
      elevation: 0,
      centerTitle: true,
      titleTextStyle: lightMedium20,
      iconTheme: IconThemeData(color: AppColors.light),
    ),
    bottomAppBarTheme: BottomAppBarTheme(color: AppColors.light),
    textTheme: TextTheme(
      bodySmall: lightMedium12,
      labelSmall: lightMedium14,
      bodyMedium: lightMedium20,
      bodyLarge: lightMedium24,
      headlineSmall: lightGrayMedium12,
      displayMedium: darkMedium14
    ),
  );
}
