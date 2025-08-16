@echo off
setlocal enabledelayedexpansion

echo.
echo 🎵 GOSPEL LYRICS PLATFORM - COMPLETE DEPLOYMENT 🎵
echo =====================================================
echo Database ID: 7d29f542-135f-42cf-bc65-626b097b68ed
echo Target Domain: gospellyricsub.com
echo =====================================================
echo.

echo 📦 STEP 1: Setting up D1 Database Tables...
echo ============================================

echo Creating users table...
wrangler d1 execute gospel-lyrics-db --command="CREATE TABLE IF NOT EXISTS users (id TEXT PRIMARY KEY, email TEXT, created_at DATETIME DEFAULT CURRENT_TIMESTAMP, updated_at DATETIME DEFAULT CURRENT_TIMESTAMP);" --env production
if %ERRORLEVEL% NEQ 0 (
    echo ❌ Failed to create users table
    goto :error
)

echo Creating wallets table...
wrangler d1 execute gospel-lyrics-db --command="CREATE TABLE IF NOT EXISTS wallets (user_id TEXT PRIMARY KEY, balance_ugx INTEGER NOT NULL DEFAULT 0, created_at DATETIME DEFAULT CURRENT_TIMESTAMP, updated_at DATETIME DEFAULT CURRENT_TIMESTAMP, FOREIGN KEY (user_id) REFERENCES users(id));" --env production
if %ERRORLEVEL% NEQ 0 (
    echo ❌ Failed to create wallets table
    goto :error
)

echo Creating topups table...
wrangler d1 execute gospel-lyrics-db --command="CREATE TABLE IF NOT EXISTS topups (order_tracking_id TEXT PRIMARY KEY, merchant_reference TEXT NOT NULL, user_id TEXT NOT NULL, amount_ugx INTEGER NOT NULL, status TEXT NOT NULL DEFAULT 'PENDING', pesapal_status_code INTEGER, created_at DATETIME DEFAULT CURRENT_TIMESTAMP, updated_at DATETIME DEFAULT CURRENT_TIMESTAMP, FOREIGN KEY (user_id) REFERENCES users(id));" --env production
if %ERRORLEVEL% NEQ 0 (
    echo ❌ Failed to create topups table
    goto :error
)

echo Creating ledger_entries table...
wrangler d1 execute gospel-lyrics-db --command="CREATE TABLE IF NOT EXISTS ledger_entries (id INTEGER PRIMARY KEY AUTOINCREMENT, user_id TEXT NOT NULL, type TEXT NOT NULL CHECK (type IN ('CREDIT', 'DEBIT')), amount_ugx INTEGER NOT NULL, ref_type TEXT NOT NULL, ref_id TEXT NOT NULL, description TEXT, created_at DATETIME DEFAULT CURRENT_TIMESTAMP, FOREIGN KEY (user_id) REFERENCES users(id));" --env production
if %ERRORLEVEL% NEQ 0 (
    echo ❌ Failed to create ledger_entries table
    goto :error
)

echo Creating purchase_debits table...
wrangler d1 execute gospel-lyrics-db --command="CREATE TABLE IF NOT EXISTS purchase_debits (id INTEGER PRIMARY KEY AUTOINCREMENT, user_id TEXT NOT NULL, amount_ugx INTEGER NOT NULL, reason TEXT NOT NULL, content_id TEXT, content_type TEXT, idempotency_key TEXT UNIQUE, created_at DATETIME DEFAULT CURRENT_TIMESTAMP, FOREIGN KEY (user_id) REFERENCES users(id));" --env production
if %ERRORLEVEL% NEQ 0 (
    echo ❌ Failed to create purchase_debits table
    goto :error
)

echo Creating ipn_logs table...
wrangler d1 execute gospel-lyrics-db --command="CREATE TABLE IF NOT EXISTS ipn_logs (id INTEGER PRIMARY KEY AUTOINCREMENT, method TEXT NOT NULL, payload TEXT NOT NULL, order_tracking_id TEXT, processed BOOLEAN DEFAULT FALSE, received_at DATETIME DEFAULT CURRENT_TIMESTAMP);" --env production
if %ERRORLEVEL% NEQ 0 (
    echo ❌ Failed to create ipn_logs table
    goto :error
)

