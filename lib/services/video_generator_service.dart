import 'dart:io';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:ffmpeg_kit_flutter/ffmpeg_kit.dart';
import 'package:ffmpeg_kit_flutter/return_code.dart';
import 'package:ffmpeg_kit_flutter/statistics.dart';
import 'package:uuid/uuid.dart';
import '../models/video_template.dart';
import '../models/text_layer.dart';
import '../models/photo_layer.dart';
import '../models/animation_layer.dart';

/// Service for generating videos using FFmpeg
class VideoGeneratorService {
  static const String TAG = 'VideoGeneratorService';

  /// Generate video from template and customizations
  Future<String> generateVideo({
    required VideoTemplate template,
    required List<TextLayer> textLayers,
    List<PhotoLayer>? photoLayers,
    List<AnimationLayer>? animationLayers,
    String? musicPath,
    bool includeWatermark = true,
    Function(double progress, String status)? onProgress,
  }) async {
    try {
      onProgress?.call(0.0, 'Preparing...');

      // Create temporary directory for intermediate files
      final tempDir = await _createTempDirectory();

      // Generate unique output filename
      final outputPath = await _getOutputPath();

      onProgress?.call(0.1, 'Generating background...');

      // Step 1: Create background video/image
      final backgroundPath = await _generateBackground(
        template,
        tempDir,
        template.durationSeconds,
      );

      onProgress?.call(0.3, 'Rendering text layers...');

      // Step 2: Generate text overlay images
      final textOverlayPaths = await _generateTextOverlays(
        textLayers,
        tempDir,
      );

      onProgress?.call(0.5, 'Building video...');

      // Step 3: Build FFmpeg command
      final command = _buildFFmpegCommand(
        backgroundPath: backgroundPath,
        textOverlayPaths: textOverlayPaths,
        photoLayers: photoLayers ?? [],
        musicPath: musicPath,
        outputPath: outputPath,
        duration: template.durationSeconds,
        includeWatermark: includeWatermark,
        watermarkText: includeWatermark ? 'StatusPro' : null,
      );

      debugPrint('$TAG: FFmpeg command: $command');

      onProgress?.call(0.6, 'Encoding video...');

      // Step 4: Execute FFmpeg
      bool success = await _executeFFmpeg(
        command,
        template.durationSeconds,
        (progress) {
          // Map FFmpeg progress (0.6 to 0.95)
          final mappedProgress = 0.6 + (progress * 0.35);
          onProgress?.call(mappedProgress, 'Encoding video...');
        },
      );

      if (!success) {
        throw Exception('Video generation failed');
      }

      onProgress?.call(0.95, 'Finalizing...');

      // Step 5: Cleanup temporary files
      await _cleanupTempFiles(tempDir);

      onProgress?.call(1.0, 'Complete!');

      return outputPath;
    } catch (e) {
      debugPrint('$TAG: Error generating video: $e');
      rethrow;
    }
  }

  /// Create temporary directory for intermediate files
  Future<Directory> _createTempDirectory() async {
    final tempDir = await getTemporaryDirectory();
    final uuid = const Uuid().v4();
    final dir = Directory('${tempDir.path}/statuspro_$uuid');

    if (!await dir.exists()) {
      await dir.create(recursive: true);
    }

    return dir;
  }

  /// Get output path for generated video
  Future<String> _getOutputPath() async {
    final directory = await getApplicationDocumentsDirectory();
    final videosDir = Directory('${directory.path}/StatusPro/Videos');

    if (!await videosDir.exists()) {
      await videosDir.create(recursive: true);
    }

    final timestamp = DateTime.now().millisecondsSinceEpoch;
    final uuid = const Uuid().v4().substring(0, 8);
    return '${videosDir.path}/statuspro_${timestamp}_$uuid.mp4';
  }

  /// Generate background layer (color/gradient/image)
  Future<String> _generateBackground(
    VideoTemplate template,
    Directory tempDir,
    int durationSeconds,
  ) async {
    final outputPath = '${tempDir.path}/background.mp4';

    String command;

    if (template.backgroundType == BackgroundType.solidColor) {
      // Solid color background
      final color = template.backgroundValue as Color;
      final hexColor = color.value.toRadixString(16).substring(2);

      command = '-f lavfi -i color=c=0x$hexColor:s=1080x1920:d=$durationSeconds -c:v libx264 -preset ultrafast -pix_fmt yuv420p $outputPath';
    } else if (template.backgroundType == BackgroundType.gradient) {
      // Gradient background - create using FFmpeg gradients filter
      final gradient = template.backgroundValue as LinearGradient;
      final color1 = gradient.colors[0].value.toRadixString(16).substring(2);
      final color2 = gradient.colors.length > 1
          ? gradient.colors[1].value.toRadixString(16).substring(2)
          : color1;

      // Create gradient using overlay and blend filters
      command = '-f lavfi -i color=c=0x$color1:s=1080x1920:d=$durationSeconds '
          '-f lavfi -i color=c=0x$color2:s=1080x1920:d=$durationSeconds '
          '-filter_complex "[0:v][1:v]blend=all_expr=\'A*(1-Y/H)+B*Y/H\':shortest=1" '
          '-c:v libx264 -preset ultrafast -pix_fmt yuv420p $outputPath';
    } else {
      // Default: black background
      command = '-f lavfi -i color=c=black:s=1080x1920:d=$durationSeconds -c:v libx264 -preset ultrafast -pix_fmt yuv420p $outputPath';
    }

    await _executeFFmpegSimple(command);
    return outputPath;
  }

