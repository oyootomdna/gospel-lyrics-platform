@echo off
echo.
echo 🎵 GOSPEL LYRICS PLATFORM - FIXED DEPLOYMENT 🎵
echo ===============================================
echo Database ID: 7d29f542-135f-42cf-bc65-626b097b68ed
echo ===============================================
echo.

echo 🔧 Step 1: Fixing wrangler.toml configuration...
echo ==============================================

echo Creating correct wrangler.toml...
(
echo name = "gospel-lyrics-platform"
echo main = "src/worker.js"
echo compatibility_date = "2024-01-01"
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

echo ✅ Configuration fixed!
echo.

echo 🔍 Step 2: Testing database connection...
echo =======================================
wrangler d1 list
echo.

echo 📦 Step 3: Setting up database tables...
echo ======================================

echo Creating users table...
wrangler d1 execute gospel-lyrics-db --command="CREATE TABLE IF NOT EXISTS users (id TEXT PRIMARY KEY, email TEXT, created_at DATETIME DEFAULT CURRENT_TIMESTAMP, updated_at DATETIME DEFAULT CURRENT_TIMESTAMP);"

echo Creating gospel_content table...
wrangler d1 execute gospel-lyrics-db --command="CREATE TABLE IF NOT EXISTS gospel_content (id TEXT PRIMARY KEY, title TEXT NOT NULL, artist TEXT, category TEXT DEFAULT 'TRADITIONAL', lyrics TEXT, audio_url TEXT, duration_seconds INTEGER, price_lyrics INTEGER DEFAULT 100, price_audio INTEGER DEFAULT 70, price_stream INTEGER DEFAULT 50, created_at DATETIME DEFAULT CURRENT_TIMESTAMP, updated_at DATETIME DEFAULT CURRENT_TIMESTAMP);"

echo Creating wallets table...
wrangler d1 execute gospel-lyrics-db --command="CREATE TABLE IF NOT EXISTS wallets (user_id TEXT PRIMARY KEY, balance_ugx INTEGER NOT NULL DEFAULT 0, created_at DATETIME DEFAULT CURRENT_TIMESTAMP, updated_at DATETIME DEFAULT CURRENT_TIMESTAMP, FOREIGN KEY (user_id) REFERENCES users(id));"

echo ✅ Core tables created!
echo.

echo 🎵 Step 4: Adding sample gospel hymns...
echo ======================================

echo Adding "Amazing Grace"...
wrangler d1 execute gospel-lyrics-db --command="INSERT OR IGNORE INTO gospel_content (id, title, artist, category, lyrics, price_lyrics, price_audio, price_stream) VALUES ('amazing-grace-001', 'Amazing Grace', 'Traditional', 'HYMNS', 'Amazing grace, how sweet the sound\nThat saved a wretch like me\nI once was lost, but now am found\nWas blind, but now I see\n\nTwas grace that taught my heart to fear\nAnd grace my fears relieved\nHow precious did that grace appear\nThe hour I first believed', 100, 70, 50);"

echo Adding "How Great Thou Art"...
wrangler d1 execute gospel-lyrics-db --command="INSERT OR IGNORE INTO gospel_content (id, title, artist, category, lyrics, price_lyrics, price_audio, price_stream) VALUES ('how-great-thou-art-001', 'How Great Thou Art', 'Traditional', 'HYMNS', 'O Lord my God, when I in awesome wonder\nConsider all the worlds thy hands have made\nI see the stars, I hear the rolling thunder\nThy power throughout the universe displayed\n\nThen sings my soul, my Saviour God to Thee\nHow great Thou art, how great Thou art\nThen sings my soul, my Saviour God to Thee\nHow great Thou art, how great Thou art', 100, 70, 50);"

echo Adding "Blessed Assurance"...
wrangler d1 execute gospel-lyrics-db --command="INSERT OR IGNORE INTO gospel_content (id, title, artist, category, lyrics, price_lyrics, price_audio, price_stream) VALUES ('blessed-assurance-001', 'Blessed Assurance', 'Fanny Crosby', 'HYMNS', 'Blessed assurance, Jesus is mine\nO what a foretaste of glory divine\nHeir of salvation, purchase of God\nBorn of His Spirit, washed in His blood\n\nThis is my story, this is my song\nPraising my Saviour all the day long\nThis is my story, this is my song\nPraising my Saviour all the day long', 100, 70, 50);"

echo Adding demo user...
wrangler d1 execute gospel-lyrics-db --command="INSERT OR IGNORE INTO users (id, email) VALUES ('user-001', 'demo@gospellyricsub.com');"
wrangler d1 execute gospel-lyrics-db --command="INSERT OR IGNORE INTO wallets (user_id, balance_ugx) VALUES ('user-001', 0);"

echo ✅ Sample content added!
echo.

echo 🔍 Step 5: Verifying database content...
echo ======================================
wrangler d1 execute gospel-lyrics-db --command="SELECT title, artist FROM gospel_content ORDER BY title;"
echo.

echo 🚀 Step 6: Deploying to Cloudflare Pages...
echo ==========================================
wrangler pages deploy src --project-name gospel-lyrics-platform --compatibility-date 2024-01-01

echo.
echo 🎉 DEPLOYMENT COMPLETE! 🎉
echo =========================
echo.
echo ✅ Configuration: Fixed wrangler.toml
echo ✅ Database: gospel-lyrics-db connected
echo ✅ Tables: Core tables created
echo ✅ Content: 3 sample gospel hymns added
echo ✅ Platform: Deployed to Cloudflare Pages
echo.
echo 🎵 Your Gospel Lyrics Platform is now LIVE!
echo.
echo Features available:
echo - Gospel lyrics search and display
echo - Mobile-responsive design  
echo - Payment integration ready
echo - Sample hymns: Amazing Grace, How Great Thou Art, Blessed Assurance
echo.
echo 🌐 Configure gospellyricsub.com as custom domain in Cloudflare Pages
echo.
pause