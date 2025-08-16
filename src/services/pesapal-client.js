// Pesapal API v3 Client for Gospel Lyrics Platform
export class PesapalClient {
  constructor(env) {
    this.baseUrl = env.PESAPAL_BASE || 'https://pay.pesapal.com/v3/api';
    this.consumerKey = env.PESAPAL_CONSUMER_KEY;
    this.consumerSecret = env.PESAPAL_CONSUMER_SECRET;
    this.callbackUrl = env.PESAPAL_CALLBACK_URL || 'https://gospellyricsub.com/pay/callback';
    this.notificationId = env.PESAPAL_NOTIFICATION_ID;
  }

  // Get authentication token
  async authenticate() {
    const response = await fetch(`${this.baseUrl}/Auth/RequestToken`, {
      method: 'POST',
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json'
      },
      body: JSON.stringify({
        consumer_key: this.consumerKey,
        consumer_secret: this.consumerSecret
      })
    });

    const data = await response.json();
    if (!response.ok) {
      throw new Error(`Pesapal auth failed: ${data?.message || 'Unknown error'}`);
    }

    return data.token;
  }

  // Submit order request for wallet top-up
  async submitTopupOrder({ id, amountUGX, email }) {
    const token = await this.authenticate();

    const orderData = {
      id,
      currency: 'UGX',
      amount: amountUGX,
      description: `Gospel Lyrics Platform - Wallet Top-up`,
      callback_url: this.callbackUrl,
      notification_id: this.notificationId,
      billing_address: {
        email_address: email,
        country_code: 'UG'
      }
    };

    const response = await fetch(`${this.baseUrl}/Transactions/SubmitOrderRequest`, {
      method: 'POST',
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        'Authorization': `Bearer ${token}`
      },
      body: JSON.stringify(orderData)
    });

    const data = await response.json();
    if (!response.ok) {
      throw new Error(`Order submission failed: ${data?.message || 'Unknown error'}`);
    }

    return data;
  }

  // Get transaction status
  async getTransactionStatus(orderTrackingId) {
    const token = await this.authenticate();

    const url = `${this.baseUrl}/Transactions/GetTransactionStatus?orderTrackingId=${encodeURIComponent(orderTrackingId)}`;

    const response = await fetch(url, {
      method: 'GET',
      headers: {
        'Accept': 'application/json',
        'Authorization': `Bearer ${token}`
      }
    });

    const data = await response.json();
    if (!response.ok) {
      throw new Error(`Status check failed: ${data?.message || 'Unknown error'}`);
    }

    return data;
  }
}
