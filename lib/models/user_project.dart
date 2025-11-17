import 'package:hive/hive.dart';
import 'video_template.dart';
import 'text_layer.dart';
import 'animation_layer.dart';
import 'photo_layer.dart';

part 'user_project.g.dart';

/// Represents a user's saved video project
@HiveType(typeId: 0)
class UserProject extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String templateId;

  @HiveField(2)
  final String templateName;

  @HiveField(3)
  final String videoPath; // Path to generated video

  @HiveField(4)
  final String thumbnailPath; // Path to video thumbnail

  @HiveField(5)
  final DateTime createdAt;

  @HiveField(6)
  final DateTime? modifiedAt;

  @HiveField(7)
  final int durationSeconds;

  @HiveField(8)
  final bool hasWatermark;

  @HiveField(9)
  final int viewCount;

  @HiveField(10)
  final int shareCount;

  @HiveField(11)
  final Map<String, dynamic>? customData; // Store custom text, photos, etc.

  UserProject({
    required this.id,
    required this.templateId,
    required this.templateName,
    required this.videoPath,
    required this.thumbnailPath,
    required this.createdAt,
    this.modifiedAt,
    required this.durationSeconds,
    this.hasWatermark = true,
    this.viewCount = 0,
    this.shareCount = 0,
    this.customData,
  });

  UserProject copyWith({
    String? id,
    String? templateId,
    String? templateName,
    String? videoPath,
    String? thumbnailPath,
    DateTime? createdAt,
    DateTime? modifiedAt,
    int? durationSeconds,
    bool? hasWatermark,
    int? viewCount,
    int? shareCount,
    Map<String, dynamic>? customData,
  }) {
    return UserProject(
      id: id ?? this.id,
      templateId: templateId ?? this.templateId,
      templateName: templateName ?? this.templateName,
      videoPath: videoPath ?? this.videoPath,
      thumbnailPath: thumbnailPath ?? this.thumbnailPath,
      createdAt: createdAt ?? this.createdAt,
      modifiedAt: modifiedAt ?? this.modifiedAt,
      durationSeconds: durationSeconds ?? this.durationSeconds,
      hasWatermark: hasWatermark ?? this.hasWatermark,
      viewCount: viewCount ?? this.viewCount,
      shareCount: shareCount ?? this.shareCount,
      customData: customData ?? this.customData,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'templateId': templateId,
      'templateName': templateName,
      'videoPath': videoPath,
      'thumbnailPath': thumbnailPath,
      'createdAt': createdAt.toIso8601String(),
      'modifiedAt': modifiedAt?.toIso8601String(),
      'durationSeconds': durationSeconds,
      'hasWatermark': hasWatermark,
      'viewCount': viewCount,
      'shareCount': shareCount,
      'customData': customData,
    };
  }

  factory UserProject.fromJson(Map<String, dynamic> json) {
    return UserProject(
      id: json['id'],
      templateId: json['templateId'],
      templateName: json['templateName'],
      videoPath: json['videoPath'],
      thumbnailPath: json['thumbnailPath'],
      createdAt: DateTime.parse(json['createdAt']),
      modifiedAt: json['modifiedAt'] != null ? DateTime.parse(json['modifiedAt']) : null,
      durationSeconds: json['durationSeconds'],
      hasWatermark: json['hasWatermark'] ?? true,
      viewCount: json['viewCount'] ?? 0,
      shareCount: json['shareCount'] ?? 0,
      customData: json['customData'],
    );
  }
}
