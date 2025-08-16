# 🚀 Gospel Lyrics Platform - Deployment Instructions

## Prerequisites ✅

Before deploying, ensure you have:

1. **GitHub account** with repository created
2. **Cloudflare account** with domain added
3. **Pesapal business account** with API credentials
4. **Node.js** installed locally (optional, for testing)

## 🔑 Required Credentials

### Cloudflare Credentials

1. **API Token**: Get from [dash.cloudflare.com/profile/api-tokens](https://dash.cloudflare.com/profile/api-tokens)
   - Use "Edit zone DNS" template
   - Select your domain: `gospellyricsub.com`

2. **Zone ID**: Found in domain overview page (right sidebar)

3. **Account ID**: Found in the right sidebar of Cloudflare dashboard

### Pesapal Credentials

1. **Consumer Key**: From [developer.pesapal.com](https://developer.pesapal.com)
   - Business Dashboard → API Settings → Integration Keys

2. **Consumer Secret**: Same location as Consumer Key

3. **Notification ID**: Will be generated after IPN URL registration

## 🛠️ Deployment Steps

### Step 1: Install Wrangler CLI

```bash
npm install -g wrangler
