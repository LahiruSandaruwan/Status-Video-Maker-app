#!/bin/bash

# StatusPro Asset Setup Script
# This script creates placeholder .gitkeep files in all asset directories
# to maintain directory structure in version control

set -e

echo "================================"
echo "StatusPro Asset Setup"
echo "================================"
echo ""

# Colors for output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Base directory
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
PROJECT_DIR="$(dirname "$SCRIPT_DIR")"
ASSETS_DIR="$PROJECT_DIR/assets"

echo -e "${BLUE}Project directory:${NC} $PROJECT_DIR"
echo -e "${BLUE}Assets directory:${NC} $ASSETS_DIR"
echo ""

# Create main asset directories
echo -e "${YELLOW}Creating asset directories...${NC}"

mkdir -p "$ASSETS_DIR/music/romantic"
mkdir -p "$ASSETS_DIR/music/motivational"
mkdir -p "$ASSETS_DIR/music/upbeat"
mkdir -p "$ASSETS_DIR/music/chill"
mkdir -p "$ASSETS_DIR/music/emotional"
mkdir -p "$ASSETS_DIR/images/thumbnails"
mkdir -p "$ASSETS_DIR/images/backgrounds"
mkdir -p "$ASSETS_DIR/images/stickers"
mkdir -p "$ASSETS_DIR/lottie"
mkdir -p "$ASSETS_DIR/fonts"

echo -e "${GREEN}✓${NC} Directories created"
echo ""

# Create .gitkeep files to preserve directory structure
echo -e "${YELLOW}Creating .gitkeep placeholders...${NC}"

touch "$ASSETS_DIR/music/romantic/.gitkeep"
touch "$ASSETS_DIR/music/motivational/.gitkeep"
touch "$ASSETS_DIR/music/upbeat/.gitkeep"
touch "$ASSETS_DIR/music/chill/.gitkeep"
touch "$ASSETS_DIR/music/emotional/.gitkeep"
touch "$ASSETS_DIR/images/thumbnails/.gitkeep"
touch "$ASSETS_DIR/images/backgrounds/.gitkeep"
touch "$ASSETS_DIR/images/stickers/.gitkeep"
touch "$ASSETS_DIR/lottie/.gitkeep"
touch "$ASSETS_DIR/fonts/.gitkeep"

echo -e "${GREEN}✓${NC} Placeholders created"
echo ""

# Create sample README files in each music category
echo -e "${YELLOW}Creating category README files...${NC}"

# Romantic
cat > "$ASSETS_DIR/music/romantic/README.md" << 'EOF'
# Romantic Music

Place 5 romantic music tracks here:
1. romantic_1.mp3 - Soft Piano Love
2. romantic_2.mp3 - Acoustic Romance
3. romantic_3.mp3 - Dreamy Love
4. romantic_4.mp3 - Wedding Bliss
5. romantic_5.mp3 - Heartfelt Moments

Format: MP3, 128-192 kbps, 30-60 seconds
License: Royalty-free for commercial use
EOF

# Motivational
cat > "$ASSETS_DIR/music/motivational/README.md" << 'EOF'
# Motivational Music

Place 5 motivational music tracks here:
1. motivational_1.mp3 - Rise Up
2. motivational_2.mp3 - Victory March
3. motivational_3.mp3 - Never Give Up
4. motivational_4.mp3 - Epic Journey
5. motivational_5.mp3 - Champion Spirit

Format: MP3, 128-192 kbps, 30-60 seconds
License: Royalty-free for commercial use
EOF

# Upbeat
cat > "$ASSETS_DIR/music/upbeat/README.md" << 'EOF'
# Upbeat Music

Place 5 upbeat/party music tracks here:
1. upbeat_1.mp3 - Party Vibes
2. upbeat_2.mp3 - Dance Floor
3. upbeat_3.mp3 - Summer Fun
4. upbeat_4.mp3 - Feel Good
5. upbeat_5.mp3 - Celebration Time

Format: MP3, 128-192 kbps, 30-60 seconds
License: Royalty-free for commercial use
EOF

# Chill
cat > "$ASSETS_DIR/music/chill/README.md" << 'EOF'
# Chill Music

Place 5 chill/relaxed music tracks here:
1. chill_1.mp3 - Lo-fi Chill
2. chill_2.mp3 - Calm Vibes
3. chill_3.mp3 - Peaceful Mind
4. chill_4.mp3 - Relaxed Mood
5. chill_5.mp3 - Easy Going

Format: MP3, 128-192 kbps, 30-60 seconds
License: Royalty-free for commercial use
EOF

# Emotional
cat > "$ASSETS_DIR/music/emotional/README.md" << 'EOF'
# Emotional Music

Place 5 emotional music tracks here:
1. emotional_1.mp3 - Touching Moments
2. emotional_2.mp3 - Deep Feelings
3. emotional_3.mp3 - Sad Piano
4. emotional_4.mp3 - Nostalgic
5. emotional_5.mp3 - Heartbreak

Format: MP3, 128-192 kbps, 30-60 seconds
License: Royalty-free for commercial use
EOF

echo -e "${GREEN}✓${NC} Category README files created"
echo ""

# Display directory tree
echo -e "${YELLOW}Asset directory structure:${NC}"
echo ""

if command -v tree &> /dev/null; then
    tree "$ASSETS_DIR" -L 2 -a
else
    find "$ASSETS_DIR" -type d | sort | sed 's|[^/]*/| |g'
fi

echo ""
echo -e "${GREEN}================================${NC}"
echo -e "${GREEN}Setup complete!${NC}"
echo -e "${GREEN}================================${NC}"
echo ""
echo -e "${BLUE}Next steps:${NC}"
echo "1. Download royalty-free music from sources listed in assets/README.md"
echo "2. Create template thumbnails (360x640 PNG)"
echo "3. Add custom fonts to assets/fonts/"
echo "4. (Optional) Add Lottie animations to assets/lottie/"
echo ""
echo "For detailed asset requirements, see: assets/README.md"
echo ""
