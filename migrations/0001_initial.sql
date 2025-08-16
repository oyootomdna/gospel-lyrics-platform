-- Gospel Lyrics Platform Database Schema
-- SQLite schema for Cloudflare D1

-- Users table
CREATE TABLE IF NOT EXISTS users (
    id TEXT PRIMARY KEY,
    email TEXT,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP
);

-- Wallets table
CREATE TABLE IF NOT EXISTS wallets (
    user_id TEXT PRIMARY KEY,
    balance_ugx INTEGER NOT NULL DEFAULT 0,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id)
);

-- Top-ups table (Pesapal transactions)
CREATE TABLE IF NOT EXISTS topups (
    order_tracking_id TEXT PRIMARY KEY,
    merchant_reference TEXT NOT NULL,
    user_id TEXT NOT NULL,
    amount_ugx INTEGER NOT NULL,
    status TEXT NOT NULL DEFAULT 'PENDING',
    pesapal_status_code INTEGER,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id)
);

-- Ledger entries (all wallet transactions)
CREATE TABLE IF NOT EXISTS ledger_entries (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    user_id TEXT NOT NULL,
    type TEXT NOT NULL CHECK (type IN ('CREDIT', 'DEBIT')),
    amount_ugx INTEGER NOT NULL,
    ref_type TEXT NOT NULL,
    ref_id TEXT NOT NULL,
    description TEXT,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id)
);

-- Purchase debits (content purchases)
CREATE TABLE IF NOT EXISTS purchase_debits (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    user_id TEXT NOT NULL,
    amount_ugx INTEGER NOT NULL,
    reason TEXT NOT NULL,
    content_id TEXT,
    content_type TEXT,
    idempotency_key TEXT UNIQUE,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id)
);

-- IPN logs (webhook notifications)
CREATE TABLE IF NOT EXISTS ipn_logs (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    method TEXT NOT NULL,
    payload TEXT NOT NULL,
    order_tracking_id TEXT,
    processed BOOLEAN DEFAULT FALSE,
    received_at DATETIME DEFAULT CURRENT_TIMESTAMP
);

-- Gospel content metadata
CREATE TABLE IF NOT EXISTS gospel_content (
    id TEXT PRIMARY KEY,
    title TEXT NOT NULL,
    artist TEXT,
    category TEXT DEFAULT 'TRADITIONAL',
    lyrics TEXT,
    audio_url TEXT,
    duration_seconds INTEGER,
    price_lyrics INTEGER DEFAULT 100,
    price_audio INTEGER DEFAULT 70,
    price_stream INTEGER DEFAULT 50,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP
);

-- Indexes for performance
CREATE INDEX IF NOT EXISTS idx_topups_user_id ON topups(user_id);
CREATE INDEX IF NOT EXISTS idx_topups_status ON topups(status);
CREATE INDEX IF NOT EXISTS idx_ledger_user_id ON ledger_entries(user_id);
CREATE INDEX IF NOT EXISTS idx_ledger_created_at ON ledger_entries(created_at);
CREATE INDEX IF NOT EXISTS idx_purchase_debits_user_id ON purchase_debits(user_id);
CREATE INDEX IF NOT EXISTS idx_gospel_content_category ON gospel_content(category);

-- Insert sample gospel content
INSERT OR IGNORE INTO gospel_content (id, title, artist, category, lyrics, price_lyrics, price_audio, price_stream) VALUES
('amazing-grace-001', 'Amazing Grace', 'Traditional', 'HYMNS', 
'Amazing grace, how sweet the sound
That saved a wretch like me
I once was lost, but now am found
Was blind, but now I see', 100, 70, 50),

('how-great-thou-art-001', 'How Great Thou Art', 'Traditional', 'HYMNS',
'O Lord my God, when I in awesome wonder
Consider all the worlds thy hands have made
I see the stars, I hear the rolling thunder
Thy power throughout the universe displayed', 100, 70, 50),

('blessed-assurance-001', 'Blessed Assurance', 'Fanny Crosby', 'HYMNS',
'Blessed assurance, Jesus is mine
O what a foretaste of glory divine
Heir of salvation, purchase of God
Born of His Spirit, washed in His blood', 100, 70, 50);

-- Insert demo user
INSERT OR IGNORE INTO users (id, email) VALUES ('user-001', 'demo@gospellyricsub.com');
INSERT OR IGNORE INTO wallets (user_id, balance_ugx) VALUES ('user-001', 0);
