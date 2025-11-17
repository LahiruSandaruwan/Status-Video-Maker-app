import 'package:flutter/material.dart';
import 'text_layer.dart';
import 'animation_layer.dart';
import 'photo_layer.dart';

/// Main template model for video creation
class VideoTemplate {
  final String id;
  final String name;
  final String category;
  final String thumbnailUrl;
  final int durationSeconds;
  final AspectRatioType aspectRatio;
  final BackgroundType backgroundType;
  final dynamic backgroundValue; // Color, gradient, or image path
  final List<TextLayer> textLayers;
  final List<AnimationLayer> animationLayers;
  final List<PhotoLayer>? photoPlaceholders;
  final String? defaultMusicPath;
  final bool isPremium;
  final List<String> tags;
  final int usageCount;

  VideoTemplate({
    required this.id,
    required this.name,
    required this.category,
    required this.thumbnailUrl,
    this.durationSeconds = 15,
    this.aspectRatio = AspectRatioType.story9_16,
    required this.backgroundType,
    required this.backgroundValue,
    this.textLayers = const [],
    this.animationLayers = const [],
    this.photoPlaceholders,
    this.defaultMusicPath,
    this.isPremium = false,
    this.tags = const [],
    this.usageCount = 0,
  });

  VideoTemplate copyWith({
    String? id,
    String? name,
    String? category,
    String? thumbnailUrl,
    int? durationSeconds,
    AspectRatioType? aspectRatio,
    BackgroundType? backgroundType,
    dynamic backgroundValue,
    List<TextLayer>? textLayers,
    List<AnimationLayer>? animationLayers,
    List<PhotoLayer>? photoPlaceholders,
    String? defaultMusicPath,
    bool? isPremium,
    List<String>? tags,
    int? usageCount,
  }) {
    return VideoTemplate(
      id: id ?? this.id,
      name: name ?? this.name,
      category: category ?? this.category,
      thumbnailUrl: thumbnailUrl ?? this.thumbnailUrl,
      durationSeconds: durationSeconds ?? this.durationSeconds,
      aspectRatio: aspectRatio ?? this.aspectRatio,
      backgroundType: backgroundType ?? this.backgroundType,
      backgroundValue: backgroundValue ?? this.backgroundValue,
      textLayers: textLayers ?? this.textLayers,
      animationLayers: animationLayers ?? this.animationLayers,
      photoPlaceholders: photoPlaceholders ?? this.photoPlaceholders,
      defaultMusicPath: defaultMusicPath ?? this.defaultMusicPath,
      isPremium: isPremium ?? this.isPremium,
      tags: tags ?? this.tags,
      usageCount: usageCount ?? this.usageCount,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'category': category,
      'thumbnailUrl': thumbnailUrl,
      'durationSeconds': durationSeconds,
      'aspectRatio': aspectRatio.index,
      'backgroundType': backgroundType.index,
      'backgroundValue': _serializeBackgroundValue(),
      'textLayers': textLayers.map((layer) => layer.toJson()).toList(),
      'animationLayers': animationLayers.map((layer) => layer.toJson()).toList(),
      'photoPlaceholders': photoPlaceholders?.map((layer) => layer.toJson()).toList(),
      'defaultMusicPath': defaultMusicPath,
      'isPremium': isPremium,
      'tags': tags,
      'usageCount': usageCount,
    };
  }

  dynamic _serializeBackgroundValue() {
    if (backgroundValue is Color) {
      return (backgroundValue as Color).value;
    } else if (backgroundValue is LinearGradient) {
      final gradient = backgroundValue as LinearGradient;
      return {
        'type': 'gradient',
        'colors': gradient.colors.map((c) => c.value).toList(),
        'begin': {
          'x': gradient.begin.x,
          'y': gradient.begin.y,
        },
        'end': {
          'x': gradient.end.x,
          'y': gradient.end.y,
        },
      };
    }
    return backgroundValue; // String path
  }

  factory VideoTemplate.fromJson(Map<String, dynamic> json) {
    return VideoTemplate(
      id: json['id'],
      name: json['name'],
      category: json['category'],
      thumbnailUrl: json['thumbnailUrl'],
      durationSeconds: json['durationSeconds'],
      aspectRatio: AspectRatioType.values[json['aspectRatio']],
      backgroundType: BackgroundType.values[json['backgroundType']],
      backgroundValue: json['backgroundValue'], // Handle deserialization as needed
      textLayers: (json['textLayers'] as List?)
              ?.map((layer) => TextLayer.fromJson(layer))
              .toList() ??
          [],
      animationLayers: (json['animationLayers'] as List?)
              ?.map((layer) => AnimationLayer.fromJson(layer))
              .toList() ??
          [],
      photoPlaceholders: (json['photoPlaceholders'] as List?)
          ?.map((layer) => PhotoLayer.fromJson(layer))
          .toList(),
      defaultMusicPath: json['defaultMusicPath'],
      isPremium: json['isPremium'] ?? false,
      tags: List<String>.from(json['tags'] ?? []),
      usageCount: json['usageCount'] ?? 0,
    );
  }
}

/// Template categories
enum TemplateCategory {
  all,
  love,
  motivational,
  birthday,
  lyrics,
  photoSlideshow,
  trending,
}

/// Aspect ratio types
enum AspectRatioType {
  story9_16, // 9:16 (1080x1920) - Instagram/WhatsApp Stories
  square1_1, // 1:1 (1080x1080) - Instagram Post
  post4_5, // 4:5 (1080x1350) - Instagram Feed
}

/// Background types
enum BackgroundType {
  solidColor,
  gradient,
  image,
  video,
  blur,
}
