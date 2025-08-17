@echo off
echo 🎵 GOSPEL LYRICS PLATFORM - FINAL DEPLOYMENT 🎵
echo ===============================================
echo.

echo 🔧 Step 1: Creating clean wrangler.toml...
(
echo name = "gospel-lyrics-platform"
echo main = "src/worker.js"
echo compatibility_date = "2024-01-01"
echo send_metrics = false
echo pages_build_output_dir = "src"
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

echo ✅ Clean configuration created!
echo.

echo 📦 Step 2: Adding sample gospel content...
wrangler d1 execute gospel-lyrics-db --command="INSERT OR IGNORE INTO gospel_content (id, title, artist, category, lyrics, price_lyrics, price_audio, price_stream) VALUES ('amazing-grace-001', 'Amazing Grace', 'Traditional', 'HYMNS', 'Amazing grace, how sweet the sound\nThat saved a wretch like me\nI once was lost, but now am found\nWas blind, but now I see', 100, 70, 50);"

wrangler d1 execute gospel-lyrics-db --command="INSERT OR IGNORE INTO gospel_content (id, title, artist, category, lyrics, price_lyrics, price_audio, price_stream) VALUES ('how-great-thou-art-001', 'How Great Thou Art', 'Traditional', 'HYMNS', 'O Lord my God, when I in awesome wonder\nConsider all the worlds thy hands have made\nI see the stars, I hear the rolling thunder\nThy power throughout the universe displayed', 100, 70, 50);"

echo ✅ Sample content added!
echo.

echo 🔍 Step 3: Verifying content...
wrangler d1 execute gospel-lyrics-db --command="SELECT title, artist FROM gospel_content;"
echo.

echo 🚀 Step 4: Deploying to Cloudflare Pages...
wrangler pages deploy src --project-name gospel-lyrics-platform

echo.
echo 🎉 DEPLOYMENT COMPLETE!
echo Your Gospel Lyrics Platform should now be live!
echo.
pause