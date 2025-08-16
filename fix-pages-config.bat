@echo off
echo 🔧 Fixing wrangler.toml for Pages deployment...
echo.

echo Creating Pages-compatible wrangler.toml...
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

echo ✅ Configuration updated with pages_build_output_dir!
echo.

echo Now trying deployment with fixed config...
echo.

echo 🚀 Attempting Pages deployment...
wrangler pages deploy src --project-name gospel-lyrics-platform

echo.
if %ERRORLEVEL% EQU 0 (
    echo 🎉 DEPLOYMENT SUCCESSFUL!
    echo Your Gospel Lyrics Platform is now live!
) else (
    echo ⚠️ Deployment failed. Let's try alternative method...
    echo.
    echo Trying with explicit compatibility date...
    wrangler pages deploy src --project-name gospel-lyrics-platform --compatibility-date 2024-01-01
    
    if %ERRORLEVEL% NEQ 0 (
        echo.
        echo Still having issues. The problem is likely the API token permissions.
        echo.
        echo 🔑 To fix the API token:
        echo 1. Go to: https://dash.cloudflare.com/profile/api-tokens
        echo 2. Edit your existing token OR create a new one
        echo 3. Add permission: User:User Details:Read
        echo 4. Make sure you have: Account:Cloudflare Pages:Edit
        echo.
        echo Then retry: wrangler pages deploy src --project-name gospel-lyrics-platform
    )
)

pause