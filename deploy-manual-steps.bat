@echo off
echo.
echo 🎵 GOSPEL LYRICS PLATFORM - MANUAL DEPLOYMENT STEPS 🎵
echo =====================================================
echo.
echo This script will guide you through manual deployment
echo to bypass user permission issues.
echo.

echo 📋 STEP 1: Database Setup Commands
echo ==================================
echo Copy and run these commands ONE BY ONE:
echo.

echo 1. Create users table:
echo wrangler d1 execute gospel-lyrics-db --command="CREATE TABLE IF NOT EXISTS users (id TEXT PRIMARY KEY, email TEXT);"
echo.

echo 2. Create gospel_content table:
echo wrangler d1 execute gospel-lyrics-db --command="CREATE TABLE IF NOT EXISTS gospel_content (id TEXT PRIMARY KEY, title TEXT NOT NULL, artist TEXT, lyrics TEXT, price_lyrics INTEGER DEFAULT 100);"
echo.

echo 3. Add Amazing Grace:
echo wrangler d1 execute gospel-lyrics-db --command="INSERT OR IGNORE INTO gospel_content VALUES ('grace-1', 'Amazing Grace', 'Traditional', 'Amazing grace, how sweet the sound\nThat saved a wretch like me', 100);"
echo.

echo 4. Add How Great Thou Art:
echo wrangler d1 execute gospel-lyrics-db --command="INSERT OR IGNORE INTO gospel_content VALUES ('great-1', 'How Great Thou Art', 'Traditional', 'O Lord my God, when I in awesome wonder', 100);"
echo.

echo 5. Add demo user:
echo wrangler d1 execute gospel-lyrics-db --command="INSERT OR IGNORE INTO users VALUES ('user-1', 'demo@gospellyricsub.com');"
echo.

echo 📋 STEP 2: Verify Database
echo ==========================
echo 6. Check content:
echo wrangler d1 execute gospel-lyrics-db --command="SELECT title FROM gospel_content;"
echo.

echo 📋 STEP 3: Deploy Platform
echo ==========================
echo 7. Deploy to Pages:
echo wrangler pages deploy src --project-name gospel-lyrics-platform
echo.

echo 🎯 Run these commands one by one in your terminal.
echo Each command should complete successfully before moving to the next.
echo.
echo ⚠️ If any command fails, let me know which one and the error message.
echo.
pause