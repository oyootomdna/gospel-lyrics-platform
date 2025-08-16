@echo off
echo 🎵 Setting up Gospel Lyrics Database directly...
echo ===============================================

echo Creating users table...
wrangler d1 execute gospel-lyrics-db --command="CREATE TABLE IF NOT EXISTS users (id TEXT PRIMARY KEY, email TEXT, created_at DATETIME DEFAULT CURRENT_TIMESTAMP, updated_at DATETIME DEFAULT CURRENT_TIMESTAMP);" --env production

echo Creating wallets table...
wrangler d1 execute gospel-lyrics-db --command="CREATE TABLE IF NOT EXISTS wallets (user_id TEXT PRIMARY KEY, balance_ugx INTEGER NOT NULL DEFAULT 0, created_at DATETIME DEFAULT CURRENT_TIMESTAMP, updated_at DATETIME DEFAULT CURRENT_TIMESTAMP, FOREIGN KEY (user_id) REFERENCES users(id));" --env production

echo Creating topups table...
wrangler d1 execute gospel-lyrics-db --command="CREATE TABLE IF NOT EXISTS topups (order_tracking_id TEXT PRIMARY KEY, merchant_reference TEXT NOT NULL, user_id TEXT NOT NULL, amount_ugx INTEGER NOT NULL, status TEXT NOT NULL DEFAULT 'PENDING', pesapal_status_code INTEGER, created_at DATETIME DEFAULT CURRENT_TIMESTAMP, updated_at DATETIME DEFAULT CURRENT_TIMESTAMP, FOREIGN KEY (user_id) REFERENCES users(id));" --env production

echo Creating ledger_entries table...
wrangler d1 execute gospel-lyrics-db --command="CREATE TABLE IF NOT EXISTS ledger_entries (id INTEGER PRIMARY KEY AUTOINCREMENT, user_id TEXT NOT NULL, type TEXT NOT NULL CHECK (type IN ('CREDIT', 'DEBIT')), amount_ugx INTEGER NOT NULL, ref_type TEXT NOT NULL, ref_id TEXT NOT NULL, description TEXT, created_at DATETIME DEFAULT CURRENT_TIMESTAMP, FOREIGN KEY (user_id) REFERENCES users(id));" --env production

echo Creating purchase_debits table...
wrangler d1 execute gospel-lyrics-db --command="CREATE TABLE IF NOT EXISTS purchase_debits (id INTEGER PRIMARY KEY AUTOINCREMENT, user_id TEXT NOT NULL, amount_ugx INTEGER NOT NULL, reason TEXT NOT NULL, content_id TEXT, content_type TEXT, idempotency_key TEXT UNIQUE, created_at DATETIME DEFAULT CURRENT_TIMESTAMP, FOREIGN KEY (user_id) REFERENCES users(id));" --env production

echo Creating ipn_logs table...
wrangler d1 execute gospel-lyrics-db --command="CREATE TABLE IF NOT EXISTS ipn_logs (id INTEGER PRIMARY KEY AUTOINCREMENT, method TEXT NOT NULL, payload TEXT NOT NULL, order_tracking_id TEXT, processed BOOLEAN DEFAULT FALSE, received_at DATETIME DEFAULT CURRENT_TIMESTAMP);" --env production

echo Creating gospel_content table...
wrangler d1 execute gospel-lyrics-db --command="CREATE TABLE IF NOT EXISTS gospel_content (id TEXT PRIMARY KEY, title TEXT NOT NULL, artist TEXT, category TEXT DEFAULT 'TRADITIONAL', lyrics TEXT, audio_url TEXT, duration_seconds INTEGER, price_lyrics INTEGER DEFAULT 100, price_audio INTEGER DEFAULT 70, price_stream INTEGER DEFAULT 50, created_at DATETIME DEFAULT CURRENT_TIMESTAMP, updated_at DATETIME DEFAULT CURRENT_TIMESTAMP);" --env production

echo Creating indexes...
wrangler d1 execute gospel-lyrics-db --command="CREATE INDEX IF NOT EXISTS idx_topups_user_id ON topups(user_id);" --env production
wrangler d1 execute gospel-lyrics-db --command="CREATE INDEX IF NOT EXISTS idx_topups_status ON topups(status);" --env production
wrangler d1 execute gospel-lyrics-db --command="CREATE INDEX IF NOT EXISTS idx_ledger_user_id ON ledger_entries(user_id);" --env production
wrangler d1 execute gospel-lyrics-db --command="CREATE INDEX IF NOT EXISTS idx_ledger_created_at ON ledger_entries(created_at);" --env production
wrangler d1 execute gospel-lyrics-db --command="CREATE INDEX IF NOT EXISTS idx_purchase_debits_user_id ON purchase_debits(user_id);" --env production
wrangler d1 execute gospel-lyrics-db --command="CREATE INDEX IF NOT EXISTS idx_gospel_content_category ON gospel_content(category);" --env production

echo Adding sample gospel content...
wrangler d1 execute gospel-lyrics-db --command="INSERT OR IGNORE INTO gospel_content (id, title, artist, category, lyrics, price_lyrics, price_audio, price_stream) VALUES ('amazing-grace-001', 'Amazing Grace', 'Traditional', 'HYMNS', 'Amazing grace, how sweet the sound\nThat saved a wretch like me\nI once was lost, but now am found\nWas blind, but now I see', 100, 70, 50);" --env production

wrangler d1 execute gospel-lyrics-db --command="INSERT OR IGNORE INTO gospel_content (id, title, artist, category, lyrics, price_lyrics, price_audio, price_stream) VALUES ('how-great-thou-art-001', 'How Great Thou Art', 'Traditional', 'HYMNS', 'O Lord my God, when I in awesome wonder\nConsider all the worlds thy hands have made\nI see the stars, I hear the rolling thunder\nThy power throughout the universe displayed', 100, 70, 50);" --env production

wrangler d1 execute gospel-lyrics-db --command="INSERT OR IGNORE INTO gospel_content (id, title, artist, category, lyrics, price_lyrics, price_audio, price_stream) VALUES ('blessed-assurance-001', 'Blessed Assurance', 'Fanny Crosby', 'HYMNS', 'Blessed assurance, Jesus is mine\nO what a foretaste of glory divine\nHeir of salvation, purchase of God\nBorn of His Spirit, washed in His blood', 100, 70, 50);" --env production

echo Adding demo user...
wrangler d1 execute gospel-lyrics-db --command="INSERT OR IGNORE INTO users (id, email) VALUES ('user-001', 'demo@gospellyricsub.com');" --env production
wrangler d1 execute gospel-lyrics-db --command="INSERT OR IGNORE INTO wallets (user_id, balance_ugx) VALUES ('user-001', 0);" --env production

echo.
echo ✅ Database setup complete!
echo.
echo 🔍 Verifying setup...
wrangler d1 execute gospel-lyrics-db --command="SELECT title, artist FROM gospel_content;" --env production

echo.
echo 🚀 Now run deployment:
echo wrangler pages deploy src --project-name gospel-lyrics-platform --compatibility-date 2024-01-01
echo.
pause