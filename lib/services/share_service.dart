import 'dart:io';
import 'package:share_plus/share_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/services.dart';

/// Service for sharing videos to social media platforms
class ShareService {
  /// Share video to WhatsApp Status
  static Future<bool> shareToWhatsAppStatus(String videoPath) async {
    try {
      final file = File(videoPath);

      if (!await file.exists()) {
        throw Exception('Video file not found');
      }

      // For WhatsApp Status, we need to copy to a specific directory
      // This is Android-specific
      if (Platform.isAndroid) {
        await _copyToWhatsAppStatusDirectory(file);
        return true;
      } else {
        // On iOS, use share sheet
        await Share.shareXFiles(
          [XFile(videoPath)],
          text: 'Check out my status video created with StatusPro!',
        );
        return true;
      }
    } catch (e) {
      print('Error sharing to WhatsApp Status: $e');
      return false;
    }
  }

  /// Share video to Instagram Stories
  static Future<bool> shareToInstagramStory(String videoPath) async {
    try {
      final file = File(videoPath);

      if (!await file.exists()) {
        throw Exception('Video file not found');
      }

      // Instagram Stories deep link
      const String instagramUrl = 'instagram-stories://share';

      if (Platform.isAndroid) {
        // Use platform channel to share to Instagram
        await _shareToInstagramAndroid(videoPath);
        return true;
      } else if (Platform.isIOS) {
        // Use share sheet for iOS
        await Share.shareXFiles(
          [XFile(videoPath)],
          text: 'Created with StatusPro',
        );
        return true;
      }

      return false;
    } catch (e) {
      print('Error sharing to Instagram: $e');
      return false;
    }
  }

  /// Share video to Facebook
  static Future<bool> shareToFacebook(String videoPath) async {
    try {
      final file = File(videoPath);

      if (!await file.exists()) {
        throw Exception('Video file not found');
      }

      // Generic share for Facebook
      await Share.shareXFiles(
        [XFile(videoPath)],
        text: 'Check out my video created with StatusPro! 🎬',
      );

      return true;
    } catch (e) {
      print('Error sharing to Facebook: $e');
      return false;
    }
  }

  /// Generic share to any app
  static Future<bool> shareVideo(String videoPath, {String? message}) async {
    try {
      final file = File(videoPath);

      if (!await file.exists()) {
        throw Exception('Video file not found');
      }

      await Share.shareXFiles(
        [XFile(videoPath)],
        text: message ?? 'Created with StatusPro - Viral Video Status Maker',
      );

      return true;
    } catch (e) {
      print('Error sharing video: $e');
      return false;
    }
  }

  /// Save video to gallery
  static Future<bool> saveToGallery(String videoPath) async {
    try {
      // Video is already saved in app directory
      // For production, use image_gallery_saver package
      // or move to public directory

      if (Platform.isAndroid) {
        // Copy to Movies/StatusPro directory
        final moviesDir = Directory('/storage/emulated/0/Movies/StatusPro');
        if (!await moviesDir.exists()) {
          await moviesDir.create(recursive: true);
        }

        final file = File(videoPath);
        final fileName = file.uri.pathSegments.last;
        final newPath = '${moviesDir.path}/$fileName';

        await file.copy(newPath);
        return true;
      }

      return true;
    } catch (e) {
      print('Error saving to gallery: $e');
      return false;
    }
  }

  /// Share app link
  static Future<void> shareApp() async {
    const String appName = 'StatusPro';
    const String playStoreUrl = 'https://play.google.com/store/apps/details?id=com.statuspro.app';
    // Replace with actual Play Store link once published

    await Share.share(
      'Create amazing status videos with $appName! 🎬✨\n\n'
      'Download now: $playStoreUrl\n\n'
      '#StatusPro #VideoMaker #WhatsAppStatus #InstagramStories',
      subject: 'Check out $appName!',
    );
  }

  /// Copy video to WhatsApp Status directory (Android)
  static Future<void> _copyToWhatsAppStatusDirectory(File videoFile) async {
    try {
      // WhatsApp Status directory on Android
      final whatsappDir = Directory('/storage/emulated/0/WhatsApp/Media/.Statuses');

      if (!await whatsappDir.exists()) {
        // Try alternative path
        final altDir = Directory('/storage/emulated/0/Android/media/com.whatsapp/WhatsApp/Media/.Statuses');
        if (!await altDir.exists()) {
          throw Exception('WhatsApp Status directory not found');
        }
      }

      final fileName = videoFile.uri.pathSegments.last;
      final newPath = '${whatsappDir.path}/$fileName';

      await videoFile.copy(newPath);
    } catch (e) {
      print('Error copying to WhatsApp directory: $e');
      rethrow;
    }
  }

  /// Share to Instagram on Android using platform channel
  static Future<void> _shareToInstagramAndroid(String videoPath) async {
    // This would require platform-specific code
    // For now, fall back to generic share
    await Share.shareXFiles([XFile(videoPath)]);
  }
}
