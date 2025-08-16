// Main Cloudflare Worker - Gospel Lyrics Platform
import { handleRequest } from './handlers/router.js';
import { corsHeaders } from './utils/cors.js';

export default {
  async fetch(request, env, ctx) {
    try {
      // Handle CORS preflight
      if (request.method === 'OPTIONS') {
        return new Response(null, { headers: corsHeaders });
      }

      const response = await handleRequest(request, env, ctx);
      
      // Add CORS headers to all responses
      Object.entries(corsHeaders).forEach(([key, value]) => {
        response.headers.set(key, value);
      });

      return response;
    } catch (error) {
      console.error('Worker error:', error);
      return new Response(JSON.stringify({ 
        ok: false, 
        error: 'Internal server error',
        message: error.message 
      }), {
        status: 500,
        headers: { 'Content-Type': 'application/json', ...corsHeaders }
      });
    }
  }
};
