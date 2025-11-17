import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../constants/app_colors.dart';
import '../../providers/video_editor_provider.dart';
import '../../widgets/gradient_button.dart';

/// Video editor screen
class VideoEditorScreen extends StatefulWidget {
  const VideoEditorScreen({super.key});

  @override
  State<VideoEditorScreen> createState() => _VideoEditorScreenState();
}

class _VideoEditorScreenState extends State<VideoEditorScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
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
            onPressed: () {
              // Show help dialog
              _showHelpDialog();
            },
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

              // Tab bar for editing tools
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

              // Tab views for editing
              Expanded(
                flex: 2,
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    _buildTextEditTab(provider),
                    _buildPhotoEditTab(provider),
                    _buildMusicEditTab(provider),
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

  /// Build preview area
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
            ),
            child: Stack(
              children: [
                // Text layers preview
                ...provider.textLayers.asMap().entries.map((entry) {
                  final layer = entry.value;
                  return Positioned(
                    left: layer.position.dx * 360 - 180,
                    top: layer.position.dy * 640 - 40,
                    child: Text(
                      layer.text,
                      style: TextStyle(
                        fontFamily: layer.fontFamily,
                        fontSize: layer.fontSize * 0.5, // Scale down for preview
                        color: layer.color,
                        fontWeight: layer.fontWeight,
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

  /// Build text edit tab
  Widget _buildTextEditTab(VideoEditorProvider provider) {
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
                        onChanged: (value) {
                          provider.updateTextSize(index, value);
                        },
                      ),
                    ),
                    Text('${textLayer.fontSize.toInt()}'),
                  ],
                ),
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
                    _buildColorButton(
                        AppColors.primaryPink, textLayer.color, index, provider),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildColorButton(
      Color color, Color currentColor, int index, VideoEditorProvider provider) {
    final isSelected = color == currentColor;
    return GestureDetector(
      onTap: () => provider.updateTextColor(index, color),
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
          border: Border.all(
            color: isSelected ? AppColors.primaryPink : Colors.transparent,
            width: 3,
          ),
        ),
      ),
    );
  }

  /// Build photo edit tab
  Widget _buildPhotoEditTab(VideoEditorProvider provider) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.photo_library_rounded, size: 64, color: AppColors.textTertiary),
          const SizedBox(height: 16),
          const Text(
            'Photo editing coming soon!',
            style: TextStyle(fontSize: 16, color: AppColors.textSecondary),
          ),
          const SizedBox(height: 24),
          ElevatedButton.icon(
            onPressed: () {
              // TODO: Implement photo picker
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Photo picker not yet implemented')),
              );
            },
            icon: const Icon(Icons.add_photo_alternate_rounded),
            label: const Text('Add Photo'),
          ),
        ],
      ),
    );
  }

  /// Build music edit tab
  Widget _buildMusicEditTab(VideoEditorProvider provider) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.music_note_rounded, size: 64, color: AppColors.textTertiary),
          const SizedBox(height: 16),
          const Text(
            'Music library coming soon!',
            style: TextStyle(fontSize: 16, color: AppColors.textSecondary),
          ),
          const SizedBox(height: 8),
          Text(
            'Current: ${provider.selectedMusicPath ?? 'None'}',
            style: const TextStyle(fontSize: 12, color: AppColors.textTertiary),
          ),
        ],
      ),
    );
  }

  /// Build settings tab
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
                      // TODO: Show rewarded ad
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

  /// Build generate button
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
          onPressed: provider.isGenerating
              ? null
              : () {
                  _generateVideo(provider);
                },
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

  void _generateVideo(VideoEditorProvider provider) {
    // TODO: Implement actual video generation with FFmpeg
    provider.startGeneration();

    // Simulate generation progress
    Future.delayed(const Duration(seconds: 1), () {
      provider.updateGenerationProgress(0.3, 'Processing text layers...');
    });

    Future.delayed(const Duration(seconds: 2), () {
      provider.updateGenerationProgress(0.6, 'Adding effects...');
    });

    Future.delayed(const Duration(seconds: 3), () {
      provider.updateGenerationProgress(0.9, 'Finalizing video...');
    });

    Future.delayed(const Duration(seconds: 4), () {
      provider.completeGeneration();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Video generation coming soon!'),
          backgroundColor: AppColors.success,
        ),
      );
    });
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
            onPressed: () {
              // TODO: Show rewarded ad
              provider.removeWatermark();
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Watermark removed! (Ad not yet implemented)'),
                ),
              );
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
