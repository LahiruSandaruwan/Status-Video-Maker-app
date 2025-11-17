/// Represents a music track available in the app
class MusicTrack {
  final String id;
  final String name;
  final String artist;
  final MusicCategory category;
  final String assetPath; // Path to audio file
  final int durationSeconds;
  final bool isPremium;
  final String? previewUrl; // For cloud-hosted tracks
  final String? thumbnailUrl;

  MusicTrack({
    required this.id,
    required this.name,
    this.artist = 'StatusPro',
    required this.category,
    required this.assetPath,
    required this.durationSeconds,
    this.isPremium = false,
    this.previewUrl,
    this.thumbnailUrl,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'artist': artist,
      'category': category.index,
      'assetPath': assetPath,
      'durationSeconds': durationSeconds,
      'isPremium': isPremium,
      'previewUrl': previewUrl,
      'thumbnailUrl': thumbnailUrl,
    };
  }

  factory MusicTrack.fromJson(Map<String, dynamic> json) {
    return MusicTrack(
      id: json['id'],
      name: json['name'],
      artist: json['artist'] ?? 'StatusPro',
      category: MusicCategory.values[json['category']],
      assetPath: json['assetPath'],
      durationSeconds: json['durationSeconds'],
      isPremium: json['isPremium'] ?? false,
      previewUrl: json['previewUrl'],
      thumbnailUrl: json['thumbnailUrl'],
    );
  }
}

/// Music categories
enum MusicCategory {
  upbeat,
  romantic,
  motivational,
  chill,
  epic,
  emotional,
}
