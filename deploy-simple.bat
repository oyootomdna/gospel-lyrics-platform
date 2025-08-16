@echo off
echo.
echo 🎵 GOSPEL LYRICS PLATFORM - SIMPLE DEPLOYMENT 🎵
echo ================================================
echo Database ID: 7d29f542-135f-42cf-bc65-626b097b68ed
echo ================================================
echo.

echo 📦 Step 1: Creating database tables...
echo ======================================

echo Creating users table...
wrangler d1 execute gospel-lyrics-db --command="CREATE TABLE IF NOT EXISTS users (id TEXT PRIMARY KEY, email TEXT, created_at DATETIME DEFAULT CURRENT_TIMESTAMP, updated_at DATETIME DEFAULT CURRENT_TIMESTAMP);"

echo Creating wallets table...
wrangler d1 execute gospel-lyrics-db --command="CREATE TABLE IF NOT EXISTS wallets (user_id TEXT PRIMARY KEY, balance_ugx INTEGER NOT NULL DEFAULT 0, created_at DATETIME DEFAULT CURRENT_TIMESTAMP, updated_at DATETIME DEFAULT CURRENT_TIMESTAMP, FOREIGN KEY (user_id) REFERENCES users(id));"

echo Creating topups table...
wrangler d1 execute gospel-lyrics-db --command="CREATE TABLE IF NOT EXISTS topups (order_tracking_id TEXT PRIMARY KEY, merchant_reference TEXT NOT NULL, user_id TEXT NOT NULL, amount_ugx INTEGER NOT NULL, status TEXT NOT NULL DEFAULT 'PENDING', pesapal_status_code INTEGER, created_at DATETIME DEFAULT CURRENT_TIMESTAMP, updated_at DATETIME DEFAULT CURRENT_TIMESTAMP, FOREIGN KEY (user_id) REFERENCES users(id));"

echo Creating ledger_entries table...
wrangler d1 execute gospel-lyrics-db --command="CREATE TABLE IF NOT EXISTS ledger_entries (id INTEGER PRIMARY KEY AUTOINCREMENT, user_id TEXT NOT NULL, type TEXT NOT NULL CHECK (type IN ('CREDIT', 'DEBIT')), amount_ugx INTEGER NOT NULL, ref_type TEXT NOT NULL, ref_id TEXT NOT NULL, description TEXT, created_at DATETIME DEFAULT CURRENT_TIMESTAMP, FOREIGN KEY (user_id) REFERENCES users(id));"

echo Creating purchase_debits table...
wrangler d1 execute gospel-lyrics-db --command="CREATE TABLE IF NOT EXISTS purchase_debits (id INTEGER PRIMARY KEY AUTOINCREMENT, user_id TEXT NOT NULL, amount_ugx INTEGER NOT NULL, reason TEXT NOT NULL, content_id TEXT, content_type TEXT, idempotency_key TEXT UNIQUE, created_at DATETIME DEFAULT CURRENT_TIMESTAMP, FOREIGN KEY (user_id) REFERENCES users(id));"

echo Creating ipn_logs table...
wrangler d1 execute gospel-lyrics-db --command="CREATE TABLE IF NOT EXISTS ipn_logs (id INTEGER PRIMARY KEY AUTOINCREMENT, method TEXT NOT NULL, payload TEXT NOT NULL, order_tracking_id TEXT, processed BOOLEAN DEFAULT FALSE, received_at DATETIME DEFAULT CURRENT_TIMESTAMP);"

echo Creating gospel_content table...
wrangler d1 execute gospel-lyrics-db --command="CREATE TABLE IF NOT EXISTS gospel_content (id TEXT PRIMARY KEY, title TEXT NOT NULL, artist TEXT, category TEXT DEFAULT 'TRADITIONAL', lyrics TEXT, audio_url TEXT, duration_seconds INTEGER, price_lyrics INTEGER DEFAULT 100, price_audio INTEGER DEFAULT 70, price_stream INTEGER DEFAULT 50, created_at DATETIME DEFAULT CURRENT_TIMESTAMP, updated_at DATETIME DEFAULT CURRENT_TIMESTAMP);"

echo ✅ Database tables created!
echo.

echo 🎵 Step 2: Adding sample gospel content...
echo =========================================

