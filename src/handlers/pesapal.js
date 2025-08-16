// Pesapal payment handler for Gospel Lyrics Platform
import { PesapalClient } from '../services/pesapal-client.js';
import { WalletService } from '../services/wallet.js';

export async function handlePesapalRoutes(request, env, ctx) {
  const url = new URL(request.url);
  const path = url.pathname;
  const method = request.method;

  const pesapal = new PesapalClient(env);
  const wallet = new WalletService(env.DB);

  try {
    // Create top-up
    if (path === '/api/pesapal/topup' && method === 'POST') {
      const body = await request.json();
      const { amountUGX = 2000, email, userId = 'user-001' } = body;

      const merchantRef = generateUID();
      const order = await pesapal.submitTopupOrder({
        id: merchantRef,
        amountUGX,
        email: email || 'user@gospellyricsub.com'
      });

      // Record pending topup
      await wallet.recordPendingTopup({
        orderTrackingId: order.order_tracking_id,
        merchantReference: merchantRef,
        userId,
        amountUGX
      });

      return jsonResponse({
        ok: true,
        merchant_reference: merchantRef,
        order_tracking_id: order.order_tracking_id,
        redirect_url: order.redirect_url,
        amount: amountUGX
      });
    }

    // Payment callback
    if (path === '/pay/callback' && method === 'GET') {
      const orderTrackingId = url.searchParams.get('OrderTrackingId');
      
      if (!orderTrackingId) {
        return new Response('Missing OrderTrackingId', { status: 400 });
      }

      const status = await pesapal.getTransactionStatus(orderTrackingId);
      const finalStatus = mapPesapalStatus(status);
      
      await wallet.settleTopup(orderTrackingId, finalStatus);

      return new Response(`
        <!DOCTYPE html>
        <html>
        <head>
          <title>Payment ${finalStatus}</title>
          <meta name="viewport" content="width=device-width, initial-scale=1">
          <style>
            body { font-family: Arial; text-align: center; padding: 50px; }
            .success { color: green; }
            .failed { color: red; }
          </style>
        </head>
        <body>
          <h2 class="${finalStatus === 'COMPLETED' ? 'success' : 'failed'}">
            Payment ${finalStatus}
          </h2>
          <p>Order ID: ${orderTrackingId}</p>
          <p>You can now close this window.</p>
          <button onclick="window.close()">Close</button>
        </body>
        </html>
      `, {
        headers: { 'Content-Type': 'text/html' }
      });
    }

    // IPN notification
    if (path === '/pay/ipn' && (method === 'GET' || method === 'POST')) {
      const params = method === 'GET' ? 
        Object.fromEntries(url.searchParams.entries()) :
        await request.json();

      const orderTrackingId = params.OrderTrackingId || params.orderTrackingId;
      const merchantRef = params.OrderMerchantReference || params.orderMerchantReference || '';

      if (orderTrackingId) {
        try {
          const status = await pesapal.getTransactionStatus(orderTrackingId);
          const finalStatus = mapPesapalStatus(status);
          await wallet.settleTopup(orderTrackingId, finalStatus);
        } catch (error) {
          console.error('IPN processing error:', error);
        }
      }

      // Always acknowledge IPN
      return jsonResponse({
        orderNotificationType: 'IPNCHANGE',
        orderTrackingId: orderTrackingId || '',
        orderMerchantReference: merchantRef,
        status: 200
      });
    }

    // Get wallet balance
    if (path === '/api/pesapal/wallet/balance' && method === 'GET') {
      const userId = url.searchParams.get('userId') || 'user-001';
      const balance = await wallet.getBalance(userId);
      
      return jsonResponse({
        ok: true,
        user: userId,
        balance_ugx: balance
      });
    }

    return new Response('Not Found', { status: 404 });
    
  } catch (error) {
    console.error('Pesapal route error:', error);
    return jsonResponse({
      ok: false,
      error: error.message
    }, 500);
  }
}

function generateUID() {
  return 'GLH-' + Math.random().toString(36).substr(2, 8).toUpperCase();
}

function mapPesapalStatus(status) {
  const code = Number(status?.status_code ?? status?.payment_status_code);
  switch (code) {
    case 1: return 'COMPLETED';
    case 2: return 'FAILED';
    case 3: return 'REVERSED';
    default: return 'PENDING';
  }
}

function jsonResponse(data, status = 200) {
  return new Response(JSON.stringify(data), {
    status,
    headers: { 'Content-Type': 'application/json' }
  });
}
