import 'package:flutter/material.dart';

/// Represents an animation layer (stickers, elements, effects)
class AnimationLayer {
  final String id;
  final AnimationLayerType type;
  final String assetPath; // Path to image, lottie, or sticker
  final Offset position; // Relative position (0.0 to 1.0)
  final double scale;
  final double rotation; // In degrees
  final double opacity;
  final double startTime; // In seconds
  final double duration; // In seconds
  final AnimationEffect? effect;

  AnimationLayer({
    required this.id,
    required this.type,
    required this.assetPath,
    this.position = const Offset(0.5, 0.5),
    this.scale = 1.0,
    this.rotation = 0.0,
    this.opacity = 1.0,
    this.startTime = 0.0,
    this.duration = 5.0,
    this.effect,
  });

  AnimationLayer copyWith({
    String? id,
    AnimationLayerType? type,
    String? assetPath,
    Offset? position,
    double? scale,
    double? rotation,
    double? opacity,
    double? startTime,
    double? duration,
    AnimationEffect? effect,
  }) {
    return AnimationLayer(
      id: id ?? this.id,
      type: type ?? this.type,
      assetPath: assetPath ?? this.assetPath,
      position: position ?? this.position,
      scale: scale ?? this.scale,
      rotation: rotation ?? this.rotation,
      opacity: opacity ?? this.opacity,
      startTime: startTime ?? this.startTime,
      duration: duration ?? this.duration,
      effect: effect ?? this.effect,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'type': type.index,
      'assetPath': assetPath,
      'positionX': position.dx,
      'positionY': position.dy,
      'scale': scale,
      'rotation': rotation,
      'opacity': opacity,
      'startTime': startTime,
      'duration': duration,
      'effect': effect?.index,
    };
  }

  factory AnimationLayer.fromJson(Map<String, dynamic> json) {
    return AnimationLayer(
      id: json['id'],
      type: AnimationLayerType.values[json['type']],
      assetPath: json['assetPath'],
      position: Offset(json['positionX'], json['positionY']),
      scale: json['scale'],
      rotation: json['rotation'],
      opacity: json['opacity'],
      startTime: json['startTime'],
      duration: json['duration'],
      effect: json['effect'] != null ? AnimationEffect.values[json['effect']] : null,
    );
  }
}

/// Types of animation layers
enum AnimationLayerType {
  sticker,
  lottie,
  image,
  particle,
}

/// Animation effects that can be applied
enum AnimationEffect {
  none,
  pulse,
  bounce,
  rotate,
  float,
  sparkle,
}
