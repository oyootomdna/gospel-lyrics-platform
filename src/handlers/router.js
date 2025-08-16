// Request router for Gospel Lyrics Platform
import { handlePesapalRoutes } from './pesapal.js';
import { handleContentRoutes } from './content.js';
import { handleCloudflareRoutes } from './cloudflare.js';
import { handleStaticFiles } from './static.js';

export async function handleRequest(request, env, ctx) {
  const url = new URL(request.url);
  const path = url.pathname;

  // API Routes
  if (path.startsWith('/api/pesapal')) {
    return handlePesapalRoutes(request, env, ctx);
  }
  
  if (path.startsWith('/api/content')) {
    return handleContentRoutes(request, env, ctx);
  }
  
  if (path.startsWith('/api/cf')) {
    return handleCloudflareRoutes(request, env, ctx);
  }

  // Health check
  if (path === '/api/health') {
    return new Response(JSON.stringify({
      ok: true,
      platform: 'Gospel Lyrics Platform',
      domain: env.DOMAIN || 'gospellyricsub.com',
      timestamp: new Date().toISOString()
    }), {
      headers: { 'Content-Type': 'application/json' }
    });
  }

  // Payment callbacks
  if (path === '/pay/callback') {
    return handlePesapalRoutes(request, env, ctx);
  }

  if (path === '/pay/ipn') {
    return handlePesapalRoutes(request, env, ctx);
  }

  // Static files and pages
  return handleStaticFiles(request, env, ctx);
}
