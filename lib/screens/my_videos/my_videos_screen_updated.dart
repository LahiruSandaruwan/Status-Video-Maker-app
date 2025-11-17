import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';
import '../../constants/app_colors.dart';
import '../../providers/user_project_provider.dart';
import '../../models/user_project.dart';
import '../../services/share_service.dart';

/// My Videos screen - displays saved creations
class MyVideosScreenUpdated extends StatefulWidget {
  const MyVideosScreenUpdated({super.key});

  @override
  State<MyVideosScreenUpdated> createState() => _MyVideosScreenUpdatedState();
}

class _MyVideosScreenUpdatedState extends State<MyVideosScreenUpdated> {
  String _sortBy = 'newest';

  @override
  void initState() {
    super.initState();
    // Initialize provider and load projects
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<UserProjectProvider>().initialize();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Videos'),
        actions: [
          IconButton(
            icon: const Icon(Icons.sort_rounded),
            onPressed: _showSortOptions,
          ),
        ],
      ),
      body: Consumer<UserProjectProvider>(
        builder: (context, provider, child) {
          if (provider.isLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (provider.projects.isEmpty) {
            return _buildEmptyState();
          }

          final projects = _getSortedProjects(provider.projects);

          return Column(
            children: [
              // Storage info
              _buildStorageInfo(provider),

              // Videos grid
              Expanded(
                child: GridView.builder(
                  padding: const EdgeInsets.all(16),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                    childAspectRatio: 9 / 16,
                  ),
                  itemCount: projects.length,
                  itemBuilder: (context, index) {
                    return _buildVideoCard(projects[index], provider);
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.video_library_outlined,
            size: 80,
            color: AppColors.textTertiary.withOpacity(0.5),
          ),
          const SizedBox(height: 24),
          const Text(
            'No videos yet',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Create your first video to see it here',
            style: TextStyle(
              fontSize: 14,
              color: AppColors.textTertiary,
            ),
          ),
          const SizedBox(height: 32),
          ElevatedButton.icon(
            onPressed: () {
              // Navigate to Home tab
              DefaultTabController.of(context)?.animateTo(0);
            },
            icon: const Icon(Icons.add_rounded),
            label: const Text('Browse Templates'),
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStorageInfo(UserProjectProvider provider) {
    final storageUsed = provider.getTotalStorageUsed();

    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.darkCard,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          const Icon(Icons.folder_rounded, color: AppColors.primaryPink),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${provider.projectCount} Videos',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Using approx. ${storageUsed.toStringAsFixed(1)} MB',
                  style: const TextStyle(
                    fontSize: 12,
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          if (provider.projectCount > 0)
            TextButton(
              onPressed: _showClearAllDialog,
              child: const Text('Clear All'),
              style: TextButton.styleFrom(
                foregroundColor: AppColors.error,
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildVideoCard(UserProject project, UserProjectProvider provider) {
    return GestureDetector(
      onTap: () => _playVideo(project),
      onLongPress: () => _showOptionsBottomSheet(project, provider),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.darkCard,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Stack(
          children: [
            // Thumbnail
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: project.thumbnailPath.isNotEmpty &&
                      File(project.thumbnailPath).existsSync()
                  ? Image.file(
                      File(project.thumbnailPath),
                      width: double.infinity,
                      height: double.infinity,
                      fit: BoxFit.cover,
                    )
                  : Container(
                      width: double.infinity,
                      height: double.infinity,
                      decoration: BoxDecoration(
                        gradient: AppColors.primaryGradient,
                      ),
                      child: const Icon(
                        Icons.video_library_rounded,
                        size: 48,
                        color: Colors.white54,
                      ),
                    ),
            ),

            // Gradient overlay
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    Colors.black.withOpacity(0.7),
                  ],
                ),
              ),
            ),

            // Play icon
            const Center(
              child: Icon(
                Icons.play_circle_filled,
                size: 56,
                color: Colors.white,
              ),
            ),

            // Info at bottom
            Positioned(
              bottom: 8,
              left: 8,
              right: 8,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    project.templateName,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      const Icon(Icons.access_time, size: 12, color: Colors.white70),
                      const SizedBox(width: 4),
                      Text(
                        '${project.durationSeconds}s',
                        style: const TextStyle(
                          color: Colors.white70,
                          fontSize: 10,
                        ),
                      ),
                      const SizedBox(width: 12),
                      const Icon(Icons.visibility, size: 12, color: Colors.white70),
                      const SizedBox(width: 4),
                      Text(
                        '${project.viewCount}',
                        style: const TextStyle(
                          color: Colors.white70,
                          fontSize: 10,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // More options button
            Positioned(
              top: 8,
              right: 8,
              child: IconButton(
                icon: const Icon(Icons.more_vert, color: Colors.white),
                onPressed: () => _showOptionsBottomSheet(project, provider),
                style: IconButton.styleFrom(
                  backgroundColor: Colors.black54,
                ),
              ),
            ),

            // Watermark badge
            if (project.hasWatermark)
              Positioned(
                top: 8,
                left: 8,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
                  decoration: BoxDecoration(
                    color: Colors.black54,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.branding_watermark, size: 10, color: Colors.white70),
                      SizedBox(width: 4),
                      Text(
                        'WM',
                        style: TextStyle(fontSize: 8, color: Colors.white70),
                      ),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  void _playVideo(UserProject project) {
    // Increment view count
    context.read<UserProjectProvider>().incrementViewCount(project.id);

    // Navigate to video player screen
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => VideoPlayerScreen(project: project),
      ),
    );
  }

  void _showOptionsBottomSheet(
      UserProject project, UserProjectProvider provider) {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              project.templateName,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            ListTile(
              leading: const Icon(Icons.play_circle_outline_rounded),
              title: const Text('Play'),
              onTap: () {
                Navigator.pop(context);
                _playVideo(project);
              },
            ),
            ListTile(
              leading: const Icon(Icons.share_rounded),
              title: const Text('Share'),
              onTap: () {
                Navigator.pop(context);
                _shareVideo(project);
              },
            ),
            ListTile(
              leading: const Icon(Icons.save_rounded),
              title: const Text('Save to Gallery'),
              onTap: () async {
                Navigator.pop(context);
                await ShareService.saveToGallery(project.videoPath);
                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Video saved to gallery'),
                      backgroundColor: AppColors.success,
                    ),
                  );
                }
              },
            ),
            ListTile(
              leading: const Icon(Icons.delete_rounded, color: AppColors.error),
              title: const Text('Delete'),
              onTap: () {
                Navigator.pop(context);
                _confirmDelete(project, provider);
              },
            ),
          ],
        ),
      ),
    );
  }

  void _shareVideo(UserProject project) {
    // Increment share count
    context.read<UserProjectProvider>().incrementShareCount(project.id);

    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Share to',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            ListTile(
              leading: const Icon(Icons.whatsapp, color: Colors.green),
              title: const Text('WhatsApp Status'),
              onTap: () async {
                Navigator.pop(context);
                await ShareService.shareToWhatsAppStatus(project.videoPath);
              },
            ),
            ListTile(
              leading: const Icon(Icons.camera_alt, color: AppColors.primaryPink),
              title: const Text('Instagram Story'),
              onTap: () async {
                Navigator.pop(context);
                await ShareService.shareToInstagramStory(project.videoPath);
              },
            ),
            ListTile(
              leading: const Icon(Icons.facebook, color: Colors.blue),
              title: const Text('Facebook'),
              onTap: () async {
                Navigator.pop(context);
                await ShareService.shareToFacebook(project.videoPath);
              },
            ),
            ListTile(
              leading: const Icon(Icons.share, color: AppColors.textPrimary),
              title: const Text('Other'),
              onTap: () async {
                Navigator.pop(context);
                await ShareService.shareVideo(project.videoPath);
              },
            ),
          ],
        ),
      ),
    );
  }

