import 'package:flutter/material.dart';
import '../constants/app_colors.dart';

/// App theme configuration for Light and Dark modes
class AppTheme {
  AppTheme._();

  /// Light theme configuration
  static ThemeData get lightTheme => ThemeData(
        useMaterial3: true,
        brightness: Brightness.light,
        scaffoldBackgroundColor: AppColors.lightBackground,
        colorScheme: const ColorScheme.light(
          primary: AppColors.primaryMaroon,
          secondary: AppColors.primaryMaroon,
          surface: AppColors.lightBackground,
          onPrimary: AppColors.textLight,
          onSecondary: AppColors.textLight,
          onSurface: AppColors.textDark,
        ),
        textTheme: const TextTheme(
          headlineMedium: TextStyle(
            color: AppColors.textDark,
            fontWeight: FontWeight.w600,
            fontSize: 24,
          ),
          titleLarge: TextStyle(
            color: AppColors.textDark,
            fontWeight: FontWeight.w700,
            fontSize: 26,
          ),
        ),
      );

  /// Dark theme configuration
  static ThemeData get darkTheme => ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        scaffoldBackgroundColor: AppColors.darkBackground,
        colorScheme: const ColorScheme.dark(
          primary: AppColors.primaryMaroon,
          secondary: AppColors.quranCircleBorder,
          surface: AppColors.darkBackground,
          onPrimary: AppColors.textLight,
          onSecondary: AppColors.textDark,
          onSurface: AppColors.textLight,
        ),
        textTheme: const TextTheme(
          headlineMedium: TextStyle(
            color: AppColors.textLight,
            fontWeight: FontWeight.w600,
            fontSize: 24,
          ),
          titleLarge: TextStyle(
            color: AppColors.textLight,
            fontWeight: FontWeight.w700,
            fontSize: 26,
          ),
        ),
      );
}
