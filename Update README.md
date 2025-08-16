# Gospel Lyrics Platform

A full-stack gospel music platform with Pesapal payment integration, built on Cloudflare Pages + Workers.

## Features

- 🎵 Gospel lyrics and audio streaming
- 💰 Pesapal payment integration
- 👛 Digital wallet system
- 📱 Mobile-responsive design
- 🔧 Admin dashboard
- 📊 Analytics and reconciliation

## Tech Stack

- **Frontend**: HTML, CSS, JavaScript
- **Backend**: Cloudflare Workers
- **Database**: Cloudflare D1 (SQLite)
- **Payments**: Pesapal API v3
- **Hosting**: Cloudflare Pages
- **Domain**: gospellyricsub.com

## Quick Deploy

1. Clone this repository
2. Install Wrangler CLI: `npm install -g wrangler`
3. Set up environment variables
4. Deploy: `wrangler deploy`

## Environment Variables

```env
PESAPAL_CONSUMER_KEY=your_key_here
PESAPAL_CONSUMER_SECRET=your_secret_here
CLOUDFLARE_API_TOKEN=your_token_here
DOMAIN=gospellyricsub.com
