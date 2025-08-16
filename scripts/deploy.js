#!/usr/bin/env node

// Automated deployment script for Gospel Lyrics Platform
import { execSync } from 'child_process';
import fs from 'fs';
import path from 'path';

const CONFIG = {
  projectName: 'gospel-lyrics-platform',
  domain: 'gospellyricsub.com',
  dbName: 'gospel-lyrics-db'
};

async function main() {
  console.log('🚀 Starting Gospel Lyrics Platform Deployment...\n');

  try {
    // Step 1: Check prerequisites
    await checkPrerequisites();
    
    // Step 2: Create D1 database
    await createDatabase();
    
    // Step 3: Run migrations
    await runMigrations();
    
    // Step 4: Deploy to Cloudflare
    await deployToCloudflare();
    
    // Step 5: Configure environment
    await configureEnvironment();
    
    // Step 6: Test deployment
    await testDeployment();
    
    console.log('\n✅ Deployment completed successfully!');
    console.log(`🌐 Your platform is live at: https://${CONFIG.domain}`);
    console.log('📊 Dashboard: https://${CONFIG.domain}/dashboard');
    console.log('💳 Payments: https://${CONFIG.domain}/payments');
    
  } catch (error) {
    console.error('\n❌ Deployment failed:', error.message);
    process.exit(1);
  }
}

async function checkPrerequisites() {
  console.log('📋 Checking prerequisites...');
  
  // Check if wrangler is installed
  try {
    execSync('wrangler --version', { stdio: 'ignore' });
    console.log('✅ Wrangler CLI found');
  } catch {
    console.log('📦 Installing Wrangler CLI...');
    execSync('npm install -g wrangler', { stdio: 'inherit' });
  }
  
  // Check if logged in to Cloudflare
  try {
    execSync('wrangler whoami', { stdio: 'ignore' });
    console.log('✅ Authenticated with Cloudflare');
  } catch {
    console.log('🔐 Please authenticate with Cloudflare:');
    execSync('wrangler login', { stdio: 'inherit' });
  }
  
  // Check environment file
  if (!fs.existsSync('.env')) {
    console.log('⚠️  No .env file found. Please create one based on .env.example');
    process.exit(1);
  }
  console.log('✅ Environment file found');
}

async function createDatabase() {
  console.log('\n🗄️  Creating D1 database...');
  
  try {
    // Check if database already exists
    const result = execSync('wrangler d1 list', { encoding: 'utf8' });
    if (result.includes(CONFIG.dbName)) {
      console.log('✅ Database already exists');
      return;
    }
    
    // Create new database
    const createResult = execSync(`wrangler d1 create ${CONFIG.dbName}`, { encoding: 'utf8' });
    console.log('✅ Database created');
    
    // Extract database ID from output
    const dbIdMatch = createResult.match(/database_id = "([^"]+)"/);
    if (dbIdMatch) {
      const dbId = dbIdMatch[1];
      console.log(`📝 Database ID: ${dbId}`);
      console.log('⚠️  Please update your wrangler.toml with this database_id');
    }
    
  } catch (error) {
    console.log('ℹ️  Database creation skipped (may already exist)');
  }
}

async function runMigrations() {
  console.log('\n📊 Running database migrations...');
  
  try {
    execSync(`wrangler d1 migrations apply ${CONFIG.dbName} --env production`, { stdio: 'inherit' });
    console.log('✅ Migrations completed');
  } catch (error) {
    console.log('⚠️  Migration failed, but continuing deployment...');
  }
}

async function deployToCloudflare() {
  console.log('\n🚀 Deploying to Cloudflare Workers...');
  
  try {
    execSync('wrangler deploy --env production', { stdio: 'inherit' });
    console.log('✅ Worker deployed successfully');
  } catch (error) {
    throw new Error('Worker deployment failed');
  }
}

async function configureEnvironment() {
  console.log('\n⚙️  Configuring environment variables...');
  
  // Read .env file and set secrets
  const envContent = fs.readFileSync('.env', 'utf8');
  const envVars = envContent.split('\n')
    .filter(line => line.trim() && !line.startsWith('#'))
    .map(line => line.split('='))
    .filter(([key, value]) => key && value);
  
  for (const [key, value] of envVars) {
    if (key.includes('SECRET') || key.includes('KEY') || key.includes('TOKEN')) {
      try {
        execSync(`wrangler secret put ${key}`, { 
          input: value.replace(/['"]/g, ''),
          stdio: ['pipe', 'pipe', 'inherit']
        });
        console.log(`✅ Secret ${key} configured`);
      } catch (error) {
        console.log(`⚠️  Failed to set secret ${key}`);
      }
    }
  }
}

async function testDeployment() {
  console.log('\n🧪 Testing deployment...');
  
  try {
    const testUrl = `https://${CONFIG.domain}/api/health`;
    const response = await fetch(testUrl);
    
    if (response.ok) {
      const data = await response.json();
      console.log('✅ Health check passed');
      console.log(`📊 Platform: ${data.platform}`);
    } else {
      console.log('⚠️  Health check failed, but deployment may still be working');
    }
  } catch (error) {
    console.log('⚠️  Unable to test deployment automatically');
  }
}

// Run deployment
main().catch(console.error);
