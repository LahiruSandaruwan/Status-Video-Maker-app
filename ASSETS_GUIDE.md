# Assets Guide for StatusPro

This document provides detailed guidance on all the assets needed for the StatusPro app to function properly.

## 📁 Directory Structure

```
assets/
├── images/
│   ├── templates/          # Template thumbnails (23+ files)
│   └── music/             # Music category thumbnails (5 files)
├── music/                 # Royalty-free music tracks
│   ├── romantic/          # 5 romantic tracks
│   ├── motivational/      # 5 motivational tracks
│   ├── upbeat/           # 5 upbeat/happy tracks
│   ├── chill/            # 5 chill/lofi tracks
│   └── emotional/        # 5 emotional tracks
├── backgrounds/           # Background images/videos
├── stickers/             # Sticker PNG files with transparency
├── lottie/               # Lottie animation JSON files
└── fonts/                # Custom fonts (optional)
```

## 🎵 Music Tracks (REQUIRED)

### Total Needed: 25 MP3 files

Download royalty-free music from:
- YouTube Audio Library: https://studio.youtube.com/channel/UC/music
- Pixabay Music: https://pixabay.com/music/
- Uppbeat: https://uppbeat.io/
- Bensound: https://www.bensound.com/

### Specifications:
- **Format**: MP3
- **Bitrate**: 128-192 kbps
- **Sample Rate**: 44.1 kHz
- **Duration**: 30-180 seconds each
- **File Size**: < 3MB per track

### Required Tracks:

#### 1. Romantic (5 tracks)
```
assets/music/romantic/romantic_01.mp3
assets/music/romantic/romantic_02.mp3
assets/music/romantic/romantic_03.mp3
assets/music/romantic/romantic_04.mp3
assets/music/romantic/romantic_05.mp3
```

**Suggested searches**: "romantic piano", "love melody", "acoustic romantic"

#### 2. Motivational (5 tracks)
```
assets/music/motivational/motivational_01.mp3
assets/music/motivational/motivational_02.mp3
assets/music/motivational/motivational_03.mp3
assets/music/motivational/motivational_04.mp3
assets/music/motivational/motivational_05.mp3
```

**Suggested searches**: "epic inspirational", "motivational upbeat", "success theme"

#### 3. Upbeat/Happy (5 tracks)
```
assets/music/upbeat/upbeat_01.mp3
assets/music/upbeat/upbeat_02.mp3
assets/music/upbeat/upbeat_03.mp3
assets/music/upbeat/upbeat_04.mp3
assets/music/upbeat/upbeat_05.mp3
```

**Suggested searches**: "happy ukulele", "upbeat pop", "cheerful melody"

#### 4. Chill/Lofi (5 tracks)
```
assets/music/chill/chill_01.mp3
assets/music/chill/chill_02.mp3
assets/music/chill/chill_03.mp3
assets/music/chill/chill_04.mp3
assets/music/chill/chill_05.mp3
```

**Suggested searches**: "lofi hip hop", "chill beats", "study music"

#### 5. Emotional (5 tracks)
```
assets/music/emotional/emotional_01.mp3
assets/music/emotional/emotional_02.mp3
assets/music/emotional/emotional_03.mp3
assets/music/emotional/emotional_04.mp3
assets/music/emotional/emotional_05.mp3
```

**Suggested searches**: "emotional piano", "sad melody", "reflection music"

## 🖼️ Template Thumbnails

### Total Needed: 23+ PNG/JPG files

Create or generate thumbnail images for each template.

### Specifications:
- **Resolution**: 1080x1920 (9:16 aspect ratio)
- **Format**: JPG or PNG
- **File Size**: < 500KB per thumbnail
- **Quality**: High (for preview purposes)

### Required Files:
```
assets/images/templates/love_001.jpg
assets/images/templates/love_002.jpg
assets/images/templates/love_003.jpg
assets/images/templates/love_004.jpg
assets/images/templates/love_005.jpg
assets/images/templates/motivational_001.jpg
assets/images/templates/motivational_002.jpg
assets/images/templates/motivational_003.jpg
assets/images/templates/motivational_004.jpg
assets/images/templates/motivational_005.jpg
assets/images/templates/birthday_001.jpg
assets/images/templates/birthday_002.jpg
assets/images/templates/birthday_003.jpg
assets/images/templates/lyrics_001.jpg
assets/images/templates/lyrics_002.jpg
assets/images/templates/photo_001.jpg
assets/images/templates/photo_002.jpg
```

