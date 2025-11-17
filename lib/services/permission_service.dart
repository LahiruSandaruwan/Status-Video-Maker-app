import 'package:permission_handler/permission_handler.dart';

/// Service for handling app permissions
class PermissionService {
  /// Request storage permission for saving videos
  static Future<bool> requestStoragePermission() async {
    // On Android 13+, use photos/videos permissions
    if (await _isAndroid13OrHigher()) {
      final videos = await Permission.videos.request();
      final photos = await Permission.photos.request();
      return videos.isGranted || photos.isGranted;
    }

    // On older Android, use storage permission
    final status = await Permission.storage.request();
    return status.isGranted;
  }

  /// Request camera permission for taking photos
  static Future<bool> requestCameraPermission() async {
    final status = await Permission.camera.request();
    return status.isGranted;
  }

  /// Request microphone permission (if needed for video recording)
  static Future<bool> requestMicrophonePermission() async {
    final status = await Permission.microphone.request();
    return status.isGranted;
  }

  /// Request notification permission
  static Future<bool> requestNotificationPermission() async {
    final status = await Permission.notification.request();
    return status.isGranted;
  }

  /// Check if storage permission is granted
  static Future<bool> hasStoragePermission() async {
    if (await _isAndroid13OrHigher()) {
      final videos = await Permission.videos.isGranted;
      final photos = await Permission.photos.isGranted;
      return videos || photos;
    }

    return await Permission.storage.isGranted;
  }

  /// Check if camera permission is granted
  static Future<bool> hasCameraPermission() async {
    return await Permission.camera.isGranted;
  }

  /// Request all necessary permissions
  static Future<Map<String, bool>> requestAllPermissions() async {
    final storage = await requestStoragePermission();
    final camera = await requestCameraPermission();

    return {
      'storage': storage,
      'camera': camera,
    };
  }

  /// Open app settings
  static Future<void> openSettings() async {
    await openAppSettings();
  }

  /// Helper to check Android version
  static Future<bool> _isAndroid13OrHigher() async {
    // This is a simplified check
    // In production, you'd use device_info_plus package
    return false; // Default to older permission model
  }
}
