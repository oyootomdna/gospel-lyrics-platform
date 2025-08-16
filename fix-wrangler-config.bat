@echo off
echo 🔧 Creating correct wrangler.toml configuration...
echo.

echo Backing up existing wrangler.toml...
if exist wrangler.toml (
    copy wrangler.toml wrangler.toml.backup
    echo ✅ Backup created: wrangler.toml.backup
)

echo.
echo Creating new wrangler.toml with proper D1 configuration...
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

echo ✅ New wrangler.toml created!
echo.
echo Configuration includes:
echo - Database binding for both default and production environments
echo - Database ID: 7d29f542-135f-42cf-bc65-626b097b68ed
echo - Database name: gospel-lyrics-db
echo.
echo Now testing database connection...
wrangler d1 list
echo.
echo If you see your database in the list above, run:
echo deploy-simple.bat
echo.
pause