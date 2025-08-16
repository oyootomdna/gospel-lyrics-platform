// Cloudflare API management for Gospel Lyrics Platform
export async function handleCloudflareRoutes(request, env, ctx) {
  const url = new URL(request.url);
  const path = url.pathname;
  const method = request.method;

  const API_BASE = 'https://api.cloudflare.com/client/v4';
  const headers = {
    'Authorization': `Bearer ${env.CLOUDFLARE_API_TOKEN}`,
    'Content-Type': 'application/json'
  };

  try {
    // Disable DNSSEC
    if (path === '/api/cf/dnssec/disable' && method === 'POST') {
      const response = await fetch(`${API_BASE}/zones/${env.CF_ZONE_ID}/dnssec`, {
        method: 'DELETE',
        headers
      });
      
      const data = await response.json();
      return jsonResponse({
        ok: data.success,
        result: data.result,
        note: 'Remove DS records at registrar to fully disable DNSSEC'
      });
    }

    // Update DNS A record
    if (path === '/api/cf/dns/a' && method === 'POST') {
      const body = await request.json();
      const { name = 'www', content = '192.0.2.1', proxied = true } = body;
      
      const zoneName = env.CF_ZONE_NAME || 'gospellyricsub.com';
      const fqdn = name.includes('.') ? name : `${name}.${zoneName}`;

      // Check if record exists
      const existingResponse = await fetch(
        `${API_BASE}/zones/${env.CF_ZONE_ID}/dns_records?type=A&name=${encodeURIComponent(fqdn)}`,
        { headers }
      );
      const existingData = await existingResponse.json();

      let result;
      if (existingData.success && existingData.result.length > 0) {
        // Update existing record
        const recordId = existingData.result[0].id;
        const updateResponse = await fetch(`${API_BASE}/zones/${env.CF_ZONE_ID}/dns_records/${recordId}`, {
          method: 'PUT',
          headers,
          body: JSON.stringify({
            type: 'A',
            name: fqdn,
            content,
            proxied,
            ttl: proxied ? 1 : 3600
          })
        });
        result = await updateResponse.json();
      } else {
        // Create new record
        const createResponse = await fetch(`${API_BASE}/zones/${env.CF_ZONE_ID}/dns_records`, {
          method: 'POST',
          headers,
          body: JSON.stringify({
            type: 'A',
            name: fqdn,
            content,
            proxied,
            ttl: proxied ? 1 : 3600
          })
        });
        result = await createResponse.json();
      }

      return jsonResponse({
        ok: result.success,
        result: result.result,
        errors: result.errors
      });
    }

    // Set SSL mode
    if (path === '/api/cf/ssl/mode' && method === 'POST') {
      const body = await request.json();
      const { mode = 'full' } = body;

      const response = await fetch(`${API_BASE}/zones/${env.CF_ZONE_ID}/settings/ssl`, {
        method: 'PATCH',
        headers,
        body: JSON.stringify({ value: mode })
      });

      const data = await response.json();
      return jsonResponse({
        ok: data.success,
        result: data.result
      });
    }

    // Enable Always Use HTTPS
    if (path === '/api/cf/ssl/https' && method === 'POST') {
      const body = await request.json();
      const { enabled = true } = body;

      const response = await fetch(`${API_BASE}/zones/${env.CF_ZONE_ID}/settings/always_use_https`, {
        method: 'PATCH',
        headers,
        body: JSON.stringify({ value: enabled ? 'on' : 'off' })
      });

      const data = await response.json();
      return jsonResponse({
        ok: data.success,
        result: data.result
      });
    }

    // Purge cache
    if (path === '/api/cf/cache/purge' && method === 'POST') {
      const response = await fetch(`${API_BASE}/zones/${env.CF_ZONE_ID}/purge_cache`, {
        method: 'POST',
        headers,
        body: JSON.stringify({ purge_everything: true })
      });

      const data = await response.json();
      return jsonResponse({
        ok: data.success,
        result: data.result
      });
    }

    return new Response('Not Found', { status: 404 });

  } catch (error) {
    console.error('Cloudflare route error:', error);
    return jsonResponse({
      ok: false,
      error: error.message
    }, 500);
  }
}

function jsonResponse(data, status = 200) {
  return new Response(JSON.stringify(data), {
    status,
    headers: { 'Content-Type': 'application/json' }
  });
}
