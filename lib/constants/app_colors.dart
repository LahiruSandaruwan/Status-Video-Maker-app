import 'package:flutter/material.dart';

/// App Colors (extracted from app_constants.dart for cleaner imports)
class AppColors {
  // Primary Gradient
  static const Color primaryPurple = Color(0xFF8B5CF6);
  static const Color primaryPink = Color(0xFFEC4899);
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [primaryPurple, primaryPink],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  // Secondary
  static const Color secondaryOrange = Color(0xFFF59E0B);
  static const Color secondaryYellow = Color(0xFFFBBF24);

  // Background
  static const Color darkBackground = Color(0xFF1F2937);
  static const Color darkSurface = Color(0xFF374151);
  static const Color darkCard = Color(0xFF4B5563);

  // Light Theme
  static const Color lightBackground = Color(0xFFF9FAFB);
  static const Color lightSurface = Color(0xFFFFFFFF);
  static const Color lightCard = Color(0xFFF3F4F6);

  // Text
  static const Color textPrimary = Color(0xFFFFFFFF);
  static const Color textSecondary = Color(0xFFD1D5DB);
  static const Color textTertiary = Color(0xFF9CA3AF);
  static const Color textDark = Color(0xFF1F2937);

  // Accent Colors
  static const Color success = Color(0xFF10B981);
  static const Color error = Color(0xFFEF4444);
  static const Color warning = Color(0xFFF59E0B);
  static const Color info = Color(0xFF3B82F6);

  // Category Colors
  static const Color categoryLove = Color(0xFFFF6B9D);
  static const Color categoryMotivational = Color(0xFF00C9FF);
  static const Color categoryBirthday = Color(0xFFFFB800);
  static const Color categoryLyrics = Color(0xFF9D50BB);
  static const Color categoryPhoto = Color(0xFF00D084);
  static const Color categoryTrending = Color(0xFFFF6B6B);
}
