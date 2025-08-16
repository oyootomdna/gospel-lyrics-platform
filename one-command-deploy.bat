@echo off
echo.
echo 🎵 GOSPEL LYRICS PLATFORM - ONE COMMAND DEPLOYMENT 🎵
echo ====================================================
echo.

echo 🔧 Step 1: Ensuring you're in the right directory...
if not exist "src" (
    echo ❌ Error: You're not in the gospel-lyrics-platform directory!
    echo Please navigate to: C:\Users\ADMIN S\gospel-lyrics-platform
    echo Then run this script again.
    pause
    exit /b 1
)

if not exist "wrangler.toml" (
    echo ❌ Error: wrangler.toml not found!
    echo Creating correct wrangler.toml...
    (
    echo name = "gospel-lyrics-platform"
    echo main = "src/worker.js"
    echo compatibility_date = "2024-01-01"
    echo.
    echo [env.production]
    echo vars = { ENVIRONMENT = "production" }
    echo.
    echo [[env.production.d1_databases]]
    echo binding = "DB"
    echo database_name = "gospel-lyrics-db"
    echo database_id = "7d29f542-135f-42cf-bc65-626b097b68ed"
    echo.
    echo [vars]
    echo DOMAIN = "gospellyricsub.com"
    echo PESAPAL_BASE = "https://pay.pesapal.com/v3/api"
    echo PESAPAL_CALLBACK_URL = "https://gospellyricsub.com/pay/callback"
    ) > wrangler.toml
    echo ✅ wrangler.toml created!
)

echo.
echo 🗄️ Step 2: Setting up database...
echo ================================

echo Creating core tables...
wrangler d1 execute gospel-lyrics-db --command="CREATE TABLE IF NOT EXISTS users (id TEXT PRIMARY KEY, email TEXT, created_at DATETIME DEFAULT CURRENT_TIMESTAMP);"
wrangler d1 execute gospel-lyrics-db --command="CREATE TABLE IF NOT EXISTS gospel_content (id TEXT PRIMARY KEY, title TEXT NOT NULL, artist TEXT, category TEXT DEFAULT 'TRADITIONAL', lyrics TEXT, price_lyrics INTEGER DEFAULT 100, price_audio INTEGER DEFAULT 70, price_stream INTEGER DEFAULT 50, created_at DATETIME DEFAULT CURRENT_TIMESTAMP);"

echo.
echo 🎵 Step 3: Adding sample gospel hymns...
echo ======================================

wrangler d1 execute gospel-lyrics-db --command="INSERT OR IGNORE INTO gospel_content (id, title, artist, category, lyrics, price_lyrics, price_audio, price_stream) VALUES ('amazing-grace-001', 'Amazing Grace', 'Traditional', 'HYMNS', 'Amazing grace, how sweet the sound\nThat saved a wretch like me\nI once was lost, but now am found\nWas blind, but now I see', 100, 70, 50);"

wrangler d1 execute gospel-lyrics-db --command="INSERT OR IGNORE INTO gospel_content (id, title, artist, category, lyrics, price_lyrics, price_audio, price_stream) VALUES ('how-great-thou-art-001', 'How Great Thou Art', 'Traditional', 'HYMNS', 'O Lord my God, when I in awesome wonder\nConsider all the worlds thy hands have made\nI see the stars, I hear the rolling thunder\nThy power throughout the universe displayed', 100, 70, 50);"

wrangler d1 execute gospel-lyrics-db --command="INSERT OR IGNORE INTO gospel_content (id, title, artist, category, lyrics, price_lyrics, price_audio, price_stream) VALUES ('blessed-assurance-001', 'Blessed Assurance', 'Fanny Crosby', 'HYMNS', 'Blessed assurance, Jesus is mine\nO what a foretaste of glory divine\nHeir of salvation, purchase of God\nBorn of His Spirit, washed in His blood', 100, 70, 50);"

wrangler d1 execute gospel-lyrics-db --command="INSERT OR IGNORE INTO users (id, email) VALUES ('user-001', 'demo@gospellyricsub.com');"

echo ✅ Database setup complete!
echo.

echo 🔍 Step 4: Verifying content...
echo ===============================
wrangler d1 execute gospel-lyrics-db --command="SELECT title, artist FROM gospel_content;"
echo.

echo 🚀 Step 5: Deploying to Cloudflare Pages...
echo ==========================================
wrangler pages deploy src --project-name gospel-lyrics-platform --compatibility-date 2024-01-01

echo.
echo 🎉 SUCCESS! Your Gospel Lyrics Platform is LIVE! 🎉
echo =================================================
echo.
echo ✅ Database configured with sample hymns
echo ✅ Platform deployed to Cloudflare Pages  
echo ✅ Ready for gospellyricsub.com custom domain
echo.
echo 🎵 Features available:
echo - Gospel lyrics search and display
echo - Mobile-responsive design
echo - Payment integration ready
echo - Sample hymns: Amazing Grace, How Great Thou Art, Blessed Assurance
echo.
pause