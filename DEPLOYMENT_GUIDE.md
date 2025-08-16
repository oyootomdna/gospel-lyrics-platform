# 🎵 Gospel Lyrics Platform - Complete Deployment Guide

## 🔑 **STEP 1: Get Your Cloudflare Credentials**

### A. Get Cloudflare API Token
1. Visit: https://developers.cloudflare.com/fundamentals/api/get-started/create-token/
2. Click **"Create Token"**
3. Choose **"Edit zone DNS"** template OR create custom with permissions:
   - `Zone:Zone Settings:Edit`
   - `Zone:Zone:Edit`
   - `Account:Cloudflare Pages:Edit`
   - `Account:D1:Edit`
4. **Copy the token** - you'll only see it once!

### B. Get Account & Zone IDs
1. Go to your Cloudflare dashboard
2. **Account ID**: Right sidebar on any page
3. **Zone ID**: Go to your domain → Overview tab

## 🚀 **STEP 2: Set Environment Variables**

```bash
# Set these in your terminal
export CLOUDFLARE_API_TOKEN="your_actual_token_here"
export CF_ACCOUNT_ID="your_account_id_here"
export CF_ZONE_ID="your_zone_id_here"

# Optional: Pesapal credentials (for payments)
export PESAPAL_CONSUMER_KEY="your_pesapal_key"
export PESAPAL_CONSUMER_SECRET="your_pesapal_secret"
export PESAPAL_NOTIFICATION_ID="your_notification_id"
```

## 📦 **STEP 3: Run Automated Setup**

```bash
# Run the automated setup script
./setup-deployment.sh
```

**OR follow manual steps below:**

## 🛠️ **STEP 4: Manual Setup (Alternative)**

### A. Create D1 Database
```bash
wrangler d1 create gospel-lyrics-db
```
**Copy the `database_id` from the output!**

### B. Update Configuration
```bash
# Replace the database ID in wrangler.toml
sed -i 's/replace-with-actual-db-id/YOUR_ACTUAL_DATABASE_ID/g' wrangler.toml
```

### C. Run Database Migrations
```bash
wrangler d1 execute gospel-lyrics-db --file=migrations/001_initial_schema.sql
```

### D. Set Secrets (Optional - for payments)
```bash
echo "your_pesapal_key" | wrangler secret put PESAPAL_CONSUMER_KEY
echo "your_pesapal_secret" | wrangler secret put PESAPAL_CONSUMER_SECRET
echo "your_notification_id" | wrangler secret put PESAPAL_NOTIFICATION_ID
```

### E. Deploy to Cloudflare Pages
```bash
wrangler pages deploy src --project-name gospel-lyrics-platform --compatibility-date 2024-01-01
```

## 🌐 **STEP 5: Configure Custom Domain**

1. Go to Cloudflare Pages dashboard
2. Find your `gospel-lyrics-platform` project
3. Go to **Custom domains**
4. Add `gospellyricsub.com`
5. Follow DNS configuration instructions

## ✅ **STEP 6: Test Your Platform**

1. Visit: `https://gospellyricsub.com`
2. Test the gospel lyrics search
3. Test audio playback
4. Test payment flow (if configured)

## 🎵 **STEP 7: Add Content**

Your platform supports:
- **Gospel lyrics** with search functionality
- **Audio streaming** with payment integration
- **Mobile-responsive** design
- **Pesapal payments** (UGX pricing)

## 🆘 **Troubleshooting**

### Database Issues
```bash
# Check database status
wrangler d1 list

# View database schema
wrangler d1 execute gospel-lyrics-db --command="PRAGMA table_info(songs);"
```

### Deployment Issues
```bash
# Check deployment logs
wrangler pages deployment list

# View function logs
wrangler tail gospel-lyrics-platform
```

### Domain Issues
- Ensure DNS is properly configured
- Check SSL certificate status
- Verify domain ownership

## 📞 **Support**

- Cloudflare documentation: https://developers.cloudflare.com/
- Pesapal integration: https://developer.pesapal.com/
- Project repository: https://github.com/oyootomdna/gospel-lyrics-platform

---

**🎉 Your Gospel Lyrics Platform will be live at `gospellyricsub.com` after completion!**