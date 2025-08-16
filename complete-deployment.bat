@echo off
echo 🎵 Gospel Lyrics Platform - Final Deployment
echo Database ID: 7d29f542-135f-42cf-bc65-626b097b68ed
echo =============================================
echo.

echo 📦 Running database migrations...
wrangler d1 execute gospel-lyrics-db --file=migrations/0001_initial.sql --env production
if %ERRORLEVEL% NEQ 0 (
    echo ❌ Database migration failed!
    pause
    exit /b 1
)
echo ✅ Database schema created with sample gospel songs!
echo.

echo 🔍 Verifying database setup...
echo Checking sample content...
wrangler d1 execute gospel-lyrics-db --command="SELECT title, artist FROM gospel_content LIMIT 3;" --env production
echo.

echo 🚀 Deploying to Cloudflare Pages...
wrangler pages deploy src --project-name gospel-lyrics-platform --compatibility-date 2024-01-01
if %ERRORLEVEL% NEQ 0 (
    echo ❌ Deployment failed!
    pause
    exit /b 1
)
echo.

echo 🔐 Optional: Set up Pesapal secrets
echo If you have Pesapal credentials, run these commands:
echo   echo your_consumer_key ^| wrangler secret put PESAPAL_CONSUMER_KEY
echo   echo your_consumer_secret ^| wrangler secret put PESAPAL_CONSUMER_SECRET
echo   echo your_notification_id ^| wrangler secret put PESAPAL_NOTIFICATION_ID
echo.

echo 🎉 Deployment Complete!
echo.
echo 📋 Your Gospel Lyrics Platform is now live!
echo 🌐 Pages URL: Check output above for deployment URL
echo 🎯 Custom Domain: Configure gospellyricsub.com in Cloudflare Pages
echo.
echo ✅ Features Available:
echo   - Gospel lyrics search and display
echo   - Audio streaming (add audio files as needed)
echo   - Mobile-responsive design
echo   - Payment integration (configure Pesapal)
echo   - Sample hymns: Amazing Grace, How Great Thou Art, Blessed Assurance
echo.
echo 🔗 Next Steps:
echo 1. Test your platform at the deployed URL
echo 2. Add more gospel content to the database
echo 3. Configure custom domain (gospellyricsub.com)
echo 4. Set up Pesapal payment integration
echo.
pause