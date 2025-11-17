import 'package:flutter/material.dart';

/// Represents a photo/image layer in the video
class PhotoLayer {
  final String id;
  final String imagePath; // Local file path
  final Offset position; // Relative position (0.0 to 1.0)
  final double scale;
  final double rotation; // In degrees
  final double opacity;
  final PhotoTransition transition;
  final double startTime; // In seconds
  final double duration; // In seconds
  final PhotoFilter? filter;
  final BoxFit fit;
  final bool enableKenBurns; // Zoom/pan effect
  final Offset? kenBurnsStart;
  final Offset? kenBurnsEnd;
  final double kenBurnsScale;

  PhotoLayer({
    required this.id,
    required this.imagePath,
    this.position = const Offset(0.5, 0.5),
    this.scale = 1.0,
    this.rotation = 0.0,
    this.opacity = 1.0,
    this.transition = PhotoTransition.fade,
    this.startTime = 0.0,
    this.duration = 3.0,
    this.filter,
    this.fit = BoxFit.cover,
    this.enableKenBurns = false,
    this.kenBurnsStart,
    this.kenBurnsEnd,
    this.kenBurnsScale = 1.2,
  });

  PhotoLayer copyWith({
    String? id,
    String? imagePath,
    Offset? position,
    double? scale,
    double? rotation,
    double? opacity,
    PhotoTransition? transition,
    double? startTime,
    double? duration,
    PhotoFilter? filter,
    BoxFit? fit,
    bool? enableKenBurns,
    Offset? kenBurnsStart,
    Offset? kenBurnsEnd,
    double? kenBurnsScale,
  }) {
    return PhotoLayer(
      id: id ?? this.id,
      imagePath: imagePath ?? this.imagePath,
      position: position ?? this.position,
      scale: scale ?? this.scale,
      rotation: rotation ?? this.rotation,
      opacity: opacity ?? this.opacity,
      transition: transition ?? this.transition,
      startTime: startTime ?? this.startTime,
      duration: duration ?? this.duration,
      filter: filter ?? this.filter,
      fit: fit ?? this.fit,
      enableKenBurns: enableKenBurns ?? this.enableKenBurns,
      kenBurnsStart: kenBurnsStart ?? this.kenBurnsStart,
      kenBurnsEnd: kenBurnsEnd ?? this.kenBurnsEnd,
      kenBurnsScale: kenBurnsScale ?? this.kenBurnsScale,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'imagePath': imagePath,
      'positionX': position.dx,
      'positionY': position.dy,
      'scale': scale,
      'rotation': rotation,
      'opacity': opacity,
      'transition': transition.index,
      'startTime': startTime,
      'duration': duration,
      'filter': filter?.index,
      'fit': fit.index,
      'enableKenBurns': enableKenBurns,
      'kenBurnsStartX': kenBurnsStart?.dx,
      'kenBurnsStartY': kenBurnsStart?.dy,
      'kenBurnsEndX': kenBurnsEnd?.dx,
      'kenBurnsEndY': kenBurnsEnd?.dy,
      'kenBurnsScale': kenBurnsScale,
    };
  }

  factory PhotoLayer.fromJson(Map<String, dynamic> json) {
    return PhotoLayer(
      id: json['id'],
      imagePath: json['imagePath'],
      position: Offset(json['positionX'], json['positionY']),
      scale: json['scale'],
      rotation: json['rotation'],
      opacity: json['opacity'],
      transition: PhotoTransition.values[json['transition']],
      startTime: json['startTime'],
      duration: json['duration'],
      filter: json['filter'] != null ? PhotoFilter.values[json['filter']] : null,
      fit: BoxFit.values[json['fit']],
      enableKenBurns: json['enableKenBurns'],
      kenBurnsStart: json['kenBurnsStartX'] != null
          ? Offset(json['kenBurnsStartX'], json['kenBurnsStartY'])
          : null,
      kenBurnsEnd: json['kenBurnsEndX'] != null
          ? Offset(json['kenBurnsEndX'], json['kenBurnsEndY'])
          : null,
      kenBurnsScale: json['kenBurnsScale'],
    );
  }
}

/// Photo transition effects
enum PhotoTransition {
  none,
  fade,
  slideLeft,
  slideRight,
  slideUp,
  slideDown,
  zoom,
  crossDissolve,
}

/// Instagram-style filters
enum PhotoFilter {
  none,
  vintage,
  blackAndWhite,
  sepia,
  warm,
  cool,
  bright,
  contrast,
  saturate,
  blur,
}
