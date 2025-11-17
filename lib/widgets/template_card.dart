import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/video_template.dart';
import '../constants/app_colors.dart';
import '../providers/video_editor_provider.dart';
import '../screens/editor/video_editor_screen_updated.dart';

/// Template card widget for grid display
class TemplateCard extends StatelessWidget {
  final VideoTemplate template;

  const TemplateCard({
    super.key,
    required this.template,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Load template in editor and navigate
        context.read<VideoEditorProvider>().loadTemplate(template);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const VideoEditorScreenUpdated(),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.darkCard,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Thumbnail
            Stack(
              children: [
                // Placeholder thumbnail with gradient
                Container(
                  height: 180,
                  decoration: BoxDecoration(
                    gradient: _getGradientForCategory(template.category),
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(16),
                    ),
                  ),
                  child: Center(
                    child: Icon(
                      _getIconForCategory(template.category),
                      size: 48,
                      color: Colors.white.withOpacity(0.8),
                    ),
                  ),
                ),

                // Play icon overlay
                Positioned.fill(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(16),
                      ),
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          Colors.black.withOpacity(0.3),
                        ],
                      ),
                    ),
                    child: const Center(
                      child: Icon(
                        Icons.play_circle_outline_rounded,
                        size: 56,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),

                // Premium badge
                if (template.isPremium)
                  Positioned(
                    top: 8,
                    right: 8,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.secondaryOrange,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.star_rounded,
                            size: 12,
                            color: Colors.white,
                          ),
                          SizedBox(width: 4),
                          Text(
                            'PRO',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                // Duration badge
                Positioned(
                  bottom: 8,
                  right: 8,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.7),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      '${template.durationSeconds}s',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),

            // Template info
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    template.name,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textPrimary,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      const Icon(
                        Icons.category_rounded,
                        size: 12,
                        color: AppColors.textTertiary,
                      ),
                      const SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          template.category,
                          style: const TextStyle(
                            fontSize: 11,
                            color: AppColors.textTertiary,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  if (template.usageCount > 0) ...[
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        const Icon(
                          Icons.trending_up_rounded,
                          size: 12,
                          color: AppColors.success,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          '${template.usageCount} uses',
                          style: const TextStyle(
                            fontSize: 11,
                            color: AppColors.success,
                          ),
                        ),
                      ],
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Get gradient for category
  LinearGradient _getGradientForCategory(String category) {
    switch (category) {
      case 'Love & Romance':
        return const LinearGradient(
          colors: [AppColors.categoryLove, Color(0xFFC06C84)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        );
      case 'Motivational':
        return const LinearGradient(
          colors: [AppColors.categoryMotivational, Color(0xFF92FE9D)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        );
      case 'Birthday & Celebrations':
        return const LinearGradient(
          colors: [AppColors.categoryBirthday, Color(0xFFFF8E53)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        );
      case 'Lyrics & Music':
        return const LinearGradient(
          colors: [AppColors.categoryLyrics, Color(0xFFE100FF)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        );
      case 'Photo Slideshow':
        return const LinearGradient(
          colors: [AppColors.categoryPhoto, Color(0xFF3A7BD5)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        );
      default:
        return AppColors.primaryGradient;
    }
  }

  /// Get icon for category
  IconData _getIconForCategory(String category) {
    switch (category) {
      case 'Love & Romance':
        return Icons.favorite_rounded;
      case 'Motivational':
        return Icons.trending_up_rounded;
      case 'Birthday & Celebrations':
        return Icons.cake_rounded;
      case 'Lyrics & Music':
        return Icons.music_note_rounded;
      case 'Photo Slideshow':
        return Icons.photo_library_rounded;
      default:
        return Icons.video_library_rounded;
    }
  }
}
