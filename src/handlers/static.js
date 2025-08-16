// Static file handler for Gospel Lyrics Platform
const STATIC_FILES = {
  '/': 'index.html',
  '/index.html': 'index.html',
  '/dashboard': 'dashboard.html',
  '/payments': 'payments.html',
  '/consume': 'consume.html',
  '/recon': 'recon.html',
  '/styles.css': 'styles.css',
  '/app.js': 'app.js'
};

export async function handleStaticFiles(request, env, ctx) {
  const url = new URL(request.url);
  const path = url.pathname;

  // Check if it's a static file request
  const fileName = STATIC_FILES[path];
  if (!fileName) {
    return new Response('Not Found', { status: 404 });
  }

  // Get content based on file type
  let content, contentType;

  switch (fileName) {
    case 'index.html':
      content = getIndexHTML();
      contentType = 'text/html';
      break;
    case 'dashboard.html':
      content = getDashboardHTML();
      contentType = 'text/html';
      break;
    case 'payments.html':
      content = getPaymentsHTML();
      contentType = 'text/html';
      break;
    case 'consume.html':
      content = getConsumeHTML();
      contentType = 'text/html';
      break;
    case 'recon.html':
      content = getReconHTML();
      contentType = 'text/html';
      break;
    case 'styles.css':
      content = getStylesCSS();
      contentType = 'text/css';
      break;
    case 'app.js':
      content = getAppJS();
      contentType = 'application/javascript';
      break;
    default:
      return new Response('Not Found', { status: 404 });
  }

  return new Response(content, {
    headers: {
      'Content-Type': contentType,
      'Cache-Control': 'public, max-age=3600'
    }
  });
}

function getIndexHTML() {
  return `<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Gospel Lyrics Platform - Worship Through Music</title>
    <link rel="stylesheet" href="/styles.css">
</head>
<body>
    <header class="topbar">
        <div class="brand">
            <h1>🎵 Gospel Lyrics Platform</h1>
        </div>
        <div class="user-info">
            <span id="balance">UGX 0</span>
            <div class="avatar">👤</div>
        </div>
    </header>

    <main class="hero">
        <div class="hero-content">
            <h2>Worship Through Music</h2>
            <p>Access thousands of gospel lyrics, audio streams, and worship resources</p>
            <div class="cta-buttons">
                <a href="/dashboard" class="btn primary">Enter Dashboard</a>
                <a href="/payments" class="btn secondary">Top Up Wallet</a>
            </div>
        </div>
    </main>

    <section class="features">
        <div class="container">
            <div class="feature-grid">
                <div class="feature-card">
                    <div class="feature-icon">📖</div>
                    <h3>Gospel Lyrics</h3>
                    <p>Access thousands of traditional and contemporary gospel lyrics</p>
                    <span class="price">100 UGX</span>
                </div>
                <div class="feature-card">
                    <div class="feature-icon">🎵</div>
                    <h3>Audio Downloads</h3>
                    <p>High-quality audio files for offline worship and practice</p>
                    <span class="price">70 UGX</span>
                </div>
                <div class="feature-card">
                    <div class="feature-icon">📱</div>
                    <h3>Stream & Play</h3>
                    <p>Instant streaming for worship services and personal devotion</p>
                    <span class="price">50 UGX</span>
                </div>
            </div>
        </div>
    </section>

    <script src="/app.js"></script>
</body>
</html>`;
}

