# 📦 Database Setup Commands

Your database ID: `7d29f542-135f-42cf-bc65-626b097b68ed`

## Run Database Migration

```bash
# Create all tables and add sample gospel songs
wrangler d1 execute gospel-lyrics-db --file=migrations/0001_initial.sql --env production
```

## Verify Database Setup

```bash
# Check that tables were created
wrangler d1 execute gospel-lyrics-db --command="SELECT name FROM sqlite_master WHERE type='table';" --env production

# Check sample gospel content
wrangler d1 execute gospel-lyrics-db --command="SELECT title, artist, category FROM gospel_content;" --env production
```

## Deploy to Cloudflare Pages

```bash
# Deploy your platform
wrangler pages deploy src --project-name gospel-lyrics-platform --compatibility-date 2024-01-01
```

## Add Pesapal Secrets (Optional)

```bash
# Only if you have Pesapal credentials
echo "your_consumer_key" | wrangler secret put PESAPAL_CONSUMER_KEY
echo "your_consumer_secret" | wrangler secret put PESAPAL_CONSUMER_SECRET  
echo "your_notification_id" | wrangler secret put PESAPAL_NOTIFICATION_ID
```

## Sample Gospel Content Included

Your database will have these sample hymns:
- **Amazing Grace** - Traditional
- **How Great Thou Art** - Traditional  
- **Blessed Assurance** - Fanny Crosby

Each song has full lyrics and is set up for:
- Lyrics viewing (100 UGX)
- Audio streaming (70 UGX) 
- Stream access (50 UGX)