echo Creating gospel_content table...
wrangler d1 execute gospel-lyrics-db --command="CREATE TABLE IF NOT EXISTS gospel_content (id TEXT PRIMARY KEY, title TEXT NOT NULL, artist TEXT, category TEXT DEFAULT 'TRADITIONAL', lyrics TEXT, audio_url TEXT, duration_seconds INTEGER, price_lyrics INTEGER DEFAULT 100, price_audio INTEGER DEFAULT 70, price_stream INTEGER DEFAULT 50, created_at DATETIME DEFAULT CURRENT_TIMESTAMP, updated_at DATETIME DEFAULT CURRENT_TIMESTAMP);" --env production
if %ERRORLEVEL% NEQ 0 (
    echo ❌ Failed to create gospel_content table
    goto :error
)

echo.
echo 🔍 Creating performance indexes...
wrangler d1 execute gospel-lyrics-db --command="CREATE INDEX IF NOT EXISTS idx_topups_user_id ON topups(user_id);" --env production
wrangler d1 execute gospel-lyrics-db --command="CREATE INDEX IF NOT EXISTS idx_topups_status ON topups(status);" --env production
wrangler d1 execute gospel-lyrics-db --command="CREATE INDEX IF NOT EXISTS idx_ledger_user_id ON ledger_entries(user_id);" --env production
wrangler d1 execute gospel-lyrics-db --command="CREATE INDEX IF NOT EXISTS idx_ledger_created_at ON ledger_entries(created_at);" --env production
wrangler d1 execute gospel-lyrics-db --command="CREATE INDEX IF NOT EXISTS idx_purchase_debits_user_id ON purchase_debits(user_id);" --env production
wrangler d1 execute gospel-lyrics-db --command="CREATE INDEX IF NOT EXISTS idx_gospel_content_category ON gospel_content(category);" --env production

echo ✅ All database tables created successfully!
echo.

echo 🎵 STEP 2: Adding Sample Gospel Content...
echo ==========================================

echo Adding "Amazing Grace"...
wrangler d1 execute gospel-lyrics-db --command="INSERT OR IGNORE INTO gospel_content (id, title, artist, category, lyrics, price_lyrics, price_audio, price_stream) VALUES ('amazing-grace-001', 'Amazing Grace', 'Traditional', 'HYMNS', 'Amazing grace, how sweet the sound\nThat saved a wretch like me\nI once was lost, but now am found\nWas blind, but now I see\n\nTwas grace that taught my heart to fear\nAnd grace my fears relieved\nHow precious did that grace appear\nThe hour I first believed', 100, 70, 50);" --env production
if %ERRORLEVEL% NEQ 0 (
    echo ❌ Failed to add Amazing Grace
    goto :error
)

echo Adding "How Great Thou Art"...
wrangler d1 execute gospel-lyrics-db --command="INSERT OR IGNORE INTO gospel_content (id, title, artist, category, lyrics, price_lyrics, price_audio, price_stream) VALUES ('how-great-thou-art-001', 'How Great Thou Art', 'Traditional', 'HYMNS', 'O Lord my God, when I in awesome wonder\nConsider all the worlds thy hands have made\nI see the stars, I hear the rolling thunder\nThy power throughout the universe displayed\n\nThen sings my soul, my Saviour God to Thee\nHow great Thou art, how great Thou art\nThen sings my soul, my Saviour God to Thee\nHow great Thou art, how great Thou art', 100, 70, 50);" --env production
if %ERRORLEVEL% NEQ 0 (
    echo ❌ Failed to add How Great Thou Art
    goto :error
)

