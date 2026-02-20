import 'package:flutter/material.dart';

abstract class AppColors {
  // Primary Palette
  static const primary = Color(0xFFD4AF37); // Gold
  static const primaryDark = Color(0xFFC5A028);
  static const primaryLight = Color(0xFFFFD700);

  // Secondary Palette
  static const secondary = Color(0xFF1A1A1A); // Deep Navy/Black
  static const background = Color(0xFFF9F9F9); // Soft White/Cream
  static const surface = Colors.white;

  // Text Colors
  static const textPrimary = Color(0xFF1A1A1A);
  static const textSecondary = Color(0xFF757575);

  // Success/Error
  static const success = Color(0xFF4CAF50);
  static const error = Color(0xFFE53935);

  // Dark Theme Colors
  static const backgroundDark = Color(0xFF1A1A1A);
  static const surfaceDark = Color(0xFF2C2C2C);
  static const textPrimaryDark = Colors.white;
  static const textSecondaryDark = Color(0xFFB3B3B3);

  static const white = Colors.white;
  static const black = Colors.black;
}
