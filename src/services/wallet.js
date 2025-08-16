// Wallet and ledger service for Gospel Lyrics Platform
export class WalletService {
  constructor(db) {
    this.db = db;
  }

  // Ensure user exists
  async ensureUser(userId) {
    const existing = await this.db.prepare(
      'SELECT 1 FROM users WHERE id = ?'
    ).bind(userId).first();

    if (!existing) {
      await this.db.batch([
        this.db.prepare('INSERT INTO users (id) VALUES (?)').bind(userId),
        this.db.prepare('INSERT INTO wallets (user_id, balance_ugx) VALUES (?, 0)').bind(userId)
      ]);
    }
  }

  // Record pending top-up
  async recordPendingTopup({ orderTrackingId, merchantReference, userId, amountUGX }) {
    await this.ensureUser(userId);

    const existing = await this.db.prepare(
      'SELECT 1 FROM topups WHERE order_tracking_id = ?'
    ).bind(orderTrackingId).first();

    if (!existing) {
      await this.db.prepare(`
        INSERT INTO topups (order_tracking_id, merchant_reference, user_id, amount_ugx, status)
        VALUES (?, ?, ?, ?, 'PENDING')
      `).bind(orderTrackingId, merchantReference, userId, amountUGX).run();
    }
  }

  // Settle top-up (complete or fail)
  async settleTopup(orderTrackingId, finalStatus) {
    const topup = await this.db.prepare(
      'SELECT * FROM topups WHERE order_tracking_id = ?'
    ).bind(orderTrackingId).first();

    if (!topup) {
      return { changed: false, reason: 'not_found' };
    }

    if (topup.status === finalStatus) {
      return { changed: false, reason: 'no_change' };
    }

    if (finalStatus === 'COMPLETED' && topup.status !== 'COMPLETED') {
      // Credit wallet and create ledger entry
      await this.db.batch([
        this.db.prepare(`
          UPDATE topups SET status = ?, updated_at = CURRENT_TIMESTAMP 
          WHERE order_tracking_id = ?
        `).bind(finalStatus, orderTrackingId),
        
        this.db.prepare(`
          UPDATE wallets SET balance_ugx = balance_ugx + ? 
          WHERE user_id = ?
        `).bind(topup.amount_ugx, topup.user_id),
        
        this.db.prepare(`
          INSERT INTO ledger_entries (user_id, type, amount_ugx, ref_type, ref_id)
          VALUES (?, 'CREDIT', ?, 'TOPUP', ?)
        `).bind(topup.user_id, topup.amount_ugx, orderTrackingId)
      ]);
    } else {
      // Just update status
      await this.db.prepare(`
        UPDATE topups SET status = ?, updated_at = CURRENT_TIMESTAMP 
        WHERE order_tracking_id = ?
      `).bind(finalStatus, orderTrackingId).run();
    }

    return { changed: true, finalStatus };
  }

  // Get wallet balance
  async getBalance(userId) {
    const wallet = await this.db.prepare(
      'SELECT balance_ugx FROM wallets WHERE user_id = ?'
    ).bind(userId).first();

    return wallet ? wallet.balance_ugx : 0;
  }

  // Debit wallet for content purchase
  async debitWallet({ userId, amountUGX, reason, contentId, idempotencyKey }) {
    await this.ensureUser(userId);

    // Check for duplicate transaction
    if (idempotencyKey) {
      const existing = await this.db.prepare(
        'SELECT 1 FROM purchase_debits WHERE idempotency_key = ?'
      ).bind(idempotencyKey).first();

      if (existing) {
        return { ok: true, already: true };
      }
    }

    // Check balance
    const wallet = await this.db.prepare(
      'SELECT balance_ugx FROM wallets WHERE user_id = ?'
    ).bind(userId).first();

    const currentBalance = wallet ? wallet.balance_ugx : 0;
    if (currentBalance < amountUGX) {
      return { 
        ok: false, 
        error: 'INSUFFICIENT_FUNDS', 
        have: currentBalance, 
        needed: amountUGX 
      };
    }

    // Process debit
    await this.db.batch([
      this.db.prepare(`
        UPDATE wallets SET balance_ugx = balance_ugx - ? 
        WHERE user_id = ?
      `).bind(amountUGX, userId),
      
      this.db.prepare(`
        INSERT INTO ledger_entries (user_id, type, amount_ugx, ref_type, ref_id)
        VALUES (?, 'DEBIT', ?, ?, ?)
      `).bind(userId, amountUGX, reason, contentId || ''),
      
      this.db.prepare(`
        INSERT INTO purchase_debits (user_id, amount_ugx, reason, content_id, idempotency_key)
        VALUES (?, ?, ?, ?, ?)
      `).bind(userId, amountUGX, reason, contentId, idempotencyKey)
    ]);

    return { ok: true, charged: true };
  }

  // Get transaction history
  async getTransactionHistory(userId, limit = 50) {
    return await this.db.prepare(`
      SELECT * FROM ledger_entries 
      WHERE user_id = ? 
      ORDER BY created_at DESC 
      LIMIT ?
    `).bind(userId, limit).all();
  }
}