echo Adding "Amazing Grace"...
wrangler d1 execute gospel-lyrics-db --command="INSERT OR IGNORE INTO gospel_content (id, title, artist, category, lyrics, price_lyrics, price_audio, price_stream) VALUES ('amazing-grace-001', 'Amazing Grace', 'Traditional', 'HYMNS', 'Amazing grace, how sweet the sound\nThat saved a wretch like me\nI once was lost, but now am found\nWas blind, but now I see\n\nTwas grace that taught my heart to fear\nAnd grace my fears relieved\nHow precious did that grace appear\nThe hour I first believed', 100, 70, 50);"

echo Adding "How Great Thou Art"...
wrangler d1 execute gospel-lyrics-db --command="INSERT OR IGNORE INTO gospel_content (id, title, artist, category, lyrics, price_lyrics, price_audio, price_stream) VALUES ('how-great-thou-art-001', 'How Great Thou Art', 'Traditional', 'HYMNS', 'O Lord my God, when I in awesome wonder\nConsider all the worlds thy hands have made\nI see the stars, I hear the rolling thunder\nThy power throughout the universe displayed\n\nThen sings my soul, my Saviour God to Thee\nHow great Thou art, how great Thou art\nThen sings my soul, my Saviour God to Thee\nHow great Thou art, how great Thou art', 100, 70, 50);"

echo Adding "Blessed Assurance"...
wrangler d1 execute gospel-lyrics-db --command="INSERT OR IGNORE INTO gospel_content (id, title, artist, category, lyrics, price_lyrics, price_audio, price_stream) VALUES ('blessed-assurance-001', 'Blessed Assurance', 'Fanny Crosby', 'HYMNS', 'Blessed assurance, Jesus is mine\nO what a foretaste of glory divine\nHeir of salvation, purchase of God\nBorn of His Spirit, washed in His blood\n\nThis is my story, this is my song\nPraising my Saviour all the day long\nThis is my story, this is my song\nPraising my Saviour all the day long', 100, 70, 50);"

echo Adding "What a Friend We Have in Jesus"...
wrangler d1 execute gospel-lyrics-db --command="INSERT OR IGNORE INTO gospel_content (id, title, artist, category, lyrics, price_lyrics, price_audio, price_stream) VALUES ('what-friend-jesus-001', 'What a Friend We Have in Jesus', 'Joseph M. Scriven', 'HYMNS', 'What a friend we have in Jesus\nAll our sins and griefs to bear\nWhat a privilege to carry\nEverything to God in prayer\n\nO what peace we often forfeit\nO what needless pain we bear\nAll because we do not carry\nEverything to God in prayer', 100, 70, 50);"

echo Adding "It is Well with My Soul"...
wrangler d1 execute gospel-lyrics-db --command="INSERT OR IGNORE INTO gospel_content (id, title, artist, category, lyrics, price_lyrics, price_audio, price_stream) VALUES ('it-is-well-001', 'It is Well with My Soul', 'Horatio Spafford', 'HYMNS', 'When peace like a river attendeth my way\nWhen sorrows like sea billows roll\nWhatever my lot, Thou hast taught me to say\nIt is well, it is well with my soul\n\nIt is well with my soul\nIt is well, it is well with my soul', 100, 70, 50);"

echo Adding demo user...
wrangler d1 execute gospel-lyrics-db --command="INSERT OR IGNORE INTO users (id, email) VALUES ('user-001', 'demo@gospellyricsub.com');"
wrangler d1 execute gospel-lyrics-db --command="INSERT OR IGNORE INTO wallets (user_id, balance_ugx) VALUES ('user-001', 0);"

echo ✅ Sample gospel content added!
echo.

echo 🔍 Step 3: Verifying database setup...
echo ====================================
wrangler d1 execute gospel-lyrics-db --command="SELECT title, artist FROM gospel_content ORDER BY title;"
echo.

echo 🚀 Step 4: Deploying to Cloudflare Pages...
echo ===========================================
wrangler pages deploy src --project-name gospel-lyrics-platform --compatibility-date 2024-01-01

echo.
echo 🎉 DEPLOYMENT COMPLETE! 🎉
echo =========================
echo.
echo ✅ Database: gospel-lyrics-db configured
echo ✅ Tables: All core tables created
echo ✅ Content: 5 sample gospel hymns added
echo ✅ User: Demo account created
echo ✅ Platform: Deployed to Cloudflare Pages
echo.
echo 🎵 Your Gospel Lyrics Platform is now LIVE!
echo.
echo 📋 Next Steps:
echo 1. Check the deployment URL above
echo 2. Configure gospellyricsub.com as custom domain
echo 3. Test the platform features
echo 4. Add more gospel content
echo.
pause