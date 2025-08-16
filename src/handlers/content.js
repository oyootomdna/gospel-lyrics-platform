// Content management and pricing for Gospel Lyrics Platform
import { WalletService } from '../services/wallet.js';

const PRICES_UGX = {
  LYRICS: 100,
  AUDIO: 70,
  STREAM: 50
};

export async function handleContentRoutes(request, env, ctx) {
  const url = new URL(request.url);
  const path = url.pathname;
  const method = request.method;

  const wallet = new WalletService(env.DB);

  try {
    // Get pricing information
    if (path === '/api/content/prices' && method === 'GET') {
      return jsonResponse({
        ok: true,
        prices: PRICES_UGX,
        currency: 'UGX',
        description: {
          LYRICS: 'Download gospel lyrics',
          AUDIO: 'Download audio file', 
          STREAM: 'Stream audio play'
        }
      });
    }

    // Purchase content
    if (path === '/api/content/purchase' && method === 'POST') {
      const body = await request.json();
      const { type, contentId, userId = 'user-001', idempotencyKey } = body;

      // Validate content type
      if (!PRICES_UGX[type?.toUpperCase()]) {
        return jsonResponse({
          ok: false,
          error: 'Invalid content type',
          validTypes: Object.keys(PRICES_UGX)
        }, 400);
      }

      const amount = PRICES_UGX[type.toUpperCase()];
      
      const result = await wallet.debitWallet({
        userId,
        amountUGX: amount,
        reason: type.toUpperCase(),
        contentId,
        idempotencyKey: idempotencyKey || generateUID()
      });

      if (!result.ok) {
        return jsonResponse({
          ok: false,
          error: result.error,
          balance: await wallet.getBalance(userId),
          required: amount
        }, 402);
      }

      // Generate access token
      const accessToken = btoa(JSON.stringify({
        contentId,
        type: type.toUpperCase(),
        userId,
        granted: Date.now(),
        expires: Date.now() + (5 * 60 * 1000) // 5 minutes
      }));

      return jsonResponse({
        ok: true,
        code: result.already ? 'ALREADY_PURCHASED' : 'DEBITED',
        new_balance: await wallet.getBalance(userId),
        access_token: accessToken,
        expires_in: 300
      });
    }

    // Get user content history
    if (path === '/api/content/history' && method === 'GET') {
      const userId = url.searchParams.get('userId') || 'user-001';
      const history = await wallet.getTransactionHistory(userId);
      
      return jsonResponse({
        ok: true,
        transactions: history
      });
    }

    // Validate access token
    if (path === '/api/content/validate' && method === 'POST') {
      const body = await request.json();
      const { access_token } = body;

      try {
        const tokenData = JSON.parse(atob(access_token));
        const isValid = tokenData.expires > Date.now();
        
        return jsonResponse({
          ok: true,
          valid: isValid,
          data: isValid ? tokenData : null
        });
      } catch (error) {
        return jsonResponse({
          ok: false,
          valid: false,
          error: 'Invalid token'
        });
      }
    }

    return new Response('Not Found', { status: 404 });

  } catch (error) {
    console.error('Content route error:', error);
    return jsonResponse({
      ok: false,
      error: error.message
    }, 500);
  }
}

function generateUID() {
  return Math.random().toString(36).substr(2, 12).toUpperCase();
}

function jsonResponse(data, status = 200) {
  return new Response(JSON.stringify(data), {
    status,
    headers: { 'Content-Type': 'application/json' }
  });
}
