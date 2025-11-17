import 'package:flutter/material.dart';

/// App-wide constants
class AppConstants {
  // App Info
  static const String appName = 'StatusPro';
  static const String appTagline = 'Create Viral Video Status';
  static const String appVersion = '1.0.0';

  // Video Settings
  static const int defaultVideoDuration = 15; // seconds
  static const int maxVideoDuration = 30; // seconds
  static const int videoWidth = 1080;
  static const int videoHeight = 1920;
  static const int videoFrameRate = 30;

  // Ad Settings
  static const int interstitialAdInterval = 3; // Show after every 3 videos
  static const String adMobAppId = 'ca-app-pub-3940256099942544~3347511713'; // Test ID
  static const String bannerAdUnitId = 'ca-app-pub-3940256099942544/6300978111'; // Test ID
  static const String interstitialAdUnitId = 'ca-app-pub-3940256099942544/1033173712'; // Test ID
  static const String rewardedAdUnitId = 'ca-app-pub-3940256099942544/5224354917'; // Test ID

  // Storage Keys
  static const String hiveBoxName = 'statuspro_box';
  static const String userProjectsBoxName = 'user_projects';
  static const String settingsBoxName = 'settings';

  // Shared Preferences Keys
  static const String keyFirstLaunch = 'first_launch';
  static const String keyVideoQuality = 'video_quality';
  static const String keyDefaultWatermark = 'default_watermark';
  static const String keyNotifications = 'notifications_enabled';
  static const String keyAdCount = 'ad_count';
  static const String keyVideoGenerationCount = 'video_generation_count';

  // File Paths
  static const String videosDirectory = 'StatusPro/Videos';
  static const String thumbnailsDirectory = 'StatusPro/Thumbnails';
  static const String tempDirectory = 'StatusPro/Temp';

  // Watermark Settings
  static const String watermarkText = 'Created with StatusPro';
  static const double watermarkOpacity = 0.7;
  static const double watermarkFontSize = 14.0;

  // Animation Durations
  static const Duration shortAnimation = Duration(milliseconds: 200);
  static const Duration mediumAnimation = Duration(milliseconds: 400);
  static const Duration longAnimation = Duration(milliseconds: 600);

  // Grid Settings
  static const int templateGridColumns = 2;
  static const double templateGridSpacing = 12.0;
  static const double templateGridAspectRatio = 0.7;
}

/// App Colors
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

/// Font Families available in the app
class AppFonts {
  static const List<String> availableFonts = [
    'Poppins',
    'Roboto',
    'Montserrat',
    'Playfair Display',
    'Dancing Script',
    'Pacifico',
    'Bebas Neue',
    'Oswald',
    'Lato',
    'Raleway',
    'Open Sans',
    'Ubuntu',
    'Righteous',
    'Satisfy',
    'Lobster',
    'Merriweather',
    'Nunito',
    'Quicksand',
    'Caveat',
    'Permanent Marker',
  ];
}