### How to Create Thumbnails:
1. **Option A**: Use Canva (free tier)
   - Create 1080x1920 designs matching template styles
   - Export as JPG

2. **Option B**: Use Figma (free)
   - Design template previews
   - Export at 2x resolution

3. **Option C**: Screenshot from app
   - Generate videos with templates
   - Take screenshots
   - Crop to 1080x1920

## 🎨 Lottie Animations

### Total Needed: 5-10 JSON files

Download from LottieFiles: https://lottiefiles.com/

### Required Files:
```
assets/lottie/hearts.json          # Animated hearts (for love templates)
assets/lottie/confetti.json        # Confetti celebration
assets/lottie/sparkles.json        # Sparkle effects
assets/lottie/party.json           # Party celebration
assets/lottie/success.json         # Success checkmark/star
```

### Specifications:
- **Format**: JSON (Lottie format)
- **File Size**: < 100KB per file
- **Duration**: 1-3 seconds loop
- **Color**: Match app theme or neutral

### Recommended Free Lottie Files:
1. **Hearts**: Search "heart animation" on LottieFiles
2. **Confetti**: Search "confetti celebration"
3. **Sparkles**: Search "sparkle shine"
4. **Party**: Search "party popper"
5. **Success**: Search "success checkmark"

## 🎭 Stickers

### Total Needed: 50+ PNG files

Create or download sticker packs.

### Specifications:
- **Format**: PNG with transparency
- **Resolution**: 512x512 or 1024x1024
- **File Size**: < 100KB per sticker
- **Background**: Transparent

### Categories Needed:
```
assets/stickers/hearts/          # Heart stickers (10+)
assets/stickers/stars/           # Star stickers (10+)
assets/stickers/arrows/          # Arrow stickers (5+)
assets/stickers/shapes/          # Geometric shapes (10+)
assets/stickers/emojis/          # Emoji-style stickers (15+)
```

### Sources:
- **Flaticon**: https://www.flaticon.com/ (free with attribution)
- **Icons8**: https://icons8.com/
- **Freepik**: https://www.freepik.com/
- **Custom**: Create in Canva or Figma

## 🖼️ Background Images

### Total Needed: 10-20 files

### Specifications:
- **Resolution**: 1080x1920
- **Format**: JPG
- **File Size**: < 1MB each
- **Style**: Abstract, gradients, patterns

### Types Needed:
```
assets/backgrounds/gradient_001.jpg   # Gradient backgrounds (5+)
assets/backgrounds/bokeh_001.jpg      # Bokeh light effects (5+)
assets/backgrounds/abstract_001.jpg   # Abstract patterns (5+)
assets/backgrounds/nature_001.jpg     # Nature scenes (optional)
```

### Sources:
- **Unsplash**: https://unsplash.com/
- **Pexels**: https://www.pexels.com/
- **Pixabay**: https://pixabay.com/

## 🎭 App Icon & Branding

### App Icon
**Required Sizes** (for Android & iOS):

**Android**:
- 192x192 (xxxhdpi)
- 144x144 (xxhdpi)
- 96x96 (xhdpi)
- 72x72 (hdpi)
- 48x48 (mdpi)

**iOS**:
- 1024x1024 (App Store)
- 180x180 (iPhone 3x)
- 120x120 (iPhone 2x)
- 167x167 (iPad Pro)
- 152x152 (iPad 2x)
- 76x76 (iPad)

