#!/bin/bash

# Gospel Lyrics Platform Deployment Setup Script
# Run this script after setting up your environment variables

echo "🎵 Gospel Lyrics Platform - Deployment Setup"
echo "============================================="
echo

# Check if environment variables are set
if [ -z "$CLOUDFLARE_API_TOKEN" ]; then
    echo "❌ CLOUDFLARE_API_TOKEN not set"
    echo "Please set: export CLOUDFLARE_API_TOKEN=your_token_here"
    exit 1
fi

if [ -z "$CF_ACCOUNT_ID" ]; then
    echo "❌ CF_ACCOUNT_ID not set"
    echo "Please set: export CF_ACCOUNT_ID=your_account_id_here"
    exit 1
fi

echo "✅ Environment variables configured"
echo

# Step 1: Create D1 Database
echo "📦 Creating D1 Database..."
DB_OUTPUT=$(wrangler d1 create gospel-lyrics-db)
echo "$DB_OUTPUT"

# Extract database ID from output
DATABASE_ID=$(echo "$DB_OUTPUT" | grep -o 'database_id = "[^"]*"' | cut -d'"' -f2)

if [ -z "$DATABASE_ID" ]; then
    echo "❌ Failed to extract database ID from wrangler output"
    echo "Please check the wrangler output above and manually update wrangler.toml"
    exit 1
fi

echo "✅ Database created with ID: $DATABASE_ID"
echo

# Step 2: Update wrangler.toml with actual database ID
echo "📝 Updating wrangler.toml with database ID..."
sed -i "s/replace-with-actual-db-id/$DATABASE_ID/g" wrangler.toml
echo "✅ wrangler.toml updated"
echo

# Step 3: Run database migrations
echo "🔄 Running database migrations..."
wrangler d1 execute gospel-lyrics-db --file=migrations/0001_initial.sql
echo "✅ Database migrations completed"
echo

# Step 4: Set up secrets
echo "🔐 Setting up Cloudflare Workers secrets..."
if [ ! -z "$PESAPAL_CONSUMER_KEY" ]; then
    echo "$PESAPAL_CONSUMER_KEY" | wrangler secret put PESAPAL_CONSUMER_KEY
fi

if [ ! -z "$PESAPAL_CONSUMER_SECRET" ]; then
    echo "$PESAPAL_CONSUMER_SECRET" | wrangler secret put PESAPAL_CONSUMER_SECRET
fi

if [ ! -z "$PESAPAL_NOTIFICATION_ID" ]; then
    echo "$PESAPAL_NOTIFICATION_ID" | wrangler secret put PESAPAL_NOTIFICATION_ID
fi

echo "✅ Secrets configured"
echo

# Step 5: Deploy to Cloudflare Pages
echo "🚀 Deploying to Cloudflare Pages..."
wrangler pages deploy src --project-name gospel-lyrics-platform --compatibility-date 2024-01-01

echo
echo "🎉 Deployment Complete!"
echo "Your Gospel Lyrics Platform should be live at: https://gospellyricsub.com"
echo
echo "📋 Next Steps:"
echo "1. Configure your custom domain (gospellyricsub.com) in Cloudflare Pages"
echo "2. Test the platform functionality"
echo "3. Add your gospel lyrics content"
echo "4. Configure Pesapal payment integration"
echo
