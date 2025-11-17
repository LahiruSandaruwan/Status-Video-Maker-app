import 'package:flutter/foundation.dart';
import '../models/video_template.dart';
import '../data/template_data.dart';

/// Provider for managing video templates
class TemplateProvider with ChangeNotifier {
  List<VideoTemplate> _allTemplates = [];
  List<VideoTemplate> _filteredTemplates = [];
  String _selectedCategory = 'All';
  String _searchQuery = '';
  bool _isLoading = false;

  List<VideoTemplate> get allTemplates => _allTemplates;
  List<VideoTemplate> get filteredTemplates => _filteredTemplates;
  String get selectedCategory => _selectedCategory;
  String get searchQuery => _searchQuery;
  bool get isLoading => _isLoading;

  /// Available categories
  List<String> get categories => [
        'All',
        'Love & Romance',
        'Motivational',
        'Birthday & Celebrations',
        'Lyrics & Music',
        'Photo Slideshow',
        'Trending',
      ];

  TemplateProvider() {
    loadTemplates();
  }

  /// Load all templates
  Future<void> loadTemplates() async {
    _isLoading = true;
    notifyListeners();

    try {
      // Simulate loading delay
      await Future.delayed(const Duration(milliseconds: 500));

      _allTemplates = TemplateData.getAllTemplates();
      _filteredTemplates = _allTemplates;

      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      notifyListeners();
      rethrow;
    }
  }

  /// Filter templates by category
  void filterByCategory(String category) {
    _selectedCategory = category;
    _applyFilters();
  }

  /// Search templates
  void searchTemplates(String query) {
    _searchQuery = query;
    _applyFilters();
  }

  /// Apply filters (category + search)
  void _applyFilters() {
    List<VideoTemplate> result = _allTemplates;

    // Apply category filter
    if (_selectedCategory != 'All') {
      if (_selectedCategory == 'Trending') {
        result = TemplateData.getTrendingTemplates();
      } else {
        result = result
            .where((template) => template.category == _selectedCategory)
            .toList();
      }
    }

    // Apply search filter
    if (_searchQuery.isNotEmpty) {
      result = result
          .where((template) =>
              template.name.toLowerCase().contains(_searchQuery.toLowerCase()) ||
              template.category
                  .toLowerCase()
                  .contains(_searchQuery.toLowerCase()) ||
              template.tags.any((tag) =>
                  tag.toLowerCase().contains(_searchQuery.toLowerCase())))
          .toList();
    }

    _filteredTemplates = result;
    notifyListeners();
  }

  /// Get template by ID
  VideoTemplate? getTemplateById(String id) {
    try {
      return _allTemplates.firstWhere((template) => template.id == id);
    } catch (e) {
      return null;
    }
  }

  /// Increment template usage count
  void incrementUsageCount(String templateId) {
    final index = _allTemplates.indexWhere((t) => t.id == templateId);
    if (index != -1) {
      _allTemplates[index] = _allTemplates[index].copyWith(
        usageCount: _allTemplates[index].usageCount + 1,
      );
      notifyListeners();
    }
  }

  /// Get featured templates (for carousel)
  List<VideoTemplate> getFeaturedTemplates() {
    return _allTemplates.take(5).toList();
  }

  /// Clear search and filters
  void clearFilters() {
    _selectedCategory = 'All';
    _searchQuery = '';
    _filteredTemplates = _allTemplates;
    notifyListeners();
  }
}
