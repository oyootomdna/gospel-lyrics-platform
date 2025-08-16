@echo off
echo.
echo 🔍 GOSPEL LYRICS PLATFORM - DEPLOYMENT VERIFICATION
echo ==================================================
echo.

echo 📊 Checking database status...
echo ==============================
wrangler d1 list

echo.
echo 📋 Checking database tables...
echo =============================
wrangler d1 execute gospel-lyrics-db --command="SELECT name FROM sqlite_master WHERE type='table' ORDER BY name;" --env production

echo.
echo 🎵 Checking gospel content...
echo ============================
wrangler d1 execute gospel-lyrics-db --command="SELECT id, title, artist, price_lyrics FROM gospel_content ORDER BY title;" --env production

echo.
echo 👤 Checking user accounts...
echo ============================
wrangler d1 execute gospel-lyrics-db --command="SELECT u.id, u.email, w.balance_ugx FROM users u LEFT JOIN wallets w ON u.id = w.user_id;" --env production

echo.
echo 🚀 Checking Cloudflare Pages deployment...
echo ==========================================
wrangler pages deployment list --project-name gospel-lyrics-platform

echo.
echo ✅ VERIFICATION COMPLETE
echo =======================
echo Your Gospel Lyrics Platform should be ready!
echo.
pause