### Design Guidelines:
- **Colors**: Purple-Pink gradient (#8B5CF6 to #EC4899)
- **Icon**: Video/play button symbol
- **Style**: Modern, flat design
- **Background**: Gradient or solid color

### Tool Recommendations:
- **Icon Kitchen**: https://icon.kitchen/
- **App Icon Generator**: https://appicon.co/
- **Figma**: Design custom icon

## 📱 Splash Screen

### Specifications:
- **Android**: 1080x1920
- **iOS**: 1242x2688 (iPhone 11 Pro Max)
- **Content**: App logo + gradient background
- **Format**: PNG

## 🎬 Tutorial/Onboarding Images (Optional)

If adding tutorial screens:
```
assets/images/onboarding/step1.png
assets/images/onboarding/step2.png
assets/images/onboarding/step3.png
```

### Specifications:
- **Resolution**: 1080x1920
- **Format**: PNG
- **Content**: Screenshots or illustrations

## ⚡ Quick Setup Script

### For macOS/Linux:
```bash
#!/bin/bash

# Create directory structure
mkdir -p assets/images/templates
mkdir -p assets/images/music
mkdir -p assets/music/{romantic,motivational,upbeat,chill,emotional}
mkdir -p assets/backgrounds
mkdir -p assets/stickers/{hearts,stars,arrows,shapes,emojis}
mkdir -p assets/lottie

echo "Asset directories created!"
echo "Now download files according to ASSETS_GUIDE.md"
```

### For Windows (PowerShell):
```powershell
# Create directory structure
New-Item -ItemType Directory -Path "assets\images\templates" -Force
New-Item -ItemType Directory -Path "assets\images\music" -Force
New-Item -ItemType Directory -Path "assets\music\romantic" -Force
New-Item -ItemType Directory -Path "assets\music\motivational" -Force
New-Item -ItemType Directory -Path "assets\music\upbeat" -Force
New-Item -ItemType Directory -Path "assets\music\chill" -Force
New-Item -ItemType Directory -Path "assets\music\emotional" -Force
New-Item -ItemType Directory -Path "assets\backgrounds" -Force
New-Item -ItemType Directory -Path "assets\stickers" -Force
New-Item -ItemType Directory -Path "assets\lottie" -Force

Write-Host "Asset directories created!"
```

## ✅ Checklist

Before launching the app, ensure you have:

- [ ] 25 music tracks (5 per category) in MP3 format
- [ ] 23+ template thumbnails in JPG/PNG format
- [ ] 5+ Lottie animation files in JSON format
- [ ] 50+ sticker images in PNG format with transparency
- [ ] 10+ background images in JPG format
- [ ] App icon in all required sizes
- [ ] Splash screen image
- [ ] All files properly named and organized
- [ ] pubspec.yaml updated with asset paths
- [ ] Attribution/license information documented
- [ ] File sizes optimized (total app < 50MB)

## 📝 License & Attribution

### Important:
- Keep a `LICENSES.txt` file in the assets folder
- Document the source and license for each asset
- Include required attributions in app settings

### Template:
```
Music Tracks:
- romantic_01.mp3: "Song Name" by Artist Name from YouTube Audio Library
- motivational_01.mp3: "Song Name" by Artist Name from Pixabay

Lottie Animations:
- hearts.json: by Animation Artist from LottieFiles (CC0)

Stickers:
- heart_01.png: from Flaticon (Free license with attribution)
```

## 🚀 After Adding Assets

1. **Update pubspec.yaml** to include new asset paths
2. **Run `flutter pub get`** to update asset bundle
3. **Test on device** to ensure all assets load correctly
4. **Check app size** - should be < 50MB total
5. **Optimize if needed** - compress images, reduce bitrates

## 💡 Pro Tips

1. **Use asset compression**:
   - TinyPNG for images: https://tinypng.com/
   - Online MP3 compressor for music

2. **Lazy loading**:
   - Load music files on-demand
   - Cache template thumbnails

3. **CDN option** (Phase 2):
   - Host large files on cloud storage
   - Download on first use
   - Reduces initial app size

4. **Test assets**:
   - Ensure music plays on both Android & iOS
   - Check Lottie animations render correctly
   - Verify image quality on different screen sizes

---

**Total Estimated Asset Size**: 30-45MB (within 50MB Play Store limit)

**Time to Collect All Assets**: 4-8 hours

**Budget if Purchasing**: $0 (all free with proper attribution) to $50 (premium packs)

---

For questions or issues with assets, refer to MUSIC_SOURCES.md or IMPLEMENTATION_NOTES.md.
