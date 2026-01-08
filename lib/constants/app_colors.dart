import 'package:flutter/material.dart';

/// App color constants extracted from Figma design
/// All colors are pixel-perfect matches to the design specification
class AppColors {
  AppColors._();

  // Light Mode Colors
  static const Color lightBackground = Color(0xFFFAFAFA);
  static const Color lightMosqueSilhouette = Color(0xFFE8D5D5);
  
  // Dark Mode Colors
  static const Color darkBackground = Color(0xFF863F47);
  static const Color darkMosqueSilhouette = Color(0xFF6B3038);
  
  // Common Colors
  static const Color primaryMaroon = Color(0xFF863F47);
  static const Color quranCircleBorder = Color(0xFFFFFFFF);
  static const Color quranCircleInner = Color(0xFF672D34);
  static const Color textDark = Color(0xFF672D34);
  static const Color textLight = Color(0xFFFFFFFF);
  static const Color birdColorLight = Color(0xFF663F47);
  static const Color birdColorDark = Color(0xFFFFFFFF);
  
  // Gradient colors for circle
  static const Color circleGradientStart = Color(0xFF9B5A5A);
  static const Color circleGradientEnd = Color(0xFF5C2A2E);
}
