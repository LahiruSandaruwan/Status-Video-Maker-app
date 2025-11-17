# StatusPro Asset Setup Script (PowerShell)
# This script creates placeholder .gitkeep files in all asset directories
# to maintain directory structure in version control

Write-Host "================================" -ForegroundColor Blue
Write-Host "StatusPro Asset Setup" -ForegroundColor Blue
Write-Host "================================" -ForegroundColor Blue
Write-Host ""

# Get script and project directories
$ScriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$ProjectDir = Split-Path -Parent $ScriptDir
$AssetsDir = Join-Path $ProjectDir "assets"

Write-Host "Project directory: " -NoNewline -ForegroundColor Cyan
Write-Host $ProjectDir
Write-Host "Assets directory: " -NoNewline -ForegroundColor Cyan
Write-Host $AssetsDir
Write-Host ""

# Create main asset directories
Write-Host "Creating asset directories..." -ForegroundColor Yellow

$directories = @(
    "music\romantic",
    "music\motivational",
    "music\upbeat",
    "music\chill",
    "music\emotional",
    "images\thumbnails",
    "images\backgrounds",
    "images\stickers",
    "lottie",
    "fonts"
)

foreach ($dir in $directories) {
    $fullPath = Join-Path $AssetsDir $dir
    New-Item -ItemType Directory -Force -Path $fullPath | Out-Null
}

Write-Host "✓ Directories created" -ForegroundColor Green
Write-Host ""

# Create .gitkeep files to preserve directory structure
Write-Host "Creating .gitkeep placeholders..." -ForegroundColor Yellow

$gitkeepDirs = @(
    "music\romantic",
    "music\motivational",
    "music\upbeat",
    "music\chill",
    "music\emotional",
    "images\thumbnails",
    "images\backgrounds",
    "images\stickers",
    "lottie",
    "fonts"
)

foreach ($dir in $gitkeepDirs) {
    $gitkeepPath = Join-Path $AssetsDir "$dir\.gitkeep"
    New-Item -ItemType File -Force -Path $gitkeepPath | Out-Null
}

Write-Host "✓ Placeholders created" -ForegroundColor Green
Write-Host ""

# Create sample README files in each music category
Write-Host "Creating category README files..." -ForegroundColor Yellow

# Romantic
$romanticReadme = @"
# Romantic Music

Place 5 romantic music tracks here:
1. romantic_1.mp3 - Soft Piano Love
2. romantic_2.mp3 - Acoustic Romance
3. romantic_3.mp3 - Dreamy Love
4. romantic_4.mp3 - Wedding Bliss
5. romantic_5.mp3 - Heartfelt Moments

Format: MP3, 128-192 kbps, 30-60 seconds
License: Royalty-free for commercial use
"@
Set-Content -Path (Join-Path $AssetsDir "music\romantic\README.md") -Value $romanticReadme

# Motivational
$motivationalReadme = @"
# Motivational Music

Place 5 motivational music tracks here:
1. motivational_1.mp3 - Rise Up
2. motivational_2.mp3 - Victory March
3. motivational_3.mp3 - Never Give Up
4. motivational_4.mp3 - Epic Journey
5. motivational_5.mp3 - Champion Spirit

Format: MP3, 128-192 kbps, 30-60 seconds
License: Royalty-free for commercial use
"@
Set-Content -Path (Join-Path $AssetsDir "music\motivational\README.md") -Value $motivationalReadme

# Upbeat
$upbeatReadme = @"
# Upbeat Music

Place 5 upbeat/party music tracks here:
1. upbeat_1.mp3 - Party Vibes
2. upbeat_2.mp3 - Dance Floor
3. upbeat_3.mp3 - Summer Fun
4. upbeat_4.mp3 - Feel Good
5. upbeat_5.mp3 - Celebration Time

Format: MP3, 128-192 kbps, 30-60 seconds
License: Royalty-free for commercial use
"@
Set-Content -Path (Join-Path $AssetsDir "music\upbeat\README.md") -Value $upbeatReadme

# Chill
$chillReadme = @"
# Chill Music

Place 5 chill/relaxed music tracks here:
1. chill_1.mp3 - Lo-fi Chill
2. chill_2.mp3 - Calm Vibes
3. chill_3.mp3 - Peaceful Mind
4. chill_4.mp3 - Relaxed Mood
5. chill_5.mp3 - Easy Going

Format: MP3, 128-192 kbps, 30-60 seconds
License: Royalty-free for commercial use
"@
Set-Content -Path (Join-Path $AssetsDir "music\chill\README.md") -Value $chillReadme

# Emotional
$emotionalReadme = @"
# Emotional Music

Place 5 emotional music tracks here:
1. emotional_1.mp3 - Touching Moments
2. emotional_2.mp3 - Deep Feelings
3. emotional_3.mp3 - Sad Piano
4. emotional_4.mp3 - Nostalgic
5. emotional_5.mp3 - Heartbreak

Format: MP3, 128-192 kbps, 30-60 seconds
License: Royalty-free for commercial use
"@
Set-Content -Path (Join-Path $AssetsDir "music\emotional\README.md") -Value $emotionalReadme

Write-Host "✓ Category README files created" -ForegroundColor Green
Write-Host ""

# Display directory structure
Write-Host "Asset directory structure:" -ForegroundColor Yellow
Write-Host ""

function Show-Tree {
    param (
        [string]$Path,
        [string]$Indent = "",
        [int]$Level = 0,
        [int]$MaxLevel = 2
    )

    if ($Level -gt $MaxLevel) { return }

    $items = Get-ChildItem -Path $Path | Sort-Object -Property @{Expression={$_.PSIsContainer}; Descending=$true}, Name

    foreach ($item in $items) {
        $isLast = $item -eq $items[-1]
        $prefix = if ($isLast) { "└── " } else { "├── " }
        $symbol = if ($item.PSIsContainer) { "📁" } else { "📄" }

        Write-Host "$Indent$prefix$symbol $($item.Name)"

        if ($item.PSIsContainer) {
            $newIndent = if ($isLast) { "$Indent    " } else { "$Indent│   " }
            Show-Tree -Path $item.FullName -Indent $newIndent -Level ($Level + 1) -MaxLevel $MaxLevel
        }
    }
}

Show-Tree -Path $AssetsDir

Write-Host ""
Write-Host "================================" -ForegroundColor Green
Write-Host "Setup complete!" -ForegroundColor Green
Write-Host "================================" -ForegroundColor Green
Write-Host ""
Write-Host "Next steps:" -ForegroundColor Cyan
Write-Host "1. Download royalty-free music from sources listed in assets\README.md"
Write-Host "2. Create template thumbnails (360x640 PNG)"
Write-Host "3. Add custom fonts to assets\fonts\"
Write-Host "4. (Optional) Add Lottie animations to assets\lottie\"
Write-Host ""
Write-Host "For detailed asset requirements, see: assets\README.md"
Write-Host ""
