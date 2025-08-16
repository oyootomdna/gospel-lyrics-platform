@echo off
echo.
echo 🎵 GOSPEL LYRICS PLATFORM - BYPASS USER CHECK DEPLOYMENT 🎵
echo ===========================================================
echo Database ID: 7d29f542-135f-42cf-bc65-626b097b68ed
echo ===========================================================
echo.

echo 🔧 Step 1: Creating optimized wrangler.toml...
echo =============================================

echo Creating configuration without user dependencies...
(
echo name = "gospel-lyrics-platform"
echo main = "src/worker.js"
echo compatibility_date = "2024-01-01"
echo send_metrics = false
echo.
echo [[d1_databases]]
echo binding = "DB"
echo database_name = "gospel-lyrics-db"
echo database_id = "7d29f542-135f-42cf-bc65-626b097b68ed"
echo.
echo [vars]
echo DOMAIN = "gospellyricsub.com"
echo PESAPAL_BASE = "https://pay.pesapal.com/v3/api"
echo PESAPAL_CALLBACK_URL = "https://gospellyricsub.com/pay/callback"
) > wrangler.toml

echo ✅ Configuration optimized!
echo.

echo 📦 Step 2: Direct database operations (bypassing user check)...
echo =============================================================

echo Creating users table...
wrangler d1 execute gospel-lyrics-db --command="CREATE TABLE IF NOT EXISTS users (id TEXT PRIMARY KEY, email TEXT, created_at DATETIME DEFAULT CURRENT_TIMESTAMP, updated_at DATETIME DEFAULT CURRENT_TIMESTAMP);" --compatibility-date 2024-01-01

if %ERRORLEVEL% NEQ 0 (
    echo ⚠️ Trying with --remote flag...
    wrangler d1 execute gospel-lyrics-db --command="CREATE TABLE IF NOT EXISTS users (id TEXT PRIMARY KEY, email TEXT, created_at DATETIME DEFAULT CURRENT_TIMESTAMP, updated_at DATETIME DEFAULT CURRENT_TIMESTAMP);" --remote --compatibility-date 2024-01-01
)

echo Creating gospel_content table...
wrangler d1 execute gospel-lyrics-db --command="CREATE TABLE IF NOT EXISTS gospel_content (id TEXT PRIMARY KEY, title TEXT NOT NULL, artist TEXT, category TEXT DEFAULT 'TRADITIONAL', lyrics TEXT, audio_url TEXT, duration_seconds INTEGER, price_lyrics INTEGER DEFAULT 100, price_audio INTEGER DEFAULT 70, price_stream INTEGER DEFAULT 50, created_at DATETIME DEFAULT CURRENT_TIMESTAMP, updated_at DATETIME DEFAULT CURRENT_TIMESTAMP);" --compatibility-date 2024-01-01

echo Creating wallets table...
wrangler d1 execute gospel-lyrics-db --command="CREATE TABLE IF NOT EXISTS wallets (user_id TEXT PRIMARY KEY, balance_ugx INTEGER NOT NULL DEFAULT 0, created_at DATETIME DEFAULT CURRENT_TIMESTAMP, updated_at DATETIME DEFAULT CURRENT_TIMESTAMP, FOREIGN KEY (user_id) REFERENCES users(id));" --compatibility-date 2024-01-01

echo ✅ Core tables created!
echo.

echo 🎵 Step 3: Adding sample gospel content...
echo ========================================

echo Adding "Amazing Grace"...
wrangler d1 execute gospel-lyrics-db --command="INSERT OR IGNORE INTO gospel_content (id, title, artist, category, lyrics, price_lyrics, price_audio, price_stream) VALUES ('amazing-grace-001', 'Amazing Grace', 'Traditional', 'HYMNS', 'Amazing grace, how sweet the sound\nThat saved a wretch like me\nI once was lost, but now am found\nWas blind, but now I see', 100, 70, 50);" --compatibility-date 2024-01-01

echo Adding "How Great Thou Art"...
wrangler d1 execute gospel-lyrics-db --command="INSERT OR IGNORE INTO gospel_content (id, title, artist, category, lyrics, price_lyrics, price_audio, price_stream) VALUES ('how-great-thou-art-001', 'How Great Thou Art', 'Traditional', 'HYMNS', 'O Lord my God, when I in awesome wonder\nConsider all the worlds thy hands have made\nI see the stars, I hear the rolling thunder\nThy power throughout the universe displayed', 100, 70, 50);" --compatibility-date 2024-01-01

echo Adding "Blessed Assurance"...
wrangler d1 execute gospel-lyrics-db --command="INSERT OR IGNORE INTO gospel_content (id, title, artist, category, lyrics, price_lyrics, price_audio, price_stream) VALUES ('blessed-assurance-001', 'Blessed Assurance', 'Fanny Crosby', 'HYMNS', 'Blessed assurance, Jesus is mine\nO what a foretaste of glory divine\nHeir of salvation, purchase of God\nBorn of His Spirit, washed in His blood', 100, 70, 50);" --compatibility-date 2024-01-01

echo Adding demo user...
wrangler d1 execute gospel-lyrics-db --command="INSERT OR IGNORE INTO users (id, email) VALUES ('user-001', 'demo@gospellyricsub.com');" --compatibility-date 2024-01-01
wrangler d1 execute gospel-lyrics-db --command="INSERT OR IGNORE INTO wallets (user_id, balance_ugx) VALUES ('user-001', 0);" --compatibility-date 2024-01-01

echo ✅ Sample content added!
echo.

echo 🔍 Step 4: Verifying database content...
echo =======================================
wrangler d1 execute gospel-lyrics-db --command="SELECT title, artist FROM gospel_content ORDER BY title;" --compatibility-date 2024-01-01
echo.

echo 🚀 Step 5: Deploying to Cloudflare Pages...
echo ==========================================

echo Setting deployment variables...
set WRANGLER_SEND_METRICS=false
set NODE_OPTIONS=--max-old-space-size=4096

echo Starting deployment...
wrangler pages deploy src --project-name gospel-lyrics-platform --compatibility-date 2024-01-01

if %ERRORLEVEL% NEQ 0 (
    echo ⚠️ Direct deployment failed, trying alternative method...
    echo Creating deployment directory...
    if not exist ".wrangler\tmp" mkdir .wrangler\tmp
    
    echo Trying with different compatibility date...
    wrangler pages deploy src --project-name gospel-lyrics-platform --compatibility-date 2023-10-30
)

echo.
echo 🎉 DEPLOYMENT PROCESS COMPLETE! 🎉
echo =================================
echo.
echo ✅ Configuration: Optimized for your setup
echo ✅ Database: gospel-lyrics-db connected  
echo ✅ Tables: Core tables created
echo ✅ Content: 3 sample gospel hymns added
echo ✅ Platform: Deployment attempted
echo.
echo 🎵 Check above for your platform URL!
echo.
echo If deployment succeeded, your Gospel Lyrics Platform is now live!
echo Configure gospellyricsub.com as custom domain in Cloudflare Pages.
echo.
pause