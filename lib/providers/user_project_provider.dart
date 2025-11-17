import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import '../models/user_project.dart';
import '../constants/app_constants.dart';

/// Provider for managing user's saved video projects
class UserProjectProvider with ChangeNotifier {
  Box<UserProject>? _projectsBox;
  List<UserProject> _projects = [];
  bool _isLoading = false;

  List<UserProject> get projects => _projects;
  bool get isLoading => _isLoading;
  int get projectCount => _projects.length;

  /// Initialize Hive box
  Future<void> initialize() async {
    try {
      _isLoading = true;
      notifyListeners();

      _projectsBox = await Hive.openBox<UserProject>(
        AppConstants.userProjectsBoxName,
      );

      await loadProjects();

      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      notifyListeners();
      rethrow;
    }
  }

  /// Load all projects from Hive
  Future<void> loadProjects() async {
    if (_projectsBox == null) return;

    _projects = _projectsBox!.values.toList();

    // Sort by creation date (newest first)
    _projects.sort((a, b) => b.createdAt.compareTo(a.createdAt));

    notifyListeners();
  }

  /// Add a new project
  Future<void> addProject(UserProject project) async {
    if (_projectsBox == null) return;

    await _projectsBox!.put(project.id, project);
    await loadProjects();
  }

  /// Update an existing project
  Future<void> updateProject(UserProject project) async {
    if (_projectsBox == null) return;

    await _projectsBox!.put(project.id, project);
    await loadProjects();
  }

  /// Delete a project
  Future<void> deleteProject(String projectId) async {
    if (_projectsBox == null) return;

    await _projectsBox!.delete(projectId);
    await loadProjects();
  }

  /// Get project by ID
  UserProject? getProjectById(String id) {
    try {
      return _projects.firstWhere((project) => project.id == id);
    } catch (e) {
      return null;
    }
  }

  /// Increment view count
  Future<void> incrementViewCount(String projectId) async {
    final project = getProjectById(projectId);
    if (project != null) {
      final updated = project.copyWith(
        viewCount: project.viewCount + 1,
      );
      await updateProject(updated);
    }
  }

  /// Increment share count
  Future<void> incrementShareCount(String projectId) async {
    final project = getProjectById(projectId);
    if (project != null) {
      final updated = project.copyWith(
        shareCount: project.shareCount + 1,
      );
      await updateProject(updated);
    }
  }

  /// Get projects sorted by views
  List<UserProject> getProjectsSortedByViews() {
    final sorted = List<UserProject>.from(_projects);
    sorted.sort((a, b) => b.viewCount.compareTo(a.viewCount));
    return sorted;
  }

  /// Get projects sorted by shares
  List<UserProject> getProjectsSortedByShares() {
    final sorted = List<UserProject>.from(_projects);
    sorted.sort((a, b) => b.shareCount.compareTo(a.shareCount));
    return sorted;
  }

  /// Get total storage used (estimate in MB)
  double getTotalStorageUsed() {
    // This is a simplified calculation
    // In production, you'd want to check actual file sizes
    return _projects.length * 5.0; // Assume 5MB per video
  }

  /// Clear all projects
  Future<void> clearAllProjects() async {
    if (_projectsBox == null) return;

    await _projectsBox!.clear();
    await loadProjects();
  }
}