  void _confirmDelete(UserProject project, UserProjectProvider provider) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Video'),
        content: const Text('Are you sure you want to delete this video? This action cannot be undone.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () async {
              Navigator.pop(context);

              // Delete video file
              final videoFile = File(project.videoPath);
              if (await videoFile.exists()) {
                await videoFile.delete();
              }

              // Delete thumbnail
              if (project.thumbnailPath.isNotEmpty) {
                final thumbFile = File(project.thumbnailPath);
                if (await thumbFile.exists()) {
                  await thumbFile.delete();
                }
              }

              // Remove from database
              await provider.deleteProject(project.id);

              if (context.mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Video deleted'),
                  ),
                );
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.error,
            ),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }

  void _showClearAllDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Clear All Videos'),
        content: const Text(
          'Are you sure you want to delete all videos? This action cannot be undone.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () async {
              Navigator.pop(context);

              final provider = context.read<UserProjectProvider>();

              // Delete all video files
              for (final project in provider.projects) {
                final videoFile = File(project.videoPath);
                if (await videoFile.exists()) {
                  await videoFile.delete();
                }

                if (project.thumbnailPath.isNotEmpty) {
                  final thumbFile = File(project.thumbnailPath);
                  if (await thumbFile.exists()) {
                    await thumbFile.delete();
                  }
                }
              }

              // Clear database
              await provider.clearAllProjects();

              if (context.mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('All videos deleted'),
                  ),
                );
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.error,
            ),
            child: const Text('Delete All'),
          ),
        ],
      ),
    );
  }

  void _showSortOptions() {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Sort by',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            RadioListTile<String>(
              value: 'newest',
              groupValue: _sortBy,
              onChanged: (value) {
                setState(() => _sortBy = value!);
                Navigator.pop(context);
              },
              title: const Text('Newest first'),
              secondary: const Icon(Icons.access_time_rounded),
            ),
            RadioListTile<String>(
              value: 'oldest',
              groupValue: _sortBy,
              onChanged: (value) {
                setState(() => _sortBy = value!);
                Navigator.pop(context);
              },
              title: const Text('Oldest first'),
              secondary: const Icon(Icons.access_time_filled_rounded),
            ),
            RadioListTile<String>(
              value: 'views',
              groupValue: _sortBy,
              onChanged: (value) {
                setState(() => _sortBy = value!);
                Navigator.pop(context);
              },
              title: const Text('Most viewed'),
              secondary: const Icon(Icons.visibility_rounded),
            ),
            RadioListTile<String>(
              value: 'shares',
              groupValue: _sortBy,
              onChanged: (value) {
                setState(() => _sortBy = value!);
                Navigator.pop(context);
              },
              title: const Text('Most shared'),
              secondary: const Icon(Icons.share_rounded),
            ),
          ],
        ),
      ),
    );
  }

  List<UserProject> _getSortedProjects(List<UserProject> projects) {
    final sorted = List<UserProject>.from(projects);

    switch (_sortBy) {
      case 'oldest':
        sorted.sort((a, b) => a.createdAt.compareTo(b.createdAt));
        break;
      case 'views':
        sorted.sort((a, b) => b.viewCount.compareTo(a.viewCount));
        break;
      case 'shares':
        sorted.sort((a, b) => b.shareCount.compareTo(a.shareCount));
        break;
      case 'newest':
      default:
        sorted.sort((a, b) => b.createdAt.compareTo(a.createdAt));
    }

    return sorted;
  }
}

