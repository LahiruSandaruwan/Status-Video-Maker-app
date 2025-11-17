import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../models/video_template.dart';
import '../models/text_layer.dart';
import '../models/photo_layer.dart';
import '../models/animation_layer.dart';

/// Provider for managing video editing state
class VideoEditorProvider with ChangeNotifier {
  VideoTemplate? _currentTemplate;
  List<TextLayer> _textLayers = [];
  List<PhotoLayer> _photoLayers = [];
  List<AnimationLayer> _animationLayers = [];
  String? _selectedMusicPath;
  int _durationSeconds = 15;
  bool _hasWatermark = true;

  // Generation state
  bool _isGenerating = false;
  double _generationProgress = 0.0;
  String _generationStatus = '';

  // Getters
  VideoTemplate? get currentTemplate => _currentTemplate;
  List<TextLayer> get textLayers => _textLayers;
  List<PhotoLayer> get photoLayers => _photoLayers;
  List<AnimationLayer> get animationLayers => _animationLayers;
  String? get selectedMusicPath => _selectedMusicPath;
  int get durationSeconds => _durationSeconds;
  bool get hasWatermark => _hasWatermark;
  bool get isGenerating => _isGenerating;
  double get generationProgress => _generationProgress;
  String get generationStatus => _generationStatus;

  /// Load a template for editing
  void loadTemplate(VideoTemplate template) {
    _currentTemplate = template;
    _textLayers = List.from(template.textLayers);
    _photoLayers = List.from(template.photoPlaceholders ?? []);
    _animationLayers = List.from(template.animationLayers);
    _selectedMusicPath = template.defaultMusicPath;
    _durationSeconds = template.durationSeconds;
    _hasWatermark = true;
    notifyListeners();
  }

  /// Update text layer
  void updateTextLayer(int index, TextLayer layer) {
    if (index >= 0 && index < _textLayers.length) {
      _textLayers[index] = layer;
      notifyListeners();
    }
  }

  /// Update text content
  void updateTextContent(int index, String text) {
    if (index >= 0 && index < _textLayers.length) {
      _textLayers[index] = _textLayers[index].copyWith(text: text);
      notifyListeners();
    }
  }

  /// Update text color
  void updateTextColor(int index, Color color) {
    if (index >= 0 && index < _textLayers.length) {
      _textLayers[index] = _textLayers[index].copyWith(color: color);
      notifyListeners();
    }
  }

  /// Update text font
  void updateTextFont(int index, String fontFamily) {
    if (index >= 0 && index < _textLayers.length) {
      _textLayers[index] = _textLayers[index].copyWith(fontFamily: fontFamily);
      notifyListeners();
    }
  }

  /// Update text size
  void updateTextSize(int index, double fontSize) {
    if (index >= 0 && index < _textLayers.length) {
      _textLayers[index] = _textLayers[index].copyWith(fontSize: fontSize);
      notifyListeners();
    }
  }

  /// Update text animation
  void updateTextAnimation(int index, TextAnimationType animationType) {
    if (index >= 0 && index < _textLayers.length) {
      _textLayers[index] = _textLayers[index].copyWith(
        animationType: animationType,
      );
      notifyListeners();
    }
  }

  /// Add photo layer
  void addPhotoLayer(PhotoLayer photo) {
    _photoLayers.add(photo);
    notifyListeners();
  }

  /// Update photo layer
  void updatePhotoLayer(int index, PhotoLayer layer) {
    if (index >= 0 && index < _photoLayers.length) {
      _photoLayers[index] = layer;
      notifyListeners();
    }
  }

  /// Remove photo layer
  void removePhotoLayer(int index) {
    if (index >= 0 && index < _photoLayers.length) {
      _photoLayers.removeAt(index);
      notifyListeners();
    }
  }

  /// Update music track
  void updateMusicTrack(String? musicPath) {
    _selectedMusicPath = musicPath;
    notifyListeners();
  }

  /// Update duration
  void updateDuration(int seconds) {
    _durationSeconds = seconds;
    notifyListeners();
  }

  /// Toggle watermark
  void toggleWatermark() {
    _hasWatermark = !_hasWatermark;
    notifyListeners();
  }

  /// Remove watermark (after watching rewarded ad)
  void removeWatermark() {
    _hasWatermark = false;
    notifyListeners();
  }

  /// Start video generation
  void startGeneration() {
    _isGenerating = true;
    _generationProgress = 0.0;
    _generationStatus = 'Preparing...';
    notifyListeners();
  }

  /// Update generation progress
  void updateGenerationProgress(double progress, String status) {
    _generationProgress = progress;
    _generationStatus = status;
    notifyListeners();
  }

  /// Complete generation
  void completeGeneration() {
    _isGenerating = false;
    _generationProgress = 1.0;
    _generationStatus = 'Complete!';
    notifyListeners();
  }

  /// Cancel generation
  void cancelGeneration() {
    _isGenerating = false;
    _generationProgress = 0.0;
    _generationStatus = '';
    notifyListeners();
  }

  /// Reset editor
  void reset() {
    _currentTemplate = null;
    _textLayers = [];
    _photoLayers = [];
    _animationLayers = [];
    _selectedMusicPath = null;
    _durationSeconds = 15;
    _hasWatermark = true;
    _isGenerating = false;
    _generationProgress = 0.0;
    _generationStatus = '';
    notifyListeners();
  }

  /// Get custom data for saving
  Map<String, dynamic> getCustomData() {
    return {
      'textLayers': _textLayers.map((layer) => layer.toJson()).toList(),
      'photoLayers': _photoLayers.map((layer) => layer.toJson()).toList(),
      'animationLayers':
          _animationLayers.map((layer) => layer.toJson()).toList(),
      'musicPath': _selectedMusicPath,
      'duration': _durationSeconds,
      'hasWatermark': _hasWatermark,
    };
  }
}
