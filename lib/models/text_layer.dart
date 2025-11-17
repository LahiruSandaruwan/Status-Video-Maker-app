import 'package:flutter/material.dart';

/// Represents a text layer in a video template
class TextLayer {
  final String id;
  final String defaultText;
  String text;
  final String fontFamily;
  final double fontSize;
  final Color color;
  final TextAlign textAlign;
  final Offset position; // Relative position (0.0 to 1.0)
  final TextAnimationType animationType;
  final double animationStartTime; // In seconds
  final double animationDuration; // In seconds
  final FontWeight fontWeight;
  final bool hasStroke;
  final Color? strokeColor;
  final double strokeWidth;
  final bool hasShadow;
  final Color? shadowColor;
  final Offset shadowOffset;

  TextLayer({
    required this.id,
    required this.defaultText,
    String? text,
    this.fontFamily = 'Poppins',
    this.fontSize = 32.0,
    this.color = Colors.white,
    this.textAlign = TextAlign.center,
    this.position = const Offset(0.5, 0.5), // Center by default
    this.animationType = TextAnimationType.fadeIn,
    this.animationStartTime = 0.0,
    this.animationDuration = 1.0,
    this.fontWeight = FontWeight.bold,
    this.hasStroke = true,
    this.strokeColor = Colors.black,
    this.strokeWidth = 2.0,
    this.hasShadow = true,
    this.shadowColor = Colors.black54,
    this.shadowOffset = const Offset(2, 2),
  }) : text = text ?? defaultText;

  TextLayer copyWith({
    String? id,
    String? defaultText,
    String? text,
    String? fontFamily,
    double? fontSize,
    Color? color,
    TextAlign? textAlign,
    Offset? position,
    TextAnimationType? animationType,
    double? animationStartTime,
    double? animationDuration,
    FontWeight? fontWeight,
    bool? hasStroke,
    Color? strokeColor,
    double? strokeWidth,
    bool? hasShadow,
    Color? shadowColor,
    Offset? shadowOffset,
  }) {
    return TextLayer(
      id: id ?? this.id,
      defaultText: defaultText ?? this.defaultText,
      text: text ?? this.text,
      fontFamily: fontFamily ?? this.fontFamily,
      fontSize: fontSize ?? this.fontSize,
      color: color ?? this.color,
      textAlign: textAlign ?? this.textAlign,
      position: position ?? this.position,
      animationType: animationType ?? this.animationType,
      animationStartTime: animationStartTime ?? this.animationStartTime,
      animationDuration: animationDuration ?? this.animationDuration,
      fontWeight: fontWeight ?? this.fontWeight,
      hasStroke: hasStroke ?? this.hasStroke,
      strokeColor: strokeColor ?? this.strokeColor,
      strokeWidth: strokeWidth ?? this.strokeWidth,
      hasShadow: hasShadow ?? this.hasShadow,
      shadowColor: shadowColor ?? this.shadowColor,
      shadowOffset: shadowOffset ?? this.shadowOffset,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'defaultText': defaultText,
      'text': text,
      'fontFamily': fontFamily,
      'fontSize': fontSize,
      'color': color.value,
      'textAlign': textAlign.index,
      'positionX': position.dx,
      'positionY': position.dy,
      'animationType': animationType.index,
      'animationStartTime': animationStartTime,
      'animationDuration': animationDuration,
      'fontWeight': fontWeight.index,
      'hasStroke': hasStroke,
      'strokeColor': strokeColor?.value,
      'strokeWidth': strokeWidth,
      'hasShadow': hasShadow,
      'shadowColor': shadowColor?.value,
      'shadowOffsetX': shadowOffset.dx,
      'shadowOffsetY': shadowOffset.dy,
    };
  }

  factory TextLayer.fromJson(Map<String, dynamic> json) {
    return TextLayer(
      id: json['id'],
      defaultText: json['defaultText'],
      text: json['text'],
      fontFamily: json['fontFamily'],
      fontSize: json['fontSize'],
      color: Color(json['color']),
      textAlign: TextAlign.values[json['textAlign']],
      position: Offset(json['positionX'], json['positionY']),
      animationType: TextAnimationType.values[json['animationType']],
      animationStartTime: json['animationStartTime'],
      animationDuration: json['animationDuration'],
      fontWeight: FontWeight.values[json['fontWeight']],
      hasStroke: json['hasStroke'],
      strokeColor: json['strokeColor'] != null ? Color(json['strokeColor']) : null,
      strokeWidth: json['strokeWidth'],
      hasShadow: json['hasShadow'],
      shadowColor: json['shadowColor'] != null ? Color(json['shadowColor']) : null,
      shadowOffset: Offset(json['shadowOffsetX'], json['shadowOffsetY']),
    );
  }
}

/// Types of text animations
enum TextAnimationType {
  none,
  fadeIn,
  fadeOut,
  slideFromLeft,
  slideFromRight,
  slideFromTop,
  slideFromBottom,
  typewriter,
  bounce,
  scale,
  rotate,
  pulse,
}
