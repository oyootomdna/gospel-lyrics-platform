@echo off
echo 🔧 MANUAL FIX - Adding Missing Permission
echo ========================================
echo.
echo ❌ PROBLEM: Your API token is missing Cloudflare Pages permission
echo.
echo 🔑 TO FIX THIS RIGHT NOW:
echo.
echo 1. Open this URL: https://dash.cloudflare.com/profile/api-tokens
echo 2. Find your token: HrlhtgLvrrZyA51NS1QZgqJIe9IQIl3e2oKTxlbR
echo 3. Click "Edit" button
echo 4. Click "Add more" under Permissions
echo 5. Select: Account
echo 6. Select: Cloudflare Pages  
echo 7. Select: Edit
echo 8. Click "Continue to summary"
echo 9. Click "Update token"
echo.
echo ⏳ After adding the permission, press any key to test deployment...
pause

echo.
echo 🧪 Testing Pages permission...
wrangler pages project list

if %ERRORLEVEL% EQU 0 (
    echo ✅ Pages permission working!
    echo.
    echo 🚀 Deploying your platform...
    wrangler pages deploy src --project-name gospel-lyrics-platform
    
    if %ERRORLEVEL% EQU 0 (
        echo.
        echo 🎉 SUCCESS! YOUR GOSPEL LYRICS PLATFORM IS LIVE! 🎉
        echo =================================================
        echo.
        echo Your platform is now deployed and ready!
        echo Configure gospellyricsub.com as custom domain in Cloudflare Pages.
    ) else (
        echo ❌ Deployment failed - check output above for details
    )
) else (
    echo ❌ Pages permission still missing
    echo Please make sure you added: Account ^> Cloudflare Pages ^> Edit
    echo Then run this script again
)

pause