function getStylesCSS() {
  return `/* Gospel Lyrics Platform Styles */
:root {
    --primary: #4f46e5;
    --secondary: #059669;
    --accent: #f59e0b;
    --bg: #0f172a;
    --card: #1e293b;
    --text: #f8fafc;
    --text-muted: #94a3b8;
    --border: #334155;
    --success: #10b981;
    --error: #ef4444;
}

* {
    margin: 0;
    padding: 0;
    box-sizing: border-box;
}

body {
    font-family: 'Inter', -apple-system, BlinkMacSystemFont, sans-serif;
    background: var(--bg);
    color: var(--text);
    line-height: 1.6;
}

.topbar {
    display: flex;
    justify-content: space-between;
    align-items: center;
    padding: 1rem 2rem;
    background: var(--card);
    border-bottom: 1px solid var(--border);
}

.brand h1 {
    color: var(--primary);
    font-size: 1.5rem;
}

.user-info {
    display: flex;
    align-items: center;
    gap: 1rem;
}

#balance {
    background: var(--primary);
    color: white;
    padding: 0.5rem 1rem;
    border-radius: 2rem;
    font-weight: 600;
}

.avatar {
    width: 40px;
    height: 40px;
    background: var(--secondary);
    border-radius: 50%;
    display: flex;
    align-items: center;
    justify-content: center;
    font-size: 1.2rem;
}

.hero {
    height: 60vh;
    background: linear-gradient(135deg, var(--primary) 0%, var(--secondary) 100%);
    display: flex;
    align-items: center;
    justify-content: center;
    text-align: center;
}

.hero-content h2 {
    font-size: 3rem;
    margin-bottom: 1rem;
    color: white;
}

.hero-content p {
    font-size: 1.2rem;
    margin-bottom: 2rem;
    color: rgba(255, 255, 255, 0.9);
}

.cta-buttons {
    display: flex;
    gap: 1rem;
    justify-content: center;
}

.btn {
    padding: 0.75rem 1.5rem;
    border-radius: 0.5rem;
    text-decoration: none;
    font-weight: 600;
    transition: all 0.2s;
    border: none;
    cursor: pointer;
}

.btn.primary {
    background: white;
    color: var(--primary);
}

.btn.secondary {
    background: transparent;
    color: white;
    border: 2px solid white;
}

.btn:hover {
    transform: translateY(-2px);
    box-shadow: 0 4px 12px rgba(0, 0, 0, 0.3);
}

.features {
    padding: 4rem 0;
}

.container {
    max-width: 1200px;
    margin: 0 auto;
    padding: 0 2rem;
}

.feature-grid {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
    gap: 2rem;
}

.feature-card {
    background: var(--card);
    padding: 2rem;
    border-radius: 1rem;
    border: 1px solid var(--border);
    text-align: center;
    transition: transform 0.2s;
}

.feature-card:hover {
    transform: translateY(-4px);
}

.feature-icon {
    font-size: 3rem;
    margin-bottom: 1rem;
}

.feature-card h3 {
    margin-bottom: 1rem;
    color: var(--primary);
}

.price {
    display: inline-block;
    background: var(--accent);
    color: var(--bg);
    padding: 0.5rem 1rem;
    border-radius: 2rem;
    font-weight: 600;
    margin-top: 1rem;
}

/* Dashboard Styles */
.dashboard {
    display: grid;
    grid-template-columns: 250px 1fr;
    min-height: calc(100vh - 80px);
}

.sidebar {
    background: var(--card);
    border-right: 1px solid var(--border);
    padding: 2rem 1rem;
}

.sidebar nav ul {
    list-style: none;
}

.sidebar nav li {
    margin-bottom: 0.5rem;
}

.sidebar nav a {
    display: block;
    padding: 0.75rem 1rem;
    color: var(--text-muted);
    text-decoration: none;
    border-radius: 0.5rem;
    transition: all 0.2s;
}

.sidebar nav a:hover,
.sidebar nav a.active {
    background: var(--primary);
    color: white;
}

.main-content {
    padding: 2rem;
}

.stats-grid {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
    gap: 1rem;
    margin-bottom: 2rem;
}

.stat-card {
    background: var(--card);
    padding: 1.5rem;
    border-radius: 0.5rem;
    border: 1px solid var(--border);
}

.stat-value {
    font-size: 2rem;
    font-weight: 700;
    color: var(--primary);
}

.stat-label {
    color: var(--text-muted);
    font-size: 0.9rem;
}

/* Form Styles */
.form-group {
    margin-bottom: 1rem;
}

.form-group label {
    display: block;
    margin-bottom: 0.5rem;
    color: var(--text-muted);
}

.form-group input,
.form-group select {
    width: 100%;
    padding: 0.75rem;
    background: var(--bg);
    border: 1px solid var(--border);
    border-radius: 0.5rem;
    color: var(--text);
}

.form-group input:focus,
.form-group select:focus {
    outline: none;
    border-color: var(--primary);
}

/* Responsive Design */
@media (max-width: 768px) {
    .topbar {
        padding: 1rem;
    }
    
    .hero-content h2 {
        font-size: 2rem;
    }
    
    .cta-buttons {
        flex-direction: column;
        align-items: center;
    }
    
    .dashboard {
        grid-template-columns: 1fr;
    }
    
    .sidebar {
        display: none;
    }
}`;
}

