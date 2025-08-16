@echo off
echo 🔧 Fixing wrangler.toml configuration...
echo.

echo Creating correct wrangler.toml with your database ID...
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

echo ✅ wrangler.toml fixed!
echo.
echo Your configuration now includes:
echo - Database ID: 7d29f542-135f-42cf-bc65-626b097b68ed
echo - Production environment settings
echo - Domain: gospellyricsub.com
echo.
echo You can now run: deploy-simple.bat
pause