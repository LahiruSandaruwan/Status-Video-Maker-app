# StatusPro - Viral Video Status Maker

> **Create stunning 15-30 second video status/stories for WhatsApp, Instagram & Facebook**

StatusPro is a mobile app that allows users to create professional-looking video status updates in under 2 minutes. Designed for the Sri Lankan, Indian, and Southeast Asian markets where status videos are extremely popular.

![StatusPro Banner](https://via.placeholder.com/1200x400/8B5CF6/FFFFFF?text=StatusPro+-+Viral+Video+Status+Maker)

## 🚀 Features

### ✨ Core Features
- **50+ Pre-made Templates** across 5 categories:
  - Love & Romance (15 templates)
  - Motivational (15 templates)
  - Birthday & Celebrations (10 templates)
  - Lyrics & Music (10 templates)
  - Photo Slideshow (10 templates)

- **Powerful Video Editor**:
  - Text customization (20+ fonts, colors, sizes, animations)
  - Photo editing (add, crop, filters, Ken Burns effect)
  - Music library (20+ royalty-free tracks)
  - Stickers & animated elements
  - 15s or 30s duration options

- **Professional Effects**:
  - Text animations (fade, slide, typewriter, bounce, etc.)
  - Photo transitions (fade, slide, zoom, cross-dissolve)
  - Instagram-style filters
  - Gradient backgrounds
  - Lottie animations

- **Easy Sharing**:
  - Direct share to WhatsApp Status
  - Share to Instagram Stories
  - Share to Facebook
  - Save to gallery

### 💰 Monetization (AdMob)
- Banner ads on home screen
- Interstitial ads after every 3 video generations
- Rewarded ads to remove watermark
- Rewarded ads for premium templates

## 📱 Screenshots

*Coming soon...*

## 🛠️ Technology Stack

- **Framework**: Flutter 3.x
- **Video Generation**: FFmpeg (ffmpeg_kit_flutter)
- **State Management**: Provider
- **Local Storage**: Hive
- **Ads**: Google Mobile Ads (AdMob)
- **Animations**: Lottie
- **Image Processing**: image package

## 📋 Prerequisites

Before you begin, ensure you have the following installed:

- Flutter SDK (3.0.0 or higher)
- Dart SDK (3.0.0 or higher)
- Android Studio / VS Code with Flutter extensions
- Xcode (for iOS development, macOS only)
- Git

## 🔧 Installation & Setup

### 1. Clone the Repository

```bash
git clone https://github.com/yourusername/statuspro.git
cd statuspro
```

### 2. Install Dependencies

```bash
flutter pub get
```

### 3. Generate Hive Adapters

The app uses Hive for local storage. Generate the adapters:

```bash
flutter packages pub run build_runner build
```

If you need to clean and rebuild:

```bash
flutter packages pub run build_runner build --delete-conflicting-outputs
```

### 4. Configure AdMob

1. **Android**: Edit `android/app/src/main/AndroidManifest.xml`

```xml
<manifest>
    <application>
        <!-- Add your AdMob App ID -->
        <meta-data
            android:name="com.google.android.gms.ads.APPLICATION_ID"
            android:value="ca-app-pub-XXXXXXXXXXXXXXXX~XXXXXXXXXX"/>
    </application>
</manifest>
```

2. **iOS**: Edit `ios/Runner/Info.plist`

```xml
<key>GADApplicationIdentifier</key>
<string>ca-app-pub-XXXXXXXXXXXXXXXX~XXXXXXXXXX</string>
```

3. **Update Ad Unit IDs** in `lib/constants/app_constants.dart`:

```dart
static const String adMobAppId = 'YOUR_ADMOB_APP_ID';
static const String bannerAdUnitId = 'YOUR_BANNER_AD_UNIT_ID';
static const String interstitialAdUnitId = 'YOUR_INTERSTITIAL_AD_UNIT_ID';
static const String rewardedAdUnitId = 'YOUR_REWARDED_AD_UNIT_ID';
```

### 5. Add Assets

Create placeholder assets in the following directories:

```
assets/
├── images/
│   └── templates/          # Template thumbnails
├── backgrounds/            # Background images/videos
├── music/                  # Royalty-free music tracks
├── stickers/              # Sticker images
└── lottie/                # Lottie animation files
```

**Download Royalty-Free Music** from:
- [YouTube Audio Library](https://www.youtube.com/audiolibrary)
- [Pixabay Music](https://pixabay.com/music/)
- [Uppbeat](https://uppbeat.io/)

**Download Lottie Animations** from:
- [LottieFiles](https://lottiefiles.com/)

### 6. Android Configuration

1. Update `android/app/build.gradle`:

```gradle
android {
    compileSdkVersion 33

    defaultConfig {
        applicationId "com.yourcompany.statuspro"
        minSdkVersion 21
        targetSdkVersion 33
        versionCode 1
        versionName "1.0.0"
    }
}
```

2. Add permissions in `android/app/src/main/AndroidManifest.xml`:

```xml
<uses-permission android:name="android.permission.INTERNET"/>
<uses-permission android:name="android.permission.READ_EXTERNAL_STORAGE"/>
<uses-permission android:name="android.permission.WRITE_EXTERNAL_STORAGE"/>
<uses-permission android:name="android.permission.CAMERA"/>
```

### 7. iOS Configuration

1. Update `ios/Runner/Info.plist`:

```xml
<key>NSPhotoLibraryUsageDescription</key>
<string>We need access to your photo library to add photos to your videos</string>
<key>NSCameraUsageDescription</key>
<string>We need access to your camera to take photos for your videos</string>
<key>NSMicrophoneUsageDescription</key>
<string>We need access to your microphone for video recording</string>
```

2. Update minimum iOS version in `ios/Podfile`:

```ruby
platform :ios, '12.0'
```

## 🏃 Running the App

### Debug Mode

```bash
# Run on connected device/emulator
flutter run

# Run on specific device
flutter run -d <device-id>

# Hot reload enabled by default - press 'r' to reload
```

### Release Mode

```bash
# Android
flutter build apk --release

# iOS
flutter build ios --release
```

## 📁 Project Structure

```
lib/
├── constants/              # App constants, colors, theme
│   ├── app_constants.dart
│   ├── app_colors.dart
│   └── app_theme.dart
├── data/                   # Static data (templates)
│   └── template_data.dart
├── models/                 # Data models
│   ├── video_template.dart
│   ├── text_layer.dart
│   ├── animation_layer.dart
│   ├── photo_layer.dart
│   ├── music_track.dart
│   └── user_project.dart
├── providers/              # State management
│   ├── template_provider.dart
│   ├── user_project_provider.dart
│   └── video_editor_provider.dart
├── screens/                # App screens
│   ├── main_navigation.dart
│   ├── home/
│   ├── create/
│   ├── editor/
│   ├── my_videos/
│   └── profile/
├── services/               # Business logic services
│   └── video_generator_service.dart  (TODO)
├── widgets/                # Reusable widgets
│   ├── template_card.dart
│   ├── category_chip.dart
│   ├── gradient_button.dart
│   └── gradient_text.dart
└── main.dart              # App entry point
```

## 🎨 Customization

### Adding New Templates

Edit `lib/data/template_data.dart`:

```dart
VideoTemplate(
  id: 'custom_001',
  name: 'My Custom Template',
  category: 'Love & Romance',
  thumbnailUrl: 'assets/images/templates/custom_001.jpg',
  durationSeconds: 15,
  aspectRatio: AspectRatioType.story9_16,
  backgroundType: BackgroundType.gradient,
  backgroundValue: LinearGradient(
    colors: [Color(0xFFFF6B9D), Color(0xFFC06C84)],
  ),
  textLayers: [
    TextLayer(
      id: 'text_1',
      defaultText: 'Your Text Here',
      fontFamily: 'Poppins',
      fontSize: 48.0,
      // ... more properties
    ),
  ],
  // ... more configuration
)
```

### Changing Theme Colors

Edit `lib/constants/app_colors.dart`:

```dart
class AppColors {
  static const Color primaryPurple = Color(0xFF8B5CF6);
  static const Color primaryPink = Color(0xFFEC4899);
  // ... modify colors
}
```

## 🚀 Deployment

### Android (Google Play Store)

1. **Create a Keystore**:

```bash
keytool -genkey -v -keystore ~/upload-keystore.jks -keyalg RSA -keysize 2048 -validity 10000 -alias upload
```

2. **Configure Signing**: Create `android/key.properties`:

```properties
storePassword=<password>
keyPassword=<password>
keyAlias=upload
storeFile=<path-to-keystore>
```

3. **Update `android/app/build.gradle`**:

```gradle
def keystoreProperties = new Properties()
def keystorePropertiesFile = rootProject.file('key.properties')
if (keystorePropertiesFile.exists()) {
    keystoreProperties.load(new FileInputStream(keystorePropertiesFile))
}

android {
    signingConfigs {
        release {
            keyAlias keystoreProperties['keyAlias']
            keyPassword keystoreProperties['keyPassword']
            storeFile keystoreProperties['storeFile'] ? file(keystoreProperties['storeFile']) : null
            storePassword keystoreProperties['storePassword']
        }
    }
    buildTypes {
        release {
            signingConfig signingConfigs.release
        }
    }
}
```

4. **Build Release APK**:

```bash
flutter build apk --release
flutter build appbundle --release  # For Play Store
```

### iOS (App Store)

1. Open Xcode: `open ios/Runner.xcworkspace`
2. Update Bundle Identifier and Team
3. Archive and Upload to App Store Connect

## 📊 Expected Performance

### Revenue Projections (AdMob)

- **1,000 DAU**: $5-15/day
- **10,000 DAU**: $50-150/day
- **100,000 DAU**: $500-1,500/day

### Optimization Tips

- Use FFmpeg preset `ultrafast` for preview, `medium` for final render
- Cache rendered elements
- Lazy load templates
- Optimize image sizes
- Use video_thumbnail for quick previews

## 🎯 Roadmap

### Phase 1: MVP (Current)
- ✅ 20+ templates
- ✅ Basic text and photo editing
- ✅ Template library with filters
- ✅ AdMob integration
- ⏳ FFmpeg video generation

### Phase 2: Growth
- 📝 50+ templates
- 📝 Advanced animations
- 📝 More music tracks
- 📝 Stickers and elements
- 📝 Push notifications

### Phase 3: Viral Features
- 📝 User-submitted templates
- 📝 Template marketplace
- 📝 Premium subscription
- 📝 Advanced editing tools
- 📝 Social features

## 🐛 Troubleshooting

### Common Issues

**Issue**: FFmpeg not working
```bash
# Solution: Ensure ffmpeg_kit_flutter is properly installed
flutter pub get
cd ios && pod install
```

**Issue**: Ads not showing
```bash
# Solution: Check AdMob configuration and use test ad units during development
# Test ad units are already configured in app_constants.dart
```

**Issue**: Build errors
```bash
# Solution: Clean and rebuild
flutter clean
flutter pub get
flutter run
```

## 📝 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🤝 Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

1. Fork the project
2. Create your feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## 💬 Support

For support, email support@statuspro.com or create an issue on GitHub.

## 🙏 Acknowledgments

- Flutter Team for the amazing framework
- FFmpeg for video processing capabilities
- Google Fonts for beautiful typography
- LottieFiles for animations
- Free music providers for royalty-free tracks

---

**Made with ❤️ for content creators worldwide**

## 🔗 Links

- [Google Play Store](#) (Coming soon)
- [App Store](#) (Coming soon)
- [Website](#) (Coming soon)
- [Documentation](#) (Coming soon)

---

**Keywords**: video status maker, whatsapp status creator, instagram stories, video editor, status video, viral video maker, video template, social media content
