import 'package:flutter/foundation.dart';
import '../models/music_track.dart';
import '../data/music_data.dart';

/// Provider for managing music library
class MusicProvider with ChangeNotifier {
  List<MusicTrack> _allTracks = [];
  List<MusicTrack> _filteredTracks = [];
  MusicCategory? _selectedCategory;
  String _searchQuery = '';
  bool _isLoading = false;

  List<MusicTrack> get allTracks => _allTracks;
  List<MusicTrack> get filteredTracks => _filteredTracks;
  MusicCategory? get selectedCategory => _selectedCategory;
  String get searchQuery => _searchQuery;
  bool get isLoading => _isLoading;

  /// Available categories
  List<MusicCategory> get categories => MusicCategory.values;

  MusicProvider() {
    loadTracks();
  }

  /// Load all music tracks
  Future<void> loadTracks() async {
    _isLoading = true;
    notifyListeners();

    try {
      await Future.delayed(const Duration(milliseconds: 300));

      _allTracks = MusicData.getAllTracks();
      _filteredTracks = _allTracks;

      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      notifyListeners();
      rethrow;
    }
  }

  /// Filter tracks by category
  void filterByCategory(MusicCategory? category) {
    _selectedCategory = category;
    _applyFilters();
  }

  /// Search tracks
  void searchTracks(String query) {
    _searchQuery = query;
    _applyFilters();
  }

  /// Apply filters (category + search)
  void _applyFilters() {
    List<MusicTrack> result = _allTracks;

    // Apply category filter
    if (_selectedCategory != null) {
      result = result
          .where((track) => track.category == _selectedCategory)
          .toList();
    }

    // Apply search filter
    if (_searchQuery.isNotEmpty) {
      result = result
          .where((track) =>
              track.name.toLowerCase().contains(_searchQuery.toLowerCase()) ||
              track.artist.toLowerCase().contains(_searchQuery.toLowerCase()))
          .toList();
    }

    _filteredTracks = result;
    notifyListeners();
  }

  /// Get track by ID
  MusicTrack? getTrackById(String id) {
    try {
      return _allTracks.firstWhere((track) => track.id == id);
    } catch (e) {
      return null;
    }
  }

  /// Clear filters
  void clearFilters() {
    _selectedCategory = null;
    _searchQuery = '';
    _filteredTracks = _allTracks;
    notifyListeners();
  }

  /// Get category name
  String getCategoryName(MusicCategory category) {
    switch (category) {
      case MusicCategory.upbeat:
        return 'Upbeat';
      case MusicCategory.romantic:
        return 'Romantic';
      case MusicCategory.motivational:
        return 'Motivational';
      case MusicCategory.chill:
        return 'Chill';
      case MusicCategory.epic:
        return 'Epic';
      case MusicCategory.emotional:
        return 'Emotional';
    }
  }
}
