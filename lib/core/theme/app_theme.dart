import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.primary,
        primary: AppColors.primary,
        background: AppColors.background,
      ),
      scaffoldBackgroundColor: AppColors.background,
      textTheme: GoogleFonts.latoTextTheme().copyWith(
        displayLarge: GoogleFonts.quicksand(
          fontSize: 32,
          fontWeight: FontWeight.bold,
          color: AppColors.heading,
        ),
        displayMedium: GoogleFonts.quicksand(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: AppColors.heading,
        ),
        titleLarge: GoogleFonts.quicksand(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: AppColors.heading,
        ),
        bodyLarge: GoogleFonts.lato(
          fontSize: 16,
          color: AppColors.textBody,
        ),
        bodyMedium: GoogleFonts.lato(
          fontSize: 14,
          color: AppColors.textBody,
        ),
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(color: AppColors.heading),
      ),
    );
  }
}
