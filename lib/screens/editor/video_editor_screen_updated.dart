import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';
import '../../constants/app_colors.dart';
import '../../providers/video_editor_provider.dart';
import '../../providers/music_provider.dart';
import '../../providers/user_project_provider.dart';
import '../../providers/ad_provider.dart';
import '../../widgets/gradient_button.dart';
import '../../services/video_generator_service.dart';
import '../../services/permission_service.dart';
import '../../services/share_service.dart';
import '../../models/user_project.dart';
import '../../models/photo_layer.dart';

/// Video editor screen with complete functionality
class VideoEditorScreenUpdated extends StatefulWidget {
  const VideoEditorScreenUpdated({super.key});

  @override
  State<VideoEditorScreenUpdated> createState() =>
      _VideoEditorScreenUpdatedState();
}

class _VideoEditorScreenUpdatedState extends State<VideoEditorScreenUpdated>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final VideoGeneratorService _videoGenerator = VideoGeneratorService();
  final ImagePicker _imagePicker = ImagePicker();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
    _requestPermissions();
  }

  Future<void> _requestPermissions() async {
    await PermissionService.requestStoragePermission();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Video'),
        actions: [
          IconButton(
            icon: const Icon(Icons.help_outline_rounded),
            onPressed: _showHelpDialog,
          ),
        ],
      ),
      body: Consumer<VideoEditorProvider>(
        builder: (context, provider, child) {
          if (provider.currentTemplate == null) {
            return const Center(
              child: Text('No template loaded'),
            );
          }

          return Column(
            children: [
              // Preview area
              Expanded(
                flex: 3,
                child: _buildPreviewArea(provider),
              ),

              // Tab bar
              Container(
                color: AppColors.darkSurface,
                child: TabBar(
                  controller: _tabController,
                  indicatorColor: AppColors.primaryPink,
                  labelColor: AppColors.primaryPink,
                  unselectedLabelColor: AppColors.textSecondary,
                  tabs: const [
                    Tab(icon: Icon(Icons.text_fields), text: 'Text'),
                    Tab(icon: Icon(Icons.photo), text: 'Photos'),
                    Tab(icon: Icon(Icons.music_note), text: 'Music'),
                    Tab(icon: Icon(Icons.settings), text: 'Settings'),
                  ],
                ),
              ),

              // Tab views
              Expanded(
                flex: 2,
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    _buildTextEditTab(provider),
                    _buildPhotoEditTab(provider),
                    _buildMusicEditTab(),
                    _buildSettingsTab(provider),
                  ],
                ),
              ),

              // Generate button
              _buildGenerateButton(provider),
            ],
          );
        },
      ),
    );
  }

  Widget _buildPreviewArea(VideoEditorProvider provider) {
    return Container(
      color: AppColors.darkBackground,
      child: Center(
        child: AspectRatio(
          aspectRatio: 9 / 16,
          child: Container(
            decoration: BoxDecoration(
              gradient: provider.currentTemplate!.backgroundType ==
                      BackgroundType.gradient
                  ? provider.currentTemplate!.backgroundValue
                  : null,
              color: provider.currentTemplate!.backgroundType ==
                      BackgroundType.solidColor
                  ? provider.currentTemplate!.backgroundValue
                  : AppColors.darkCard,
              border: Border.all(color: AppColors.textTertiary, width: 1),
            ),
            child: Stack(
              children: [
                // Photo layers
                ...provider.photoLayers.asMap().entries.map((entry) {
                  final layer = entry.value;
                  if (layer.imagePath.isEmpty) return const SizedBox.shrink();

                  return Positioned(
                    left: layer.position.dx * 360 - 100,
                    top: layer.position.dy * 640 - 100,
                    child: Transform.scale(
                      scale: layer.scale * 0.3,
                      child: Image.file(
                        File(layer.imagePath),
                        width: 200,
                        height: 200,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            width: 200,
                            height: 200,
                            color: Colors.grey,
                            child: const Icon(Icons.error),
                          );
                        },
                      ),
                    ),
                  );
                }),

                // Text layers
                ...provider.textLayers.asMap().entries.map((entry) {
                  final layer = entry.value;
                  return Positioned(
                    left: layer.position.dx * 360 - 180,
                    top: layer.position.dy * 640 - 40,
                    child: Text(
                      layer.text,
                      style: TextStyle(
                        fontFamily: layer.fontFamily,
                        fontSize: layer.fontSize * 0.4,
                        color: layer.color,
                        fontWeight: layer.fontWeight,
                        shadows: layer.hasShadow
                            ? [
                                Shadow(
                                  color: layer.shadowColor ?? Colors.black54,
                                  offset: layer.shadowOffset,
                                  blurRadius: 4,
                                ),
                              ]
                            : null,
                      ),
                      textAlign: layer.textAlign,
                    ),
                  );
                }),

                // Watermark
                if (provider.hasWatermark)
                  Positioned(
                    bottom: 8,
                    right: 8,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.5),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: const Text(
                        'StatusPro',
                        style: TextStyle(
                          fontSize: 10,
                          color: Colors.white70,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextEditTab(VideoEditorProvider provider) {
    if (provider.textLayers.isEmpty) {
      return const Center(
        child: Text('No text layers in this template'),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: provider.textLayers.length,
      itemBuilder: (context, index) {
        final textLayer = provider.textLayers[index];
        return Card(
          margin: const EdgeInsets.only(bottom: 12),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Text ${index + 1}',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: TextEditingController(text: textLayer.text),
                  decoration: const InputDecoration(
                    labelText: 'Text content',
                    border: OutlineInputBorder(),
                  ),
                  maxLines: 2,
                  onChanged: (value) {
                    provider.updateTextContent(index, value);
                  },
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    const Text('Size: '),
                    Expanded(
                      child: Slider(
                        value: textLayer.fontSize,
                        min: 16,
                        max: 80,
                        divisions: 16,
                        label: textLayer.fontSize.toInt().toString(),
                        onChanged: (value) {
                          provider.updateTextSize(index, value);
                        },
                      ),
                    ),
                    Text('${textLayer.fontSize.toInt()}'),
                  ],
                ),
                const SizedBox(height: 8),
                const Text('Color:'),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 8,
                  children: [
                    _buildColorButton(
                        Colors.white, textLayer.color, index, provider),
                    _buildColorButton(
                        Colors.black, textLayer.color, index, provider),
                    _buildColorButton(
                        Colors.red, textLayer.color, index, provider),
                    _buildColorButton(
                        Colors.blue, textLayer.color, index, provider),
                    _buildColorButton(
                        Colors.green, textLayer.color, index, provider),
                    _buildColorButton(
                        Colors.yellow, textLayer.color, index, provider),
                    _buildColorButton(AppColors.primaryPink, textLayer.color,
                        index, provider),
                    _buildColorButton(AppColors.secondaryOrange,
                        textLayer.color, index, provider),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildColorButton(Color color, Color currentColor, int index,
      VideoEditorProvider provider) {
    final isSelected = color.value == currentColor.value;
    return GestureDetector(
      onTap: () => provider.updateTextColor(index, color),
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
          border: Border.all(
            color: isSelected ? AppColors.primaryPink : Colors.grey,
            width: isSelected ? 3 : 1,
          ),
        ),
        child: isSelected
            ? const Icon(Icons.check, color: Colors.white, size: 20)
            : null,
      ),
    );
  }

  Widget _buildPhotoEditTab(VideoEditorProvider provider) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: ElevatedButton.icon(
            onPressed: () => _addPhoto(provider),
            icon: const Icon(Icons.add_photo_alternate_rounded),
            label: const Text('Add Photo from Gallery'),
            style: ElevatedButton.styleFrom(
              minimumSize: const Size(double.infinity, 50),
            ),
          ),
        ),
        if (provider.photoLayers.isEmpty)
          const Expanded(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.photo_library_outlined,
                      size: 64, color: AppColors.textTertiary),
                  SizedBox(height: 16),
                  Text('No photos added yet'),
                ],
              ),
            ),
          )
        else
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(16),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
              ),
              itemCount: provider.photoLayers.length,
              itemBuilder: (context, index) {
                final photo = provider.photoLayers[index];
                return Stack(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        image: DecorationImage(
                          image: FileImage(File(photo.imagePath)),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Positioned(
                      top: 4,
                      right: 4,
                      child: IconButton(
                        icon: const Icon(Icons.close, color: Colors.white),
                        onPressed: () => provider.removePhotoLayer(index),
                        style: IconButton.styleFrom(
                          backgroundColor: Colors.black54,
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
      ],
    );
  }

  Widget _buildMusicEditTab() {
    return Consumer<MusicProvider>(
      builder: (context, musicProvider, child) {
        if (musicProvider.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        return Column(
          children: [
            // Category filters
            SizedBox(
              height: 50,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: musicProvider.categories.length,
                itemBuilder: (context, index) {
                  final category = musicProvider.categories[index];
                  final isSelected =
                      musicProvider.selectedCategory == category;

                  return Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: ChoiceChip(
                      label: Text(musicProvider.getCategoryName(category)),
                      selected: isSelected,
                      onSelected: (selected) {
                        musicProvider.filterByCategory(
                            selected ? category : null);
                      },
                    ),
                  );
                },
              ),
            ),

            // Music tracks list
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: musicProvider.filteredTracks.length,
                itemBuilder: (context, index) {
                  final track = musicProvider.filteredTracks[index];
                  final editorProvider =
                      context.watch<VideoEditorProvider>();
                  final isSelected =
                      editorProvider.selectedMusicPath == track.assetPath;

                  return Card(
                    child: ListTile(
                      leading: Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          color: AppColors.primaryPurple.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Icon(Icons.music_note_rounded,
                            color: AppColors.primaryPurple),
                      ),
                      title: Text(track.name),
                      subtitle: Text(
                          '${track.artist} • ${track.durationSeconds}s'),
                      trailing: isSelected
                          ? const Icon(Icons.check_circle,
                              color: AppColors.success)
                          : null,
                      onTap: () {
                        editorProvider.updateMusicTrack(track.assetPath);
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildSettingsTab(VideoEditorProvider provider) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Video Settings',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Duration'),
                    SegmentedButton<int>(
                      segments: const [
                        ButtonSegment(value: 15, label: Text('15s')),
                        ButtonSegment(value: 30, label: Text('30s')),
                      ],
                      selected: {provider.durationSeconds},
                      onSelectionChanged: (Set<int> newSelection) {
                        provider.updateDuration(newSelection.first);
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                SwitchListTile(
                  title: const Text('Show Watermark'),
                  subtitle: const Text('Watch ad to remove'),
                  value: provider.hasWatermark,
                  onChanged: (value) {
                    if (!value) {
                      _showRemoveWatermarkDialog(provider);
                    } else {
                      provider.toggleWatermark();
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildGenerateButton(VideoEditorProvider provider) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.darkSurface,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 10,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: SafeArea(
        child: GradientButton(
          onPressed: provider.isGenerating ? null : () => _generateVideo(provider),
          child: provider.isGenerating
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(
                        color: Colors.white,
                        strokeWidth: 2,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Text(
                      'Generating... ${(provider.generationProgress * 100).toInt()}%',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                )
              : const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.video_library_rounded),
                    SizedBox(width: 8),
                    Text(
                      'Generate Video',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }

  Future<void> _addPhoto(VideoEditorProvider provider) async {
    // Request camera permission
    final hasPermission = await PermissionService.requestStoragePermission();

    if (!hasPermission) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Storage permission is required to add photos'),
          ),
        );
      }
      return;
    }

    // Pick image
    final XFile? image = await _imagePicker.pickImage(
      source: ImageSource.gallery,
      maxWidth: 1920,
      maxHeight: 1080,
      imageQuality: 85,
    );

    if (image != null) {
      final photoLayer = PhotoLayer(
        id: const Uuid().v4(),
        imagePath: image.path,
        position: const Offset(0.5, 0.5),
        scale: 1.0,
        startTime: 0.0,
        duration: provider.durationSeconds.toDouble(),
      );

      provider.addPhotoLayer(photoLayer);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Photo added successfully!'),
            backgroundColor: AppColors.success,
          ),
        );
      }
    }
  }

  Future<void> _generateVideo(VideoEditorProvider provider) async {
    try {
      provider.startGeneration();

      // Generate video
      final outputPath = await _videoGenerator.generateVideo(
        template: provider.currentTemplate!,
        textLayers: provider.textLayers,
        photoLayers: provider.photoLayers,
        animationLayers: provider.animationLayers,
        musicPath: provider.selectedMusicPath,
        includeWatermark: provider.hasWatermark,
        onProgress: (progress, status) {
          provider.updateGenerationProgress(progress, status);
        },
      );

      // Generate thumbnail
      final thumbnailPath =
          await _videoGenerator.generateThumbnail(outputPath);

      provider.completeGeneration();

      // Save to My Creations
      final project = UserProject(
        id: const Uuid().v4(),
        templateId: provider.currentTemplate!.id,
        templateName: provider.currentTemplate!.name,
        videoPath: outputPath,
        thumbnailPath: thumbnailPath ?? '',
        createdAt: DateTime.now(),
        durationSeconds: provider.durationSeconds,
        hasWatermark: provider.hasWatermark,
        customData: provider.getCustomData(),
      );

      if (mounted) {
        await context.read<UserProjectProvider>().addProject(project);

        // Increment video generation count and show ad if needed
        final adProvider = context.read<AdProvider>();
        await adProvider.incrementVideoGenerationCount();

        // Show success dialog
        _showSuccessDialog(outputPath);
      }
    } catch (e) {
      provider.cancelGeneration();

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error generating video: $e'),
            backgroundColor: AppColors.error,
          ),
        );
      }
    }
  }

  void _showSuccessDialog(String videoPath) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Row(
          children: [
            Icon(Icons.check_circle, color: AppColors.success, size: 32),
            SizedBox(width: 12),
            Text('Video Created!'),
          ],
        ),
        content: const Text(
          'Your video has been created successfully! What would you like to do?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              _shareVideo(videoPath);
            },
            child: const Text('Share'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pop(context); // Back to templates
            },
            child: const Text('Create Another'),
          ),
        ],
      ),
    );
  }

  Future<void> _shareVideo(String videoPath) async {
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
                await ShareService.shareToWhatsAppStatus(videoPath);
              },
            ),
            ListTile(
              leading:
                  const Icon(Icons.camera_alt, color: AppColors.primaryPink),
              title: const Text('Instagram Story'),
              onTap: () async {
                Navigator.pop(context);
                await ShareService.shareToInstagramStory(videoPath);
              },
            ),
            ListTile(
              leading: const Icon(Icons.facebook, color: Colors.blue),
              title: const Text('Facebook'),
              onTap: () async {
                Navigator.pop(context);
                await ShareService.shareToFacebook(videoPath);
              },
            ),
            ListTile(
              leading: const Icon(Icons.share, color: AppColors.textPrimary),
              title: const Text('Other'),
              onTap: () async {
                Navigator.pop(context);
                await ShareService.shareVideo(videoPath);
              },
            ),
          ],
        ),
      ),
    );
  }

  void _showRemoveWatermarkDialog(VideoEditorProvider provider) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Remove Watermark'),
        content: const Text(
          'Watch a short ad to remove the watermark from this video?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () async {
              Navigator.pop(context);

              // Show rewarded ad
              final adProvider = context.read<AdProvider>();
              final rewardEarned = await adProvider.showRewardedAd();

              if (rewardEarned) {
                provider.removeWatermark();
                if (mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Watermark removed!'),
                      backgroundColor: AppColors.success,
                    ),
                  );
                }
              } else {
                if (mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Ad not ready. Please try again in a moment.'),
                    ),
                  );
                }
              }
            },
            child: const Text('Watch Ad'),
          ),
        ],
      ),
    );
  }

  void _showHelpDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Video Editor Help'),
        content: const SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'How to use:',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text('1. Edit text in the Text tab'),
              Text('2. Add photos in the Photos tab'),
              Text('3. Choose music in the Music tab'),
              Text('4. Adjust settings in the Settings tab'),
              Text('5. Tap Generate Video when ready'),
              SizedBox(height: 16),
              Text(
                'Tips:',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text('• You can customize text size and color'),
              Text('• Add up to 5 photos'),
              Text('• Watch an ad to remove watermark'),
              Text('• Choose 15s or 30s duration'),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Got it!'),
          ),
        ],
      ),
    );
  }
}
