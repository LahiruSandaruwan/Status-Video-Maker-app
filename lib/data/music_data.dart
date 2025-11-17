import '../models/music_track.dart';

/// Music library data
class MusicData {
  /// Get all music tracks
  static List<MusicTrack> getAllTracks() {
    return [
      ...getRomanticTracks(),
      ...getMotivationalTracks(),
      ...getUpbeatTracks(),
      ...getChillTracks(),
      ...getEmotionalTracks(),
    ];
  }

  /// Romantic music tracks (5 tracks)
  static List<MusicTrack> getRomanticTracks() {
    return [
      MusicTrack(
        id: 'romantic_01',
        name: 'Romantic Moment',
        artist: 'Audio Library',
        category: MusicCategory.romantic,
        assetPath: 'assets/music/romantic/romantic_01.mp3',
        durationSeconds: 150,
        thumbnailUrl: 'assets/images/music/romantic.jpg',
      ),
      MusicTrack(
        id: 'romantic_02',
        name: 'Love Story',
        artist: 'Audio Library',
        category: MusicCategory.romantic,
        assetPath: 'assets/music/romantic/romantic_02.mp3',
        durationSeconds: 180,
        thumbnailUrl: 'assets/images/music/romantic.jpg',
      ),
      MusicTrack(
        id: 'romantic_03',
        name: 'Together Forever',
        artist: 'Audio Library',
        category: MusicCategory.romantic,
        assetPath: 'assets/music/romantic/romantic_03.mp3',
        durationSeconds: 165,
        thumbnailUrl: 'assets/images/music/romantic.jpg',
      ),
      MusicTrack(
        id: 'romantic_04',
        name: 'Heart to Heart',
        artist: 'Audio Library',
        category: MusicCategory.romantic,
        assetPath: 'assets/music/romantic/romantic_04.mp3',
        durationSeconds: 140,
        thumbnailUrl: 'assets/images/music/romantic.jpg',
      ),
      MusicTrack(
        id: 'romantic_05',
        name: 'Forever Young',
        artist: 'Audio Library',
        category: MusicCategory.romantic,
        assetPath: 'assets/music/romantic/romantic_05.mp3',
        durationSeconds: 155,
        thumbnailUrl: 'assets/images/music/romantic.jpg',
      ),
    ];
  }

  /// Motivational music tracks (5 tracks)
  static List<MusicTrack> getMotivationalTracks() {
    return [
      MusicTrack(
        id: 'motivational_01',
        name: 'Rise Up',
        artist: 'Epic Music',
        category: MusicCategory.motivational,
        assetPath: 'assets/music/motivational/motivational_01.mp3',
        durationSeconds: 160,
        thumbnailUrl: 'assets/images/music/motivational.jpg',
      ),
      MusicTrack(
        id: 'motivational_02',
        name: 'Success',
        artist: 'Epic Music',
        category: MusicCategory.motivational,
        assetPath: 'assets/music/motivational/motivational_02.mp3',
        durationSeconds: 145,
        thumbnailUrl: 'assets/images/music/motivational.jpg',
      ),
      MusicTrack(
        id: 'motivational_03',
        name: 'Never Give Up',
        artist: 'Epic Music',
        category: MusicCategory.motivational,
        assetPath: 'assets/music/motivational/motivational_03.mp3',
        durationSeconds: 170,
        thumbnailUrl: 'assets/images/music/motivational.jpg',
      ),
      MusicTrack(
        id: 'motivational_04',
        name: 'Dream Big',
        artist: 'Epic Music',
        category: MusicCategory.motivational,
        assetPath: 'assets/music/motivational/motivational_04.mp3',
        durationSeconds: 155,
        thumbnailUrl: 'assets/images/music/motivational.jpg',
      ),
      MusicTrack(
        id: 'motivational_05',
        name: 'Unstoppable',
        artist: 'Epic Music',
        category: MusicCategory.motivational,
        assetPath: 'assets/music/motivational/motivational_05.mp3',
        durationSeconds: 150,
        thumbnailUrl: 'assets/images/music/motivational.jpg',
      ),
    ];
  }

  /// Upbeat/Happy music tracks (5 tracks)
  static List<MusicTrack> getUpbeatTracks() {
    return [
      MusicTrack(
        id: 'upbeat_01',
        name: 'Happy Day',
        artist: 'Upbeat Collection',
        category: MusicCategory.upbeat,
        assetPath: 'assets/music/upbeat/upbeat_01.mp3',
        durationSeconds: 130,
        thumbnailUrl: 'assets/images/music/upbeat.jpg',
      ),
      MusicTrack(
        id: 'upbeat_02',
        name: 'Celebrate',
        artist: 'Upbeat Collection',
        category: MusicCategory.upbeat,
        assetPath: 'assets/music/upbeat/upbeat_02.mp3',
        durationSeconds: 140,
        thumbnailUrl: 'assets/images/music/upbeat.jpg',
      ),
      MusicTrack(
        id: 'upbeat_03',
        name: 'Good Vibes',
        artist: 'Upbeat Collection',
        category: MusicCategory.upbeat,
        assetPath: 'assets/music/upbeat/upbeat_03.mp3',
        durationSeconds: 135,
        thumbnailUrl: 'assets/images/music/upbeat.jpg',
      ),
      MusicTrack(
        id: 'upbeat_04',
        name: 'Birthday Party',
        artist: 'Upbeat Collection',
        category: MusicCategory.upbeat,
        assetPath: 'assets/music/upbeat/upbeat_04.mp3',
        durationSeconds: 125,
        thumbnailUrl: 'assets/images/music/upbeat.jpg',
      ),
      MusicTrack(
        id: 'upbeat_05',
        name: 'Sunshine',
        artist: 'Upbeat Collection',
        category: MusicCategory.upbeat,
        assetPath: 'assets/music/upbeat/upbeat_05.mp3',
        durationSeconds: 145,
        thumbnailUrl: 'assets/images/music/upbeat.jpg',
      ),
    ];
  }