function getAppJS() {
  return `// Gospel Lyrics Platform JavaScript
class GospelPlatform {
    constructor() {
        this.apiBase = '/api';
        this.init();
    }

    async init() {
        await this.updateBalance();
        this.setupEventListeners();
    }

    async updateBalance() {
        try {
            const response = await fetch(\`\${this.apiBase}/pesapal/wallet/balance\`);
            const data = await response.json();
            
            const balanceEl = document.getElementById('balance');
            if (balanceEl && data.ok) {
                balanceEl.textContent = \`UGX \${data.balance_ugx.toLocaleString()}\`;
            }
        } catch (error) {
            console.error('Failed to update balance:', error);
        }
    }

    setupEventListeners() {
        // Top-up form handler
        const topupForm = document.getElementById('topup-form');
        if (topupForm) {
            topupForm.addEventListener('submit', this.handleTopup.bind(this));
        }

        // Purchase buttons
        document.querySelectorAll('.purchase-btn').forEach(btn => {
            btn.addEventListener('click', this.handlePurchase.bind(this));
        });
    }

    async handleTopup(event) {
        event.preventDefault();
        
        const formData = new FormData(event.target);
        const amount = parseInt(formData.get('amount')) || 2000;
        const email = formData.get('email') || '';

        try {
            const response = await fetch(\`\${this.apiBase}/pesapal/topup\`, {
                method: 'POST',
                headers: { 'Content-Type': 'application/json' },
                body: JSON.stringify({ amountUGX: amount, email })
            });

            const data = await response.json();
            
            if (data.ok && data.redirect_url) {
                // Open Pesapal payment page
                window.open(data.redirect_url, '_blank');
                this.showMessage('Payment window opened. Complete payment to update balance.', 'info');
            } else {
                this.showMessage('Failed to create payment: ' + (data.error || 'Unknown error'), 'error');
            }
        } catch (error) {
            this.showMessage('Network error: ' + error.message, 'error');
        }
    }

    async handlePurchase(event) {
        const btn = event.target;
        const contentType = btn.dataset.type;
        const contentId = btn.dataset.contentId;

        try {
            const response = await fetch(\`\${this.apiBase}/content/purchase\`, {
                method: 'POST',
                headers: { 'Content-Type': 'application/json' },
                body: JSON.stringify({
                    type: contentType,
                    contentId: contentId,
                    idempotencyKey: \`\${contentId}-\${Date.now()}\`
                })
            });

            const data = await response.json();
            
            if (data.ok) {
                this.showMessage(\`Successfully purchased \${contentType}! New balance: UGX \${data.new_balance}\`, 'success');
                await this.updateBalance();
            } else {
                this.showMessage(\`Purchase failed: \${data.error}\`, 'error');
            }
        } catch (error) {
            this.showMessage('Network error: ' + error.message, 'error');
        }
    }

    showMessage(text, type = 'info') {
        const messageEl = document.createElement('div');
        messageEl.className = \`message message-\${type}\`;
        messageEl.textContent = text;
        
        document.body.appendChild(messageEl);
        
        setTimeout(() => {
            messageEl.remove();
        }, 5000);
    }
}

// Initialize platform when DOM is ready
document.addEventListener('DOMContentLoaded', () => {
    new GospelPlatform();
});`;
}

// Placeholder functions for other HTML pages
function getDashboardHTML() { return '<h1>Dashboard - Coming Soon</h1>'; }
function getPaymentsHTML() { return '<h1>Payments - Coming Soon</h1>'; }
function getConsumeHTML() { return '<h1>Consume - Coming Soon</h1>'; }
function getReconHTML() { return '<h1>Reconciliation - Coming Soon</h1>'; }