/// Video player screen
class VideoPlayerScreen extends StatefulWidget {
  final UserProject project;

  const VideoPlayerScreen({super.key, required this.project});

  @override
  State<VideoPlayerScreen> createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  late VideoPlayerController _controller;
  bool _isInitialized = false;

  @override
  void initState() {
    super.initState();
    _initializeVideo();
  }

  Future<void> _initializeVideo() async {
    _controller = VideoPlayerController.file(File(widget.project.videoPath));

    await _controller.initialize();
    await _controller.setLooping(true);
    await _controller.play();

    setState(() {
      _isInitialized = true;
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(widget.project.templateName),
        actions: [
          IconButton(
            icon: const Icon(Icons.share_rounded),
            onPressed: () {
              // Share video
              ShareService.shareVideo(widget.project.videoPath);
            },
          ),
        ],
      ),
      body: Center(
        child: _isInitialized
            ? AspectRatio(
                aspectRatio: _controller.value.aspectRatio,
                child: VideoPlayer(_controller),
              )
            : const CircularProgressIndicator(),
      ),
      floatingActionButton: _isInitialized
          ? FloatingActionButton(
              onPressed: () {
                setState(() {
                  if (_controller.value.isPlaying) {
                    _controller.pause();
                  } else {
                    _controller.play();
                  }
                });
              },
              child: Icon(
                _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
              ),
            )
          : null,
    );
  }
}