echo Adding "Blessed Assurance"...
wrangler d1 execute gospel-lyrics-db --command="INSERT OR IGNORE INTO gospel_content (id, title, artist, category, lyrics, price_lyrics, price_audio, price_stream) VALUES ('blessed-assurance-001', 'Blessed Assurance', 'Fanny Crosby', 'HYMNS', 'Blessed assurance, Jesus is mine\nO what a foretaste of glory divine\nHeir of salvation, purchase of God\nBorn of His Spirit, washed in His blood\n\nThis is my story, this is my song\nPraising my Saviour all the day long\nThis is my story, this is my song\nPraising my Saviour all the day long', 100, 70, 50);" --env production
if %ERRORLEVEL% NEQ 0 (
    echo ❌ Failed to add Blessed Assurance
    goto :error
)

echo Adding "What a Friend We Have in Jesus"...
wrangler d1 execute gospel-lyrics-db --command="INSERT OR IGNORE INTO gospel_content (id, title, artist, category, lyrics, price_lyrics, price_audio, price_stream) VALUES ('what-friend-jesus-001', 'What a Friend We Have in Jesus', 'Joseph M. Scriven', 'HYMNS', 'What a friend we have in Jesus\nAll our sins and griefs to bear\nWhat a privilege to carry\nEverything to God in prayer\n\nO what peace we often forfeit\nO what needless pain we bear\nAll because we do not carry\nEverything to God in prayer', 100, 70, 50);" --env production

echo Adding "It is Well with My Soul"...
wrangler d1 execute gospel-lyrics-db --command="INSERT OR IGNORE INTO gospel_content (id, title, artist, category, lyrics, price_lyrics, price_audio, price_stream) VALUES ('it-is-well-001', 'It is Well with My Soul', 'Horatio Spafford', 'HYMNS', 'When peace like a river attendeth my way\nWhen sorrows like sea billows roll\nWhatever my lot, Thou hast taught me to say\nIt is well, it is well with my soul\n\nIt is well with my soul\nIt is well, it is well with my soul', 100, 70, 50);" --env production

echo.
echo 👤 Adding demo user account...
wrangler d1 execute gospel-lyrics-db --command="INSERT OR IGNORE INTO users (id, email) VALUES ('user-001', 'demo@gospellyricsub.com');" --env production
wrangler d1 execute gospel-lyrics-db --command="INSERT OR IGNORE INTO wallets (user_id, balance_ugx) VALUES ('user-001', 0);" --env production

echo ✅ Sample gospel content added successfully!
echo.

echo 🔍 STEP 3: Verifying Database Setup...
echo ====================================
wrangler d1 execute gospel-lyrics-db --command="SELECT COUNT(*) as table_count FROM sqlite_master WHERE type='table';" --env production
echo.
wrangler d1 execute gospel-lyrics-db --command="SELECT title, artist, category FROM gospel_content ORDER BY title;" --env production
echo.

echo 🚀 STEP 4: Deploying to Cloudflare Pages...
echo ==========================================
wrangler pages deploy src --project-name gospel-lyrics-platform --compatibility-date 2024-01-01
if %ERRORLEVEL% NEQ 0 (
    echo ❌ Deployment failed!
    goto :error
)

echo.
echo 🎉 DEPLOYMENT COMPLETE! 🎉
echo =========================
echo.
echo ✅ Database: gospel-lyrics-db (7d29f542-135f-42cf-bc65-626b097b68ed)
echo ✅ Tables: 7 core tables created with indexes
echo ✅ Content: 5 sample gospel hymns added
echo ✅ User: Demo user account created
echo ✅ Platform: Deployed to Cloudflare Pages
echo.
echo 🌐 NEXT STEPS:
echo 1. Check the deployment URL above
echo 2. Configure gospellyricsub.com as custom domain in Cloudflare Pages
echo 3. Test the platform functionality
echo 4. Add more gospel content as needed
echo 5. Set up Pesapal payment integration (optional)
echo.
echo 🎵 Your Gospel Lyrics Platform is now LIVE! 🎵
echo.
goto :end

:error
echo.
echo ❌ DEPLOYMENT FAILED!
echo Please check the error messages above and try again.
echo Make sure you have:
echo - Cloudflare API token set
echo - Correct database permissions
echo - Stable internet connection
echo.

:end
pause