import 'package:flutter/material.dart';
import '../values/app_colors.dart';

class AppTheme {
  static final lightTheme = ThemeData(
    primaryColor: AppColors.primary,
    scaffoldBackgroundColor: AppColors.background,
    colorScheme: ColorScheme.light(
      primary: AppColors.primary,
      secondary: AppColors.secondary,
      surface: AppColors.surface,
      onPrimary: AppColors.white,
      onSecondary: AppColors.white,
      onSurface: AppColors.textPrimary,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.secondary,
      iconTheme: IconThemeData(color: AppColors.primary),
      titleTextStyle: TextStyle(
        color: AppColors.primary,
        fontSize: 20,
        fontWeight: FontWeight.bold,
        letterSpacing: 1.2,
      ),
      centerTitle: true,
      elevation: 0,
    ),
    textTheme: const TextTheme(
      displayLarge: TextStyle(
        color: AppColors.textPrimary,
        fontWeight: FontWeight.bold,
        letterSpacing: 1.5,
      ),
      bodyLarge: TextStyle(color: AppColors.textPrimary),
      bodyMedium: TextStyle(color: AppColors.textSecondary),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.white,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    ),
    visualDensity: VisualDensity.adaptivePlatformDensity,
  );

  static final darkTheme = ThemeData(
    primaryColor: AppColors.primary,
    scaffoldBackgroundColor: AppColors.backgroundDark,
    brightness: Brightness.dark,
    colorScheme: ColorScheme.dark(
      primary: AppColors.primary,
      secondary:
          AppColors.primary, // Gold as secondary in dark mode for contrast
      surface: AppColors.surfaceDark,
      onPrimary: AppColors.black,
      onSecondary: AppColors.black,
      onSurface: AppColors.textPrimaryDark,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.backgroundDark,
      iconTheme: IconThemeData(color: AppColors.primary),
      titleTextStyle: TextStyle(
        color: AppColors.primary,
        fontSize: 20,
        fontWeight: FontWeight.bold,
        letterSpacing: 1.2,
      ),
      centerTitle: true,
      elevation: 0,
    ),
    textTheme: const TextTheme(
      displayLarge: TextStyle(
        color: AppColors.textPrimaryDark,
        fontWeight: FontWeight.bold,
        letterSpacing: 1.5,
      ),
      bodyLarge: TextStyle(color: AppColors.textPrimaryDark),
      bodyMedium: TextStyle(color: AppColors.textSecondaryDark),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.black, // Black text on Gold button
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    ),
    visualDensity: VisualDensity.adaptivePlatformDensity,
  );
}
