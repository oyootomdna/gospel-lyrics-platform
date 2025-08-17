@echo off
echo 🔐 Creating Gospel Lyrics Admin Dashboard...
echo ==========================================
echo.

echo Creating admin login page...
mkdir src\admin 2>nul
(
echo ^<!DOCTYPE html^>
echo ^<html lang="en"^>
echo ^<head^>
echo     ^<meta charset="UTF-8"^>
echo     ^<meta name="viewport" content="width=device-width, initial-scale=1.0"^>
echo     ^<title^>Gospel Lyrics Admin Dashboard^</title^>
echo     ^<style^>
echo         * { margin: 0; padding: 0; box-sizing: border-box; }
echo         body { font-family: Arial, sans-serif; background: linear-gradient(135deg, #1e3c72 0%%, #2a5298 100%%^); min-height: 100vh; color: white; }
echo         .login-container { display: flex; justify-content: center; align-items: center; min-height: 100vh; padding: 20px; }
echo         .login-box { background: rgba(255,255,255,0.1^); padding: 40px; border-radius: 20px; backdrop-filter: blur(15px^); max-width: 400px; width: 100%%; }
echo         .logo { text-align: center; margin-bottom: 30px; }
echo         .logo h1 { font-size: 2.5rem; margin-bottom: 10px; }
echo         .form-group { margin-bottom: 20px; }
echo         label { display: block; margin-bottom: 8px; font-weight: bold; }
echo         input { width: 100%%; padding: 12px; border: none; border-radius: 8px; font-size: 1rem; background: rgba(255,255,255,0.9^); }
echo         .btn { width: 100%%; padding: 15px; background: #ff6b6b; color: white; border: none; border-radius: 8px; font-size: 1.1rem; cursor: pointer; margin-top: 10px; }
echo         .btn:hover { background: #ff5252; }
echo         .back-link { text-align: center; margin-top: 20px; }
echo         .back-link a { color: white; text-decoration: none; opacity: 0.8; }
echo         .back-link a:hover { opacity: 1; }
echo     ^</style^>
echo ^</head^>
echo ^<body^>
echo     ^<div class="login-container"^>
echo         ^<div class="login-box"^>
echo             ^<div class="logo"^>
echo                 ^<h1^>🔐 Admin Login^</h1^>
echo                 ^<p^>Gospel Lyrics Platform^</p^>
echo             ^</div^>
echo             ^<form id="adminLogin"^>
echo                 ^<div class="form-group"^>
echo                     ^<label for="username"^>Username^</label^>
echo                     ^<input type="text" id="username" name="username" placeholder="Enter admin username" required^>
echo                 ^</div^>
echo                 ^<div class="form-group"^>
echo                     ^<label for="password"^>Password^</label^>
echo                     ^<input type="password" id="password" name="password" placeholder="Enter admin password" required^>
echo                 ^</div^>
echo                 ^<button type="submit" class="btn"^>Login to Dashboard^</button^>
echo             ^</form^>
echo             ^<div class="back-link"^>
echo                 ^<a href="../index.html"^>← Back to Gospel Platform^</a^>
echo             ^</div^>
echo         ^</div^>
echo     ^</div^>
echo     ^<script^>
echo         document.getElementById('adminLogin'^).addEventListener('submit', function(e^) {
echo             e.preventDefault(^);
echo             const username = document.getElementById('username'^).value;
echo             const password = document.getElementById('password'^).value;
echo             
echo             // Demo credentials
echo             if (username === 'admin' ^&^& password === 'gospel2024'^) {
echo                 localStorage.setItem('adminLoggedIn', 'true'^);
echo                 window.location.href = 'dashboard.html';
echo             } else {
echo                 alert('Invalid credentials. Demo: admin / gospel2024'^);
echo             }
echo         }^);
echo     ^</script^>
echo ^</body^>
echo ^</html^>
) > src\admin\index.html

echo Creating admin dashboard...
(
echo ^<!DOCTYPE html^>
echo ^<html lang="en"^>
echo ^<head^>
echo     ^<meta charset="UTF-8"^>
echo     ^<meta name="viewport" content="width=device-width, initial-scale=1.0"^>
echo     ^<title^>Gospel Lyrics Admin Dashboard^</title^>
echo     ^<style^>
echo         * { margin: 0; padding: 0; box-sizing: border-box; }
echo         body { font-family: Arial, sans-serif; background: #f5f5f5; }
echo         .header { background: linear-gradient(135deg, #1e3c72 0%%, #2a5298 100%%^); color: white; padding: 20px; }
echo         .header h1 { display: inline-block; }
echo         .logout { float: right; background: #ff6b6b; color: white; border: none; padding: 10px 20px; border-radius: 5px; cursor: pointer; }
echo         .nav { background: white; padding: 15px; box-shadow: 0 2px 4px rgba(0,0,0,0.1^); margin-bottom: 20px; }
echo         .nav-item { display: inline-block; margin-right: 20px; padding: 10px 15px; background: #667eea; color: white; border-radius: 5px; cursor: pointer; }
echo         .nav-item.active { background: #ff6b6b; }
echo         .container { max-width: 1200px; margin: 0 auto; padding: 20px; }
echo         .stats { display: grid; grid-template-columns: repeat(auto-fit, minmax(250px, 1fr^)^); gap: 20px; margin-bottom: 30px; }
echo         .stat-card { background: white; padding: 25px; border-radius: 10px; box-shadow: 0 2px 10px rgba(0,0,0,0.1^); text-align: center; }
echo         .stat-number { font-size: 2.5rem; font-weight: bold; color: #667eea; margin-bottom: 10px; }
echo         .content-section { background: white; padding: 30px; border-radius: 10px; box-shadow: 0 2px 10px rgba(0,0,0,0.1^); margin-bottom: 20px; }
echo         .form-grid { display: grid; grid-template-columns: 1fr 1fr; gap: 20px; }
echo         .form-group { margin-bottom: 20px; }
echo         label { display: block; margin-bottom: 8px; font-weight: bold; color: #333; }
echo         input, textarea, select { width: 100%%; padding: 12px; border: 1px solid #ddd; border-radius: 5px; font-size: 1rem; }
echo         textarea { resize: vertical; min-height: 120px; }
echo         .btn { padding: 12px 25px; background: #667eea; color: white; border: none; border-radius: 5px; cursor: pointer; font-size: 1rem; }
echo         .btn:hover { background: #5a67d8; }
echo         .btn-danger { background: #ff6b6b; }
echo         .btn-danger:hover { background: #ff5252; }
echo         .songs-table { width: 100%%; border-collapse: collapse; margin-top: 20px; }
echo         .songs-table th, .songs-table td { padding: 12px; text-align: left; border-bottom: 1px solid #ddd; }
echo         .songs-table th { background: #f8f9fa; font-weight: bold; }
echo         .action-buttons { display: flex; gap: 5px; }
echo         .action-btn { padding: 5px 10px; border: none; border-radius: 3px; cursor: pointer; font-size: 0.9rem; }
echo         .edit-btn { background: #ffc107; color: black; }
echo         .delete-btn { background: #dc3545; color: white; }
echo         @media (max-width: 768px^) { .form-grid { grid-template-columns: 1fr; } .header h1 { display: block; margin-bottom: 10px; } .logout { float: none; } }
echo     ^</style^>
echo ^</head^>
echo ^<body^>
echo     ^<div class="header"^>
echo         ^<h1^>🎵 Gospel Lyrics Admin Dashboard^</h1^>
echo         ^<button class="logout" onclick="logout(^)"^>Logout^</button^>
echo     ^</div^>
echo     
echo     ^<div class="nav"^>
echo         ^<div class="nav-item active" onclick="showSection('overview'^)"^>Overview^</div^>
echo         ^<div class="nav-item" onclick="showSection('songs'^)"^>Manage Songs^</div^>
echo         ^<div class="nav-item" onclick="showSection('users'^)"^>Users^</div^>
echo         ^<div class="nav-item" onclick="showSection('settings'^)"^>Settings^</div^>
echo         ^<div class="nav-item" onclick="showSection('apps'^)"^>Mobile Apps^</div^>
echo     ^</div^>
echo.
echo     ^<div class="container"^>
echo         ^<div id="overview" class="section"^>
echo             ^<div class="stats"^>
echo                 ^<div class="stat-card"^>
echo                     ^<div class="stat-number"^>3^</div^>
echo                     ^<div^>Total Songs^</div^>
echo                 ^</div^>
echo                 ^<div class="stat-card"^>
echo                     ^<div class="stat-number"^>1^</div^>
echo                     ^<div^>Active Users^</div^>
echo                 ^</div^>
echo                 ^<div class="stat-card"^>
echo                     ^<div class="stat-number"^>0^</div^>
echo                     ^<div^>Total Revenue (UGX^)^</div^>
echo                 ^</div^>
echo                 ^<div class="stat-card"^>
echo                     ^<div class="stat-number"^>100%%^</div^>
echo                     ^<div^>Uptime^</div^>
echo                 ^</div^>
echo             ^</div^>
echo         ^</div^>
echo.
echo         ^<div id="songs" class="section" style="display:none;"^>
echo             ^<div class="content-section"^>
echo                 ^<h2^>Add New Gospel Song^</h2^>
echo                 ^<form id="addSongForm"^>
echo                     ^<div class="form-grid"^>
echo                         ^<div class="form-group"^>
echo                             ^<label^>Song Title^</label^>
echo                             ^<input type="text" id="songTitle" required^>
echo                         ^</div^>
echo                         ^<div class="form-group"^>
echo                             ^<label^>Artist^</label^>
echo                             ^<input type="text" id="songArtist" required^>
echo                         ^</div^>
echo                         ^<div class="form-group"^>
echo                             ^<label^>Category^</label^>
echo                             ^<select id="songCategory"^>
echo                                 ^<option value="HYMNS"^>Hymns^</option^>
echo                                 ^<option value="CONTEMPORARY"^>Contemporary^</option^>
echo                                 ^<option value="TRADITIONAL"^>Traditional^</option^>
echo                                 ^<option value="PRAISE"^>Praise^</option^>
echo                                 ^<option value="WORSHIP"^>Worship^</option^>
echo                             ^</select^>
echo                         ^</div^>
echo                         ^<div class="form-group"^>
echo                             ^<label^>Duration (seconds^)^</label^>
echo                             ^<input type="number" id="songDuration" placeholder="240"^>
echo                         ^</div^>
echo                     ^</div^>
echo                     ^<div class="form-group"^>
echo                         ^<label^>Lyrics^</label^>
echo                         ^<textarea id="songLyrics" placeholder="Enter full gospel song lyrics..." required^>^</textarea^>
echo                     ^</div^>
echo                     ^<div class="form-grid"^>
echo                         ^<div class="form-group"^>
echo                             ^<label^>Lyrics Price (UGX^)^</label^>
echo                             ^<input type="number" id="lyricsPrice" value="100"^>
echo                         ^</div^>
echo                         ^<div class="form-group"^>
echo                             ^<label^>Audio Price (UGX^)^</label^>
echo                             ^<input type="number" id="audioPrice" value="70"^>
echo                         ^</div^>
echo                         ^<div class="form-group"^>
echo                             ^<label^>Stream Price (UGX^)^</label^>
echo                             ^<input type="number" id="streamPrice" value="50"^>
echo                         ^</div^>
echo                         ^<div class="form-group"^>
echo                             ^<label^>Audio File URL^</label^>
echo                             ^<input type="url" id="audioUrl" placeholder="https://example.com/song.mp3"^>
echo                         ^</div^>
echo                     ^</div^>
echo                     ^<button type="submit" class="btn"^>Add Gospel Song^</button^>
echo                 ^</form^>
echo             ^</div^>
echo             
echo             ^<div class="content-section"^>
echo                 ^<h2^>Current Gospel Songs^</h2^>
echo                 ^<table class="songs-table"^>
echo                     ^<thead^>
echo                         ^<tr^>
echo                             ^<th^>Title^</th^>
echo                             ^<th^>Artist^</th^>
echo                             ^<th^>Category^</th^>
echo                             ^<th^>Prices (UGX^)^</th^>
echo                             ^<th^>Actions^</th^>
echo                         ^</tr^>
echo                     ^</thead^>
echo                     ^<tbody id="songsTableBody"^>
echo                         ^<tr^>
echo                             ^<td^>Amazing Grace^</td^>
echo                             ^<td^>Traditional^</td^>
echo                             ^<td^>HYMNS^</td^>
echo                             ^<td^>100/70/50^</td^>
echo                             ^<td class="action-buttons"^>
echo                                 ^<button class="action-btn edit-btn"^>Edit^</button^>
echo                                 ^<button class="action-btn delete-btn"^>Delete^</button^>
echo                             ^</td^>
echo                         ^</tr^>
echo                         ^<tr^>
echo                             ^<td^>How Great Thou Art^</td^>
echo                             ^<td^>Traditional^</td^>
echo                             ^<td^>HYMNS^</td^>
echo                             ^<td^>100/70/50^</td^>
echo                             ^<td class="action-buttons"^>
echo                                 ^<button class="action-btn edit-btn"^>Edit^</button^>
echo                                 ^<button class="action-btn delete-btn"^>Delete^</button^>
echo                             ^</td^>
echo                         ^</tr^>
echo                     ^</tbody^>
echo                 ^</table^>
echo             ^</div^>
echo         ^</div^>
echo.
echo         ^<div id="apps" class="section" style="display:none;"^>
echo             ^<div class="content-section"^>
echo                 ^<h2^>📱 Mobile App Distribution^</h2^>
echo                 ^<div class="stats"^>
echo                     ^<div class="stat-card"^>
echo                         ^<h3^>🍎 iOS App Store^</h3^>
echo                         ^<p^>Status: Ready for Development^</p^>
echo                         ^<button class="btn"^>Generate iOS App^</button^>
echo                     ^</div^>
echo                     ^<div class="stat-card"^>
echo                         ^<h3^>🤖 Google Play Store^</h3^>
echo                         ^<p^>Status: Ready for Development^</p^>
echo                         ^<button class="btn"^>Generate Android App^</button^>
echo                     ^</div^>
echo                     ^<div class="stat-card"^>
echo                         ^<h3^>🖥️ Windows Store^</h3^>
echo                         ^<p^>Status: Ready for Development^</p^>
echo                         ^<button class="btn"^>Generate Windows App^</button^>
echo                     ^</div^>
echo                     ^<div class="stat-card"^>
echo                         ^<h3^>🍏 Mac App Store^</h3^>
echo                         ^<p^>Status: Ready for Development^</p^>
echo                         ^<button class="btn"^>Generate macOS App^</button^>
echo                     ^</div^>
echo                 ^</div^>
echo                 
echo                 ^<div style="margin-top: 30px;"^>
echo                     ^<h3^>App Development Steps:^</h3^>
echo                     ^<ol^>
echo                         ^<li^>React Native app development for iOS/Android^</li^>
echo                         ^<li^>Electron app for Windows/Mac desktop^</li^>
echo                         ^<li^>Apple Watch companion app^</li^>
echo                         ^<li^>Store submission and approval process^</li^>
echo                         ^<li^>App marketing and distribution^</li^>
echo                     ^</ol^>
echo                 ^</div^>
echo             ^</div^>
echo         ^</div^>
echo         
echo         ^<div id="settings" class="section" style="display:none;"^>
echo             ^<div class="content-section"^>
echo                 ^<h2^>Platform Settings^</h2^>
echo                 ^<div class="form-grid"^>
echo                     ^<div class="form-group"^>
echo                         ^<label^>Platform Name^</label^>
echo                         ^<input type="text" value="Gospel Lyrics Platform"^>
echo                     ^</div^>
echo                     ^<div class="form-group"^>
echo                         ^<label^>Domain^</label^>
echo                         ^<input type="text" value="gospellyricsub.com"^>
echo                     ^</div^>
echo                     ^<div class="form-group"^>
echo                         ^<label^>Default Currency^</label^>
echo                         ^<select^>
echo                             ^<option value="UGX" selected^>UGX (Uganda Shillings^)^</option^>
echo                             ^<option value="USD"^>USD^</option^>
echo                             ^<option value="KES"^>KES^</option^>
echo                         ^</select^>
echo                     ^</div^>
echo                     ^<div class="form-group"^>
echo                         ^<label^>VAT Rate (%%^)^</label^>
echo                         ^<input type="number" value="18"^>
echo                     ^</div^>
echo                 ^</div^>
echo                 ^<button class="btn"^>Save Settings^</button^>
echo             ^</div^>
echo         ^</div^>
echo     ^</div^>
echo.
echo     ^<script^>
echo         // Check authentication
echo         if (!localStorage.getItem('adminLoggedIn'^)^) {
echo             window.location.href = 'index.html';
echo         }
echo         
echo         function logout(^) {
echo             localStorage.removeItem('adminLoggedIn'^);
echo             window.location.href = 'index.html';
echo         }
echo         
echo         function showSection(sectionName^) {
echo             // Hide all sections
echo             document.querySelectorAll('.section'^).forEach(section =^> {
echo                 section.style.display = 'none';
echo             }^);
echo             
echo             // Remove active class from all nav items
echo             document.querySelectorAll('.nav-item'^).forEach(item =^> {
echo                 item.classList.remove('active'^);
echo             }^);
echo             
echo             // Show selected section
echo             document.getElementById(sectionName^).style.display = 'block';
echo             
echo             // Add active class to clicked nav item
echo             event.target.classList.add('active'^);
echo         }
echo         
echo         // Add song form submission
echo         document.getElementById('addSongForm'^).addEventListener('submit', function(e^) {
echo             e.preventDefault(^);
echo             alert('Song would be added to database in production version'^);
echo         }^);
echo     ^</script^>
echo ^</body^>
echo ^</html^>
) > src\admin\dashboard.html

echo ✅ Admin dashboard created!
echo.
echo 🚀 Deploying admin dashboard...
wrangler pages deploy src --project-name gospel-lyrics-platform

echo.
echo 🎉 Admin dashboard deployed!
echo.
echo 🔐 Admin Access:
echo URL: https://your-platform-url/admin/
echo Username: admin
echo Password: gospel2024
echo.
pause