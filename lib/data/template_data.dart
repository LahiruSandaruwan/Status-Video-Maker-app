import 'package:flutter/material.dart';
import '../models/video_template.dart';
import '../models/text_layer.dart';
import '../models/animation_layer.dart';
import '../models/photo_layer.dart';

/// Pre-defined video templates
class TemplateData {
  static List<VideoTemplate> getAllTemplates() {
    return [
      ...getLoveTemplates(),
      ...getMotivationalTemplates(),
      ...getBirthdayTemplates(),
      ...getLyricsTemplates(),
      ...getPhotoSlideshowTemplates(),
    ];
  }

  /// Love & Romance Templates (15 templates)
  static List<VideoTemplate> getLoveTemplates() {
    return [
      // Template 1: Love Quote with Hearts
      VideoTemplate(
        id: 'love_001',
        name: 'Romantic Hearts',
        category: 'Love & Romance',
        thumbnailUrl: 'assets/images/templates/love_001.jpg',
        durationSeconds: 15,
        aspectRatio: AspectRatioType.story9_16,
        backgroundType: BackgroundType.gradient,
        backgroundValue: const LinearGradient(
          colors: [Color(0xFFFF6B9D), Color(0xFFC06C84)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
        textLayers: [
          TextLayer(
            id: 'text_1',
            defaultText: 'I Love You',
            fontFamily: 'Pacifico',
            fontSize: 48.0,
            color: Colors.white,
            position: const Offset(0.5, 0.3),
            animationType: TextAnimationType.fadeIn,
            animationStartTime: 0.5,
            animationDuration: 1.5,
          ),
          TextLayer(
            id: 'text_2',
            defaultText: 'To the moon and back',
            fontFamily: 'Poppins',
            fontSize: 24.0,
            color: Colors.white70,
            position: const Offset(0.5, 0.45),
            animationType: TextAnimationType.slideFromBottom,
            animationStartTime: 2.0,
            animationDuration: 1.0,
          ),
        ],
        animationLayers: [
          AnimationLayer(
            id: 'heart_1',
            type: AnimationLayerType.lottie,
            assetPath: 'assets/lottie/hearts.json',
            position: const Offset(0.5, 0.6),
            scale: 1.5,
            startTime: 0.0,
            duration: 15.0,
          ),
        ],
        defaultMusicPath: 'assets/music/romantic_01.mp3',
        tags: ['love', 'romance', 'hearts', 'valentine'],
      ),

      // Template 2: Love Quote Simple
      VideoTemplate(
        id: 'love_002',
        name: 'Love Quote Classic',
        category: 'Love & Romance',
        thumbnailUrl: 'assets/images/templates/love_002.jpg',
        durationSeconds: 15,
        aspectRatio: AspectRatioType.story9_16,
        backgroundType: BackgroundType.gradient,
        backgroundValue: const LinearGradient(
          colors: [Color(0xFFEE9CA7), Color(0xFFFFDDE1)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        textLayers: [
          TextLayer(
            id: 'text_1',
            defaultText: 'Every love story is beautiful,',
            fontFamily: 'Playfair Display',
            fontSize: 32.0,
            color: const Color(0xFF2D2D2D),
            position: const Offset(0.5, 0.35),
            animationType: TextAnimationType.typewriter,
            animationStartTime: 1.0,
            animationDuration: 3.0,
          ),
          TextLayer(
            id: 'text_2',
            defaultText: 'but ours is my favorite',
            fontFamily: 'Dancing Script',
            fontSize: 36.0,
            color: const Color(0xFFFF6B9D),
            position: const Offset(0.5, 0.55),
            animationType: TextAnimationType.fadeIn,
            animationStartTime: 4.5,
            animationDuration: 1.5,
          ),
        ],
        defaultMusicPath: 'assets/music/romantic_02.mp3',
        tags: ['love', 'quote', 'simple', 'elegant'],
      ),

      // Template 3: You & Me
      VideoTemplate(
        id: 'love_003',
        name: 'You & Me Forever',
        category: 'Love & Romance',
        thumbnailUrl: 'assets/images/templates/love_003.jpg',
        durationSeconds: 15,
        aspectRatio: AspectRatioType.story9_16,
        backgroundType: BackgroundType.gradient,
        backgroundValue: const LinearGradient(
          colors: [Color(0xFF667EEA), Color(0xFF764BA2)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        textLayers: [
          TextLayer(
            id: 'text_1',
            defaultText: 'YOU',
            fontFamily: 'Bebas Neue',
            fontSize: 60.0,
            color: Colors.white,
            position: const Offset(0.3, 0.4),
            animationType: TextAnimationType.slideFromLeft,
            animationStartTime: 0.5,
            animationDuration: 1.0,
          ),
          TextLayer(
            id: 'text_2',
            defaultText: '&',
            fontFamily: 'Pacifico',
            fontSize: 48.0,
            color: const Color(0xFFFF6B9D),
            position: const Offset(0.5, 0.45),
            animationType: TextAnimationType.scale,
            animationStartTime: 1.5,
            animationDuration: 0.8,
          ),
          TextLayer(
            id: 'text_3',
            defaultText: 'ME',
            fontFamily: 'Bebas Neue',
            fontSize: 60.0,
            color: Colors.white,
            position: const Offset(0.7, 0.5),
            animationType: TextAnimationType.slideFromRight,
            animationStartTime: 2.3,
            animationDuration: 1.0,
          ),
          TextLayer(
            id: 'text_4',
            defaultText: 'FOREVER',
            fontFamily: 'Poppins',
            fontSize: 28.0,
            color: Colors.white70,
            position: const Offset(0.5, 0.65),
            animationType: TextAnimationType.fadeIn,
            animationStartTime: 3.5,
            animationDuration: 1.5,
          ),
        ],
        defaultMusicPath: 'assets/music/romantic_01.mp3',
        tags: ['love', 'couple', 'forever', 'romantic'],
      ),

      // Template 4: Missing You
      VideoTemplate(
        id: 'love_004',
        name: 'Missing You',
        category: 'Love & Romance',
        thumbnailUrl: 'assets/images/templates/love_004.jpg',
        durationSeconds: 15,
        aspectRatio: AspectRatioType.story9_16,
        backgroundType: BackgroundType.gradient,
        backgroundValue: const LinearGradient(
          colors: [Color(0xFF232526), Color(0xFF414345)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
        textLayers: [
          TextLayer(
            id: 'text_1',
            defaultText: 'Missing You',
            fontFamily: 'Satisfy',
            fontSize: 52.0,
            color: const Color(0xFFFF6B9D),
            position: const Offset(0.5, 0.4),
            animationType: TextAnimationType.pulse,
            animationStartTime: 0.5,
            animationDuration: 2.0,
          ),
          TextLayer(
            id: 'text_2',
            defaultText: 'Every moment without you feels incomplete',
            fontFamily: 'Poppins',
            fontSize: 20.0,
            color: Colors.white70,
            position: const Offset(0.5, 0.55),
            animationType: TextAnimationType.fadeIn,
            animationStartTime: 2.5,
            animationDuration: 1.5,
          ),
        ],
        animationLayers: [
          AnimationLayer(
            id: 'sparkle_1',
            type: AnimationLayerType.lottie,
            assetPath: 'assets/lottie/sparkles.json',
            position: const Offset(0.5, 0.7),
            scale: 1.2,
            startTime: 0.0,
            duration: 15.0,
          ),
        ],
        defaultMusicPath: 'assets/music/emotional_01.mp3',
        tags: ['missing', 'love', 'emotional', 'longing'],
      ),

      // Template 5: Anniversary
      VideoTemplate(
        id: 'love_005',
        name: 'Happy Anniversary',
        category: 'Love & Romance',
        thumbnailUrl: 'assets/images/templates/love_005.jpg',
        durationSeconds: 15,
        aspectRatio: AspectRatioType.story9_16,
        backgroundType: BackgroundType.gradient,
        backgroundValue: const LinearGradient(
          colors: [Color(0xFFFFAFBD), Color(0xFFFFC3A0)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
        textLayers: [
          TextLayer(
            id: 'text_1',
            defaultText: 'Happy Anniversary',
            fontFamily: 'Dancing Script',
            fontSize: 48.0,
            color: const Color(0xFFFF6B9D),
            position: const Offset(0.5, 0.35),
            animationType: TextAnimationType.bounce,
            animationStartTime: 0.5,
            animationDuration: 1.5,
          ),
          TextLayer(
            id: 'text_2',
            defaultText: 'To many more years together',
            fontFamily: 'Poppins',
            fontSize: 22.0,
            color: const Color(0xFF2D2D2D),
            position: const Offset(0.5, 0.5),
            animationType: TextAnimationType.slideFromBottom,
            animationStartTime: 2.0,
            animationDuration: 1.0,
          ),
        ],
        animationLayers: [
          AnimationLayer(
            id: 'confetti_1',
            type: AnimationLayerType.lottie,
            assetPath: 'assets/lottie/confetti.json',
            position: const Offset(0.5, 0.5),
            scale: 1.5,
            startTime: 0.0,
            duration: 15.0,
          ),
        ],
        defaultMusicPath: 'assets/music/romantic_03.mp3',
        tags: ['anniversary', 'celebration', 'love', 'together'],
      ),
    ];
  }

  /// Motivational Templates (15 templates)
  static List<VideoTemplate> getMotivationalTemplates() {
    return [
      // Template 1: Success Quote
      VideoTemplate(
        id: 'motivational_001',
        name: 'Success Mindset',
        category: 'Motivational',
        thumbnailUrl: 'assets/images/templates/motivational_001.jpg',
        durationSeconds: 15,
        aspectRatio: AspectRatioType.story9_16,
        backgroundType: BackgroundType.gradient,
        backgroundValue: const LinearGradient(
          colors: [Color(0xFF00C9FF), Color(0xFF92FE9D)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        textLayers: [
          TextLayer(
            id: 'text_1',
            defaultText: 'SUCCESS',
            fontFamily: 'Bebas Neue',
            fontSize: 64.0,
            color: Colors.white,
            position: const Offset(0.5, 0.35),
            animationType: TextAnimationType.scale,
            animationStartTime: 0.5,
            animationDuration: 1.0,
            hasStroke: true,
            strokeColor: Colors.black,
            strokeWidth: 3.0,
          ),
          TextLayer(
            id: 'text_2',
            defaultText: 'IS NOT FINAL',
            fontFamily: 'Oswald',
            fontSize: 32.0,
            color: Colors.white,
            position: const Offset(0.5, 0.45),
            animationType: TextAnimationType.slideFromLeft,
            animationStartTime: 1.5,
            animationDuration: 0.8,
          ),
          TextLayer(
            id: 'text_3',
            defaultText: 'FAILURE IS NOT FATAL',
            fontFamily: 'Oswald',
            fontSize: 32.0,
            color: Colors.white,
            position: const Offset(0.5, 0.53),
            animationType: TextAnimationType.slideFromRight,
            animationStartTime: 2.3,
            animationDuration: 0.8,
          ),
          TextLayer(
            id: 'text_4',
            defaultText: 'IT\'S COURAGE THAT COUNTS',
            fontFamily: 'Poppins',
            fontSize: 22.0,
            color: const Color(0xFFFFD700),
            position: const Offset(0.5, 0.65),
            animationType: TextAnimationType.fadeIn,
            animationStartTime: 3.5,
            animationDuration: 1.5,
            fontWeight: FontWeight.bold,
          ),
        ],
        defaultMusicPath: 'assets/music/motivational_01.mp3',
        tags: ['success', 'motivation', 'inspiration', 'mindset'],
      ),

      // Template 2: Dream Big
      VideoTemplate(
        id: 'motivational_002',
        name: 'Dream Big',
        category: 'Motivational',
        thumbnailUrl: 'assets/images/templates/motivational_002.jpg',
        durationSeconds: 15,
        aspectRatio: AspectRatioType.story9_16,
        backgroundType: BackgroundType.gradient,
        backgroundValue: const LinearGradient(
          colors: [Color(0xFF8E2DE2), Color(0xFF4A00E0)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
        textLayers: [
          TextLayer(
            id: 'text_1',
            defaultText: 'DREAM',
            fontFamily: 'Righteous',
            fontSize: 72.0,
            color: Colors.white,
            position: const Offset(0.5, 0.4),
            animationType: TextAnimationType.bounce,
            animationStartTime: 0.5,
            animationDuration: 1.0,
          ),
          TextLayer(
            id: 'text_2',
            defaultText: 'BIG',
            fontFamily: 'Righteous',
            fontSize: 72.0,
            color: const Color(0xFFFFD700),
            position: const Offset(0.5, 0.52),
            animationType: TextAnimationType.scale,
            animationStartTime: 1.5,
            animationDuration: 1.0,
          ),
          TextLayer(
            id: 'text_3',
            defaultText: 'Work Hard • Stay Focused',
            fontFamily: 'Poppins',
            fontSize: 20.0,
            color: Colors.white70,
            position: const Offset(0.5, 0.68),
            animationType: TextAnimationType.fadeIn,
            animationStartTime: 2.5,
            animationDuration: 1.5,
          ),
        ],
        defaultMusicPath: 'assets/music/motivational_02.mp3',
        tags: ['dream', 'goals', 'motivation', 'ambition'],
      ),

      // Template 3: Never Give Up
      VideoTemplate(
        id: 'motivational_003',
        name: 'Never Give Up',
        category: 'Motivational',
        thumbnailUrl: 'assets/images/templates/motivational_003.jpg',
        durationSeconds: 15,
        aspectRatio: AspectRatioType.story9_16,
        backgroundType: BackgroundType.gradient,
        backgroundValue: const LinearGradient(
          colors: [Color(0xFFFF512F), Color(0xFFDD2476)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        textLayers: [
          TextLayer(
            id: 'text_1',
            defaultText: 'NEVER',
            fontFamily: 'Bebas Neue',
            fontSize: 56.0,
            color: Colors.white,
            position: const Offset(0.5, 0.35),
            animationType: TextAnimationType.slideFromTop,
            animationStartTime: 0.5,
            animationDuration: 0.8,
          ),
          TextLayer(
            id: 'text_2',
            defaultText: 'GIVE',
            fontFamily: 'Bebas Neue',
            fontSize: 56.0,
            color: Colors.white,
            position: const Offset(0.5, 0.45),
            animationType: TextAnimationType.slideFromLeft,
            animationStartTime: 1.3,
            animationDuration: 0.8,
          ),
          TextLayer(
            id: 'text_3',
            defaultText: 'UP',
            fontFamily: 'Bebas Neue',
            fontSize: 56.0,
            color: Colors.white,
            position: const Offset(0.5, 0.55),
            animationType: TextAnimationType.slideFromRight,
            animationStartTime: 2.1,
            animationDuration: 0.8,
          ),
        ],
        defaultMusicPath: 'assets/music/epic_01.mp3',
        tags: ['perseverance', 'motivation', 'strength', 'determination'],
      ),

      // Template 4: Hustle
      VideoTemplate(
        id: 'motivational_004',
        name: 'Hustle Hard',
        category: 'Motivational',
        thumbnailUrl: 'assets/images/templates/motivational_004.jpg',
        durationSeconds: 15,
        aspectRatio: AspectRatioType.story9_16,
        backgroundType: BackgroundType.gradient,
        backgroundValue: const LinearGradient(
          colors: [Color(0xFF000000), Color(0xFF434343)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
        textLayers: [
          TextLayer(
            id: 'text_1',
            defaultText: 'HUSTLE',
            fontFamily: 'Bebas Neue',
            fontSize: 68.0,
            color: const Color(0xFFFFD700),
            position: const Offset(0.5, 0.4),
            animationType: TextAnimationType.pulse,
            animationStartTime: 0.5,
            animationDuration: 1.5,
            hasStroke: true,
            strokeColor: Colors.black,
            strokeWidth: 4.0,
          ),
          TextLayer(
            id: 'text_2',
            defaultText: 'Until your haters ask if you\'re hiring',
            fontFamily: 'Poppins',
            fontSize: 20.0,
            color: Colors.white,
            position: const Offset(0.5, 0.55),
            animationType: TextAnimationType.typewriter,
            animationStartTime: 2.0,
            animationDuration: 2.5,
          ),
        ],
        defaultMusicPath: 'assets/music/motivational_03.mp3',
        tags: ['hustle', 'grind', 'entrepreneur', 'success'],
      ),

      // Template 5: Be Unstoppable
      VideoTemplate(
        id: 'motivational_005',
        name: 'Unstoppable',
        category: 'Motivational',
        thumbnailUrl: 'assets/images/templates/motivational_005.jpg',
        durationSeconds: 15,
        aspectRatio: AspectRatioType.story9_16,
        backgroundType: BackgroundType.gradient,
        backgroundValue: const LinearGradient(
          colors: [Color(0xFF2193B0), Color(0xFF6DD5ED)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        textLayers: [
          TextLayer(
            id: 'text_1',
            defaultText: 'BE',
            fontFamily: 'Oswald',
            fontSize: 48.0,
            color: Colors.white,
            position: const Offset(0.5, 0.35),
            animationType: TextAnimationType.fadeIn,
            animationStartTime: 0.5,
            animationDuration: 1.0,
          ),
          TextLayer(
            id: 'text_2',
            defaultText: 'UNSTOPPABLE',
            fontFamily: 'Bebas Neue',
            fontSize: 56.0,
            color: const Color(0xFFFFD700),
            position: const Offset(0.5, 0.48),
            animationType: TextAnimationType.scale,
            animationStartTime: 1.5,
            animationDuration: 1.2,
            hasStroke: true,
            strokeColor: Colors.black,
            strokeWidth: 3.0,
          ),
        ],
        defaultMusicPath: 'assets/music/epic_02.mp3',
        tags: ['unstoppable', 'power', 'motivation', 'strength'],
      ),
    ];
  }

  /// Birthday & Celebrations Templates (10 templates)
  static List<VideoTemplate> getBirthdayTemplates() {
    return [
      // Template 1: Happy Birthday Classic
      VideoTemplate(
        id: 'birthday_001',
        name: 'Happy Birthday Classic',
        category: 'Birthday & Celebrations',
        thumbnailUrl: 'assets/images/templates/birthday_001.jpg',
        durationSeconds: 15,
        aspectRatio: AspectRatioType.story9_16,
        backgroundType: BackgroundType.gradient,
        backgroundValue: const LinearGradient(
          colors: [Color(0xFFFFB800), Color(0xFFFF8E53)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
        textLayers: [
          TextLayer(
            id: 'text_1',
            defaultText: 'Happy Birthday!',
            fontFamily: 'Pacifico',
            fontSize: 52.0,
            color: Colors.white,
            position: const Offset(0.5, 0.4),
            animationType: TextAnimationType.bounce,
            animationStartTime: 0.5,
            animationDuration: 1.5,
            hasStroke: true,
            strokeColor: const Color(0xFFFF6B6B),
            strokeWidth: 3.0,
          ),
          TextLayer(
            id: 'text_2',
            defaultText: 'Wishing you a day filled with joy!',
            fontFamily: 'Poppins',
            fontSize: 22.0,
            color: Colors.white,
            position: const Offset(0.5, 0.55),
            animationType: TextAnimationType.fadeIn,
            animationStartTime: 2.0,
            animationDuration: 1.5,
          ),
        ],
        animationLayers: [
          AnimationLayer(
            id: 'confetti_1',
            type: AnimationLayerType.lottie,
            assetPath: 'assets/lottie/confetti.json',
            position: const Offset(0.5, 0.5),
            scale: 1.5,
            startTime: 0.0,
            duration: 15.0,
          ),
        ],
        defaultMusicPath: 'assets/music/upbeat_01.mp3',
        tags: ['birthday', 'celebration', 'party', 'happy'],
      ),

      // Template 2: Birthday Wishes
      VideoTemplate(
        id: 'birthday_002',
        name: 'Birthday Wishes',
        category: 'Birthday & Celebrations',
        thumbnailUrl: 'assets/images/templates/birthday_002.jpg',
        durationSeconds: 15,
        aspectRatio: AspectRatioType.story9_16,
        backgroundType: BackgroundType.gradient,
        backgroundValue: const LinearGradient(
          colors: [Color(0xFFDA22FF), Color(0xFF9733EE)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        textLayers: [
          TextLayer(
            id: 'text_1',
            defaultText: 'Make a Wish!',
            fontFamily: 'Lobster',
            fontSize: 48.0,
            color: Colors.white,
            position: const Offset(0.5, 0.35),
            animationType: TextAnimationType.scale,
            animationStartTime: 0.5,
            animationDuration: 1.2,
          ),
          TextLayer(
            id: 'text_2',
            defaultText: 'May all your dreams come true',
            fontFamily: 'Poppins',
            fontSize: 20.0,
            color: Colors.white70,
            position: const Offset(0.5, 0.5),
            animationType: TextAnimationType.slideFromBottom,
            animationStartTime: 1.7,
            animationDuration: 1.0,
          ),
        ],
        defaultMusicPath: 'assets/music/upbeat_02.mp3',
        tags: ['birthday', 'wishes', 'dreams', 'celebration'],
      ),

      // Template 3: Celebration Time
      VideoTemplate(
        id: 'birthday_003',
        name: 'Celebration Time',
        category: 'Birthday & Celebrations',
        thumbnailUrl: 'assets/images/templates/birthday_003.jpg',
        durationSeconds: 15,
        aspectRatio: AspectRatioType.story9_16,
        backgroundType: BackgroundType.gradient,
        backgroundValue: const LinearGradient(
          colors: [Color(0xFF00F260), Color(0xFF0575E6)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
        textLayers: [
          TextLayer(
            id: 'text_1',
            defaultText: 'LET\'S CELEBRATE!',
            fontFamily: 'Bebas Neue',
            fontSize: 56.0,
            color: Colors.white,
            position: const Offset(0.5, 0.45),
            animationType: TextAnimationType.pulse,
            animationStartTime: 0.5,
            animationDuration: 2.0,
            hasStroke: true,
            strokeColor: Colors.black,
            strokeWidth: 3.0,
          ),
        ],
        animationLayers: [
          AnimationLayer(
            id: 'party_1',
            type: AnimationLayerType.lottie,
            assetPath: 'assets/lottie/party.json',
            position: const Offset(0.5, 0.3),
            scale: 1.3,
            startTime: 0.0,
            duration: 15.0,
          ),
        ],
        defaultMusicPath: 'assets/music/upbeat_03.mp3',
        tags: ['celebration', 'party', 'fun', 'joy'],
      ),
    ];
  }

  /// Lyrics & Music Templates (10 templates)
  static List<VideoTemplate> getLyricsTemplates() {
    return [
      // Template 1: Song Lyrics Simple
      VideoTemplate(
        id: 'lyrics_001',
        name: 'Lyrics Classic',
        category: 'Lyrics & Music',
        thumbnailUrl: 'assets/images/templates/lyrics_001.jpg',
        durationSeconds: 15,
        aspectRatio: AspectRatioType.story9_16,
        backgroundType: BackgroundType.gradient,
        backgroundValue: const LinearGradient(
          colors: [Color(0xFF7F00FF), Color(0xFFE100FF)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        textLayers: [
          TextLayer(
            id: 'text_1',
            defaultText: 'Your favorite lyrics here',
            fontFamily: 'Quicksand',
            fontSize: 36.0,
            color: Colors.white,
            position: const Offset(0.5, 0.4),
            animationType: TextAnimationType.typewriter,
            animationStartTime: 0.5,
            animationDuration: 3.0,
            textAlign: TextAlign.center,
          ),
          TextLayer(
            id: 'text_2',
            defaultText: '- Song Name',
            fontFamily: 'Poppins',
            fontSize: 20.0,
            color: Colors.white70,
            position: const Offset(0.5, 0.55),
            animationType: TextAnimationType.fadeIn,
            animationStartTime: 3.5,
            animationDuration: 1.0,
            fontWeight: FontWeight.w300,
          ),
        ],
        defaultMusicPath: 'assets/music/chill_01.mp3',
        tags: ['lyrics', 'music', 'song', 'quote'],
      ),

      // Template 2: Music Vibes
      VideoTemplate(
        id: 'lyrics_002',
        name: 'Music Vibes',
        category: 'Lyrics & Music',
        thumbnailUrl: 'assets/images/templates/lyrics_002.jpg',
        durationSeconds: 15,
        aspectRatio: AspectRatioType.story9_16,
        backgroundType: BackgroundType.gradient,
        backgroundValue: const LinearGradient(
          colors: [Color(0xFF1E3C72), Color(0xFF2A5298)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
        textLayers: [
          TextLayer(
            id: 'text_1',
            defaultText: 'VIBES',
            fontFamily: 'Righteous',
            fontSize: 64.0,
            color: const Color(0xFF00F5FF),
            position: const Offset(0.5, 0.4),
            animationType: TextAnimationType.pulse,
            animationStartTime: 0.5,
            animationDuration: 1.5,
            hasStroke: true,
            strokeColor: Colors.white,
            strokeWidth: 2.0,
          ),
          TextLayer(
            id: 'text_2',
            defaultText: 'Feeling the rhythm',
            fontFamily: 'Poppins',
            fontSize: 24.0,
            color: Colors.white,
            position: const Offset(0.5, 0.55),
            animationType: TextAnimationType.slideFromBottom,
            animationStartTime: 2.0,
            animationDuration: 1.0,
          ),
        ],
        defaultMusicPath: 'assets/music/chill_02.mp3',
        tags: ['music', 'vibes', 'rhythm', 'mood'],
      ),
    ];
  }

  /// Photo Slideshow Templates (10 templates)
  static List<VideoTemplate> getPhotoSlideshowTemplates() {
    return [
      // Template 1: Memories Slideshow
      VideoTemplate(
        id: 'photo_001',
        name: 'Memories Slideshow',
        category: 'Photo Slideshow',
        thumbnailUrl: 'assets/images/templates/photo_001.jpg',
        durationSeconds: 30,
        aspectRatio: AspectRatioType.story9_16,
        backgroundType: BackgroundType.blur,
        backgroundValue: const Color(0xFF1A1A1A),
        textLayers: [
          TextLayer(
            id: 'text_1',
            defaultText: 'Our Memories',
            fontFamily: 'Pacifico',
            fontSize: 44.0,
            color: Colors.white,
            position: const Offset(0.5, 0.15),
            animationType: TextAnimationType.fadeIn,
            animationStartTime: 0.5,
            animationDuration: 1.5,
          ),
        ],
        photoPlaceholders: [
          PhotoLayer(
            id: 'photo_1',
            imagePath: '',
            position: const Offset(0.5, 0.4),
            scale: 0.9,
            startTime: 1.0,
            duration: 5.0,
            transition: PhotoTransition.fade,
            enableKenBurns: true,
            kenBurnsScale: 1.1,
          ),
          PhotoLayer(
            id: 'photo_2',
            imagePath: '',
            position: const Offset(0.5, 0.4),
            scale: 0.9,
            startTime: 6.0,
            duration: 5.0,
            transition: PhotoTransition.slideLeft,
            enableKenBurns: true,
            kenBurnsScale: 1.1,
          ),
          PhotoLayer(
            id: 'photo_3',
            imagePath: '',
            position: const Offset(0.5, 0.4),
            scale: 0.9,
            startTime: 11.0,
            duration: 5.0,
            transition: PhotoTransition.zoom,
            enableKenBurns: true,
            kenBurnsScale: 1.2,
          ),
        ],
        defaultMusicPath: 'assets/music/emotional_02.mp3',
        tags: ['photos', 'memories', 'slideshow', 'collage'],
      ),

      // Template 2: Collage 3 Photos
      VideoTemplate(
        id: 'photo_002',
        name: 'Triple Collage',
        category: 'Photo Slideshow',
        thumbnailUrl: 'assets/images/templates/photo_002.jpg',
        durationSeconds: 15,
        aspectRatio: AspectRatioType.story9_16,
        backgroundType: BackgroundType.gradient,
        backgroundValue: const LinearGradient(
          colors: [Color(0xFF00D2FF), Color(0xFF3A7BD5)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        textLayers: [
          TextLayer(
            id: 'text_1',
            defaultText: 'Good Times',
            fontFamily: 'Lobster',
            fontSize: 40.0,
            color: Colors.white,
            position: const Offset(0.5, 0.1),
            animationType: TextAnimationType.slideFromTop,
            animationStartTime: 0.5,
            animationDuration: 1.0,
          ),
        ],
        photoPlaceholders: [
          PhotoLayer(
            id: 'photo_1',
            imagePath: '',
            position: const Offset(0.5, 0.3),
            scale: 0.4,
            startTime: 0.5,
            duration: 15.0,
            transition: PhotoTransition.fade,
          ),
          PhotoLayer(
            id: 'photo_2',
            imagePath: '',
            position: const Offset(0.5, 0.5),
            scale: 0.4,
            startTime: 1.0,
            duration: 14.0,
            transition: PhotoTransition.fade,
          ),
          PhotoLayer(
            id: 'photo_3',
            imagePath: '',
            position: const Offset(0.5, 0.7),
            scale: 0.4,
            startTime: 1.5,
            duration: 13.5,
            transition: PhotoTransition.fade,
          ),
        ],
        defaultMusicPath: 'assets/music/upbeat_02.mp3',
        tags: ['collage', 'photos', 'multiple', 'memories'],
      ),
    ];
  }

  /// Get templates by category
  static List<VideoTemplate> getTemplatesByCategory(String category) {
    switch (category) {
      case 'Love & Romance':
        return getLoveTemplates();
      case 'Motivational':
        return getMotivationalTemplates();
      case 'Birthday & Celebrations':
        return getBirthdayTemplates();
      case 'Lyrics & Music':
        return getLyricsTemplates();
      case 'Photo Slideshow':
        return getPhotoSlideshowTemplates();
      default:
        return getAllTemplates();
    }
  }

  /// Get trending templates (most used)
  static List<VideoTemplate> getTrendingTemplates() {
    final allTemplates = getAllTemplates();
    allTemplates.sort((a, b) => b.usageCount.compareTo(a.usageCount));
    return allTemplates.take(10).toList();
  }

  /// Search templates by keyword
  static List<VideoTemplate> searchTemplates(String query) {
    final allTemplates = getAllTemplates();
    final lowerQuery = query.toLowerCase();
    return allTemplates.where((template) {
      return template.name.toLowerCase().contains(lowerQuery) ||
          template.category.toLowerCase().contains(lowerQuery) ||
          template.tags.any((tag) => tag.toLowerCase().contains(lowerQuery));
    }).toList();
  }
}