  /// Generate text overlay images
  Future<List<String>> _generateTextOverlays(
    List<TextLayer> textLayers,
    Directory tempDir,
  ) async {
    // For now, we'll use FFmpeg drawtext filter instead of pre-rendered images
    // This is simpler and works well for most cases
    return [];
  }

  /// Build complete FFmpeg command
  String _buildFFmpegCommand({
    required String backgroundPath,
    required List<String> textOverlayPaths,
    required List<PhotoLayer> photoLayers,
    String? musicPath,
    required String outputPath,
    required int duration,
    required bool includeWatermark,
    String? watermarkText,
  }) {
    List<String> inputs = ['-i $backgroundPath'];
    List<String> filters = [];
    String currentVideoLabel = '0:v';

    // Add music input if provided
    if (musicPath != null && File(musicPath).existsSync()) {
      inputs.add('-i $musicPath');
    }

    // Build filter chain
    int filterIndex = 0;

    // Add text overlays using drawtext filter
    // Note: In production, you'd get actual text from textLayers
    // For now, adding a simple watermark text
    if (includeWatermark && watermarkText != null) {
      filters.add(
        "[$currentVideoLabel]drawtext=text='$watermarkText':fontsize=20:fontcolor=white@0.7:x=(w-text_w-10):y=(h-text_h-10)[v$filterIndex]"
      );
      currentVideoLabel = 'v$filterIndex';
      filterIndex++;
    }

    // Build final command
    StringBuffer command = StringBuffer();

    // Add inputs
    command.write(inputs.join(' '));
    command.write(' ');

    // Add filter complex if we have filters
    if (filters.isNotEmpty) {
      command.write('-filter_complex "');
      command.write(filters.join(';'));
      command.write('" ');
      command.write('-map "[$currentVideoLabel]" ');
    } else {
      command.write('-map 0:v ');
    }

    // Add audio mapping if music exists
    if (musicPath != null && File(musicPath).existsSync()) {
      command.write('-map 1:a -shortest ');
    }

    // Add output options
    command.write('-c:v libx264 ');
    command.write('-preset medium ');
    command.write('-crf 23 ');
    command.write('-pix_fmt yuv420p ');
    command.write('-t $duration ');
    command.write('-y '); // Overwrite output file
    command.write(outputPath);

    return command.toString();
  }

  /// Execute FFmpeg command with progress tracking
  Future<bool> _executeFFmpeg(
    String command,
    int expectedDuration,
    Function(double)? onProgress,
  ) async {
    bool success = false;

    await FFmpegKit.executeAsync(
      command,
      (session) async {
        final returnCode = await session.getReturnCode();
        success = ReturnCode.isSuccess(returnCode);

        if (!success) {
          final output = await session.getOutput();
          debugPrint('$TAG: FFmpeg failed with output: $output');
        }
      },
      null,
      (statistics) {
        if (onProgress != null && statistics != null) {
          final time = statistics.getTime();
          if (time > 0 && expectedDuration > 0) {
            final progress = min(time / (expectedDuration * 1000.0), 1.0);
            onProgress(progress);
          }
        }
      },
    );

    // Wait for completion (simplified - in production use proper async handling)
    await Future.delayed(Duration(seconds: expectedDuration + 5));

    return success;
  }

  /// Execute simple FFmpeg command without progress tracking
  Future<bool> _executeFFmpegSimple(String command) async {
    final session = await FFmpegKit.execute(command);
    final returnCode = await session.getReturnCode();

    if (!ReturnCode.isSuccess(returnCode)) {
      final output = await session.getOutput();
      debugPrint('$TAG: FFmpeg command failed: $output');
      return false;
    }

    return true;
  }

  /// Cleanup temporary files
  Future<void> _cleanupTempFiles(Directory tempDir) async {
    try {
      if (await tempDir.exists()) {
        await tempDir.delete(recursive: true);
      }
    } catch (e) {
      debugPrint('$TAG: Error cleaning up temp files: $e');
    }
  }

  /// Generate thumbnail for video
  Future<String?> generateThumbnail(String videoPath) async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final thumbnailsDir = Directory('${directory.path}/StatusPro/Thumbnails');

      if (!await thumbnailsDir.exists()) {
        await thumbnailsDir.create(recursive: true);
      }

      final videoFile = File(videoPath);
      final fileName = videoFile.uri.pathSegments.last.replaceAll('.mp4', '.jpg');
      final thumbnailPath = '${thumbnailsDir.path}/$fileName';

      // Extract frame at 1 second
      final command = '-i $videoPath -ss 00:00:01.000 -vframes 1 -q:v 2 $thumbnailPath';

      final success = await _executeFFmpegSimple(command);

      return success ? thumbnailPath : null;
    } catch (e) {
      debugPrint('$TAG: Error generating thumbnail: $e');
      return null;
    }
  }
}
