# StatusPro Assets Directory

This directory contains all media assets required for the StatusPro application.

## Directory Structure

```
assets/
├── music/               # Background music tracks (MP3 format)
│   ├── romantic/        # 5 romantic tracks
│   ├── motivational/    # 5 motivational tracks
│   ├── upbeat/          # 5 upbeat/party tracks
│   ├── chill/          # 5 chill/relaxed tracks
│   └── emotional/      # 5 emotional tracks
├── images/
│   ├── thumbnails/     # Template preview thumbnails (PNG, 360x640)
│   ├── backgrounds/    # Background images for templates
│   └── stickers/       # Decorative stickers and overlays
├── lottie/             # Lottie animation files (JSON)
└── fonts/              # Custom font files (TTF/OTF)
```

## Required Assets

### Music Files (25 total)

All music files should be:
- **Format**: MP3
- **Quality**: 128-192 kbps (balance between quality and file size)
- **Duration**: 30-60 seconds (will be trimmed to video length)
- **License**: Royalty-free or properly licensed

**Romantic Category** (`music/romantic/`):
1. `romantic_1.mp3` - Soft Piano Love
2. `romantic_2.mp3` - Acoustic Romance
3. `romantic_3.mp3` - Dreamy Love
4. `romantic_4.mp3` - Wedding Bliss
5. `romantic_5.mp3` - Heartfelt Moments

**Motivational Category** (`music/motivational/`):
1. `motivational_1.mp3` - Rise Up
2. `motivational_2.mp3` - Victory March
3. `motivational_3.mp3` - Never Give Up
4. `motivational_4.mp3` - Epic Journey
5. `motivational_5.mp3` - Champion Spirit

**Upbeat Category** (`music/upbeat/`):
1. `upbeat_1.mp3` - Party Vibes
2. `upbeat_2.mp3` - Dance Floor
3. `upbeat_3.mp3` - Summer Fun
4. `upbeat_4.mp3` - Feel Good
5. `upbeat_5.mp3` - Celebration Time

**Chill Category** (`music/chill/`):
1. `chill_1.mp3` - Lo-fi Chill
2. `chill_2.mp3` - Calm Vibes
3. `chill_3.mp3` - Peaceful Mind
4. `chill_4.mp3` - Relaxed Mood
5. `chill_5.mp3` - Easy Going

**Emotional Category** (`music/emotional/`):
1. `emotional_1.mp3` - Touching Moments
2. `emotional_2.mp3` - Deep Feelings
3. `emotional_3.mp3` - Sad Piano
4. `emotional_4.mp3` - Nostalgic
5. `emotional_5.mp3` - Heartbreak

### Template Thumbnails

**Format**: PNG with transparency
**Dimensions**: 360x640 pixels (9:16 aspect ratio)
**Location**: `images/thumbnails/`

**Required thumbnails** (23 total):
```
love_quote_1.png
love_quote_2.png
romantic_couple.png
birthday_1.png
birthday_2.png
motivational_1.png
motivational_2.png
success_quote.png
lyrics_style_1.png
lyrics_style_2.png
photo_slideshow_1.png
photo_slideshow_2.png
minimalist_text.png
gradient_waves.png
neon_glow.png
retro_vibes.png
festival_special.png
new_year_2025.png
friendship_day.png
graduation_day.png
travel_memories.png
fashion_reel.png
food_story.png
```

### Lottie Animations (Optional)

**Format**: JSON (Lottie animation files)
**Location**: `lottie/`

Suggested animations:
- `heart_animation.json` - For love templates
- `confetti_burst.json` - For celebration templates
- `sparkle_effect.json` - For special occasions
- `text_reveal.json` - For dramatic text entrances

### Fonts

**Format**: TTF or OTF
**Location**: `fonts/`

Recommended fonts:
- `Poppins-Bold.ttf` - Modern, clean headings
- `Poppins-Regular.ttf` - Body text
- `PlayfairDisplay-Bold.ttf` - Elegant quotes
- `Montserrat-Bold.ttf` - Impact text
- `DancingScript-Regular.ttf` - Script/handwritten style

### Background Images

**Format**: JPG or PNG
**Dimensions**: 1080x1920 pixels (9:16 aspect ratio)
**Location**: `images/backgrounds/`

Suggested backgrounds:
- Solid gradients (can be generated programmatically)
- Bokeh effects
- Abstract patterns
- Textured backgrounds

### Stickers

**Format**: PNG with transparency
**Location**: `images/stickers/`

Suggested stickers:
- Hearts (various styles)
- Stars
- Flowers
- Celebration elements
- Decorative frames
- Text bubbles

## Where to Find Assets

### Royalty-Free Music:
1. **YouTube Audio Library** - https://www.youtube.com/audiolibrary
2. **Pixabay Music** - https://pixabay.com/music/
3. **Incompetech** - https://incompetech.com/
4. **Free Music Archive** - https://freemusicarchive.org/
5. **Bensound** - https://www.bensound.com/ (with attribution)

### Lottie Animations:
1. **LottieFiles** - https://lottiefiles.com/ (free and premium)
2. **Iconscout Lottie** - https://iconscout.com/lottie-animations

### Fonts:
1. **Google Fonts** - https://fonts.google.com/
2. **DaFont** - https://www.dafont.com/ (check licenses)
3. **Font Squirrel** - https://www.fontsquirrel.com/

### Images & Stickers:
1. **Unsplash** - https://unsplash.com/ (high-quality photos)
2. **Pexels** - https://www.pexels.com/
3. **Pixabay** - https://pixabay.com/
4. **Flaticon** - https://www.flaticon.com/ (icons and stickers)

## Setup Scripts

Two setup scripts are provided to create placeholder files:

### For Linux/Mac:
```bash
./scripts/create_assets.sh
```

### For Windows:
```powershell
.\scripts\create_assets.ps1
```

These scripts will create placeholder `.gitkeep` files to maintain directory structure in version control.

## Important Notes

1. **File Sizes**: Keep total asset size reasonable for app distribution
   - Compress images without losing quality
   - Use appropriate audio bitrates (128-192 kbps)
   - Optimize Lottie files (remove unnecessary layers)

2. **Licenses**: Ensure all assets are properly licensed for commercial use
   - Read license terms carefully
   - Keep attribution records if required
   - Consider purchasing premium assets for better quality

3. **Testing**: Test all assets in the app before release
   - Verify audio quality on different devices
   - Check image rendering at various screen sizes
   - Ensure animations play smoothly

4. **Git Large Files**: Consider using Git LFS for large binary assets
   ```bash
   git lfs install
   git lfs track "*.mp3"
   git lfs track "*.png"
   git lfs track "*.jpg"
   ```

## Development vs Production

- **Development**: Use lower quality placeholders to speed up testing
- **Production**: Replace with high-quality, properly licensed assets

## Questions or Issues?

Refer to the main project documentation: `ASSETS_GUIDE.md` in the project root.