  /// Chill/Lofi music tracks (5 tracks)
  static List<MusicTrack> getChillTracks() {
    return [
      MusicTrack(
        id: 'chill_01',
        name: 'Lofi Dreams',
        artist: 'Chill Beats',
        category: MusicCategory.chill,
        assetPath: 'assets/music/chill/chill_01.mp3',
        durationSeconds: 160,
        thumbnailUrl: 'assets/images/music/chill.jpg',
      ),
      MusicTrack(
        id: 'chill_02',
        name: 'Study Vibes',
        artist: 'Chill Beats',
        category: MusicCategory.chill,
        assetPath: 'assets/music/chill/chill_02.mp3',
        durationSeconds: 175,
        thumbnailUrl: 'assets/images/music/chill.jpg',
      ),
      MusicTrack(
        id: 'chill_03',
        name: 'Midnight',
        artist: 'Chill Beats',
        category: MusicCategory.chill,
        assetPath: 'assets/music/chill/chill_03.mp3',
        durationSeconds: 155,
        thumbnailUrl: 'assets/images/music/chill.jpg',
      ),
      MusicTrack(
        id: 'chill_04',
        name: 'Coffee Shop',
        artist: 'Chill Beats',
        category: MusicCategory.chill,
        assetPath: 'assets/music/chill/chill_04.mp3',
        durationSeconds: 140,
        thumbnailUrl: 'assets/images/music/chill.jpg',
      ),
      MusicTrack(
        id: 'chill_05',
        name: 'Chill Out',
        artist: 'Chill Beats',
        category: MusicCategory.chill,
        assetPath: 'assets/music/chill/chill_05.mp3',
        durationSeconds: 165,
        thumbnailUrl: 'assets/images/music/chill.jpg',
      ),
    ];
  }

  /// Emotional music tracks (5 tracks)
  static List<MusicTrack> getEmotionalTracks() {
    return [
      MusicTrack(
        id: 'emotional_01',
        name: 'Memories',
        artist: 'Emotional Collection',
        category: MusicCategory.emotional,
        assetPath: 'assets/music/emotional/emotional_01.mp3',
        durationSeconds: 170,
        thumbnailUrl: 'assets/images/music/emotional.jpg',
      ),
      MusicTrack(
        id: 'emotional_02',
        name: 'Reflection',
        artist: 'Emotional Collection',
        category: MusicCategory.emotional,
        assetPath: 'assets/music/emotional/emotional_02.mp3',
        durationSeconds: 185,
        thumbnailUrl: 'assets/images/music/emotional.jpg',
      ),
      MusicTrack(
        id: 'emotional_03',
        name: 'Missing You',
        artist: 'Emotional Collection',
        category: MusicCategory.emotional,
        assetPath: 'assets/music/emotional/emotional_03.mp3',
        durationSeconds: 160,
        thumbnailUrl: 'assets/images/music/emotional.jpg',
      ),
      MusicTrack(
        id: 'emotional_04',
        name: 'Time Passes',
        artist: 'Emotional Collection',
        category: MusicCategory.emotional,
        assetPath: 'assets/music/emotional/emotional_04.mp3',
        durationSeconds: 150,
        thumbnailUrl: 'assets/images/music/emotional.jpg',
      ),
      MusicTrack(
        id: 'emotional_05',
        name: 'Farewell',
        artist: 'Emotional Collection',
        category: MusicCategory.emotional,
        assetPath: 'assets/music/emotional/emotional_05.mp3',
        durationSeconds: 175,
        thumbnailUrl: 'assets/images/music/emotional.jpg',
      ),
    ];
  }

  /// Get tracks by category
  static List<MusicTrack> getTracksByCategory(MusicCategory category) {
    switch (category) {
      case MusicCategory.romantic:
        return getRomanticTracks();
      case MusicCategory.motivational:
        return getMotivationalTracks();
      case MusicCategory.upbeat:
        return getUpbeatTracks();
      case MusicCategory.chill:
        return getChillTracks();
      case MusicCategory.emotional:
        return getEmotionalTracks();
      default:
        return [];
    }
  }

  /// Search tracks by name
  static List<MusicTrack> searchTracks(String query) {
    final allTracks = getAllTracks();
    final lowerQuery = query.toLowerCase();

    return allTracks.where((track) {
      return track.name.toLowerCase().contains(lowerQuery) ||
          track.artist.toLowerCase().contains(lowerQuery);
    }).toList();
  }
}
