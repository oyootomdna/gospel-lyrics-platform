@echo off
echo 🔐 Adding Admin Features to Gospel Lyrics Platform...
echo ==================================================
echo.

echo Creating admin login page...
(
echo ^<!DOCTYPE html^>
echo ^<html lang="en"^>
echo ^<head^>
echo     ^<meta charset="UTF-8"^>
echo     ^<meta name="viewport" content="width=device-width, initial-scale=1.0"^>
echo     ^<title^>Admin Login - Gospel Lyrics Platform^</title^>
echo     ^<style^>
echo         * { margin: 0; padding: 0; box-sizing: border-box; }
echo         body { font-family: Arial, sans-serif; background: linear-gradient(135deg, #2c3e50 0%%, #34495e 100%%^); min-height: 100vh; display: flex; align-items: center; justify-content: center; }
echo         .login-container { background: rgba(255,255,255,0.95^); padding: 40px; border-radius: 15px; box-shadow: 0 10px 30px rgba(0,0,0,0.3^); max-width: 400px; width: 100%%; }
echo         .login-header { text-align: center; margin-bottom: 30px; }
echo         .login-header h1 { color: #2c3e50; margin-bottom: 10px; }
echo         .login-header p { color: #7f8c8d; }
echo         .form-group { margin-bottom: 20px; }
echo         label { display: block; margin-bottom: 5px; color: #2c3e50; font-weight: bold; }
echo         input[type="text"], input[type="password"] { width: 100%%; padding: 12px; border: 2px solid #ecf0f1; border-radius: 8px; font-size: 16px; }
echo         input:focus { outline: none; border-color: #3498db; }
echo         .login-btn { width: 100%%; background: #3498db; color: white; border: none; padding: 15px; border-radius: 8px; font-size: 16px; cursor: pointer; margin-top: 10px; }
echo         .login-btn:hover { background: #2980b9; }
echo         .admin-info { background: #e8f6f3; padding: 15px; border-radius: 8px; margin-top: 20px; border-left: 4px solid #27ae60; }
echo         .admin-info h3 { color: #27ae60; margin-bottom: 10px; }
echo         .admin-info p { color: #2c3e50; font-size: 14px; }
echo     ^</style^>
echo ^</head^>
echo ^<body^>
echo     ^<div class="login-container"^>
echo         ^<div class="login-header"^>
echo             ^<h1^>🔐 Admin Login^</h1^>
echo             ^<p^>Gospel Lyrics Platform Administration^</p^>
echo         ^</div^>
echo         
echo         ^<form id="adminLogin"^>
echo             ^<div class="form-group"^>
echo                 ^<label for="username"^>Username:^</label^>
echo                 ^<input type="text" id="username" name="username" required^>
echo             ^</div^>
echo             
echo             ^<div class="form-group"^>
echo                 ^<label for="password"^>Password:^</label^>
echo                 ^<input type="password" id="password" name="password" required^>
echo             ^</div^>
echo             
echo             ^<button type="submit" class="login-btn"^>Login to Admin Panel^</button^>
echo         ^</form^>
echo         
echo         ^<div class="admin-info"^>
echo             ^<h3^>Admin Access^</h3^>
echo             ^<p^>^<strong^>Default Login:^</strong^>^</p^>
echo             ^<p^>Username: admin^</p^>
echo             ^<p^>Password: gospel2024^</p^>
echo             ^<p^>^<em^>Change these credentials after first login^</em^>^</p^>
echo         ^</div^>
echo     ^</div^>
echo     
echo     ^<script^>
echo         document.getElementById('adminLogin'^).addEventListener('submit', function(e^) {
echo             e.preventDefault(^);
echo             const username = document.getElementById('username'^).value;
echo             const password = document.getElementById('password'^).value;
echo             
echo             // Simple authentication (replace with proper authentication later^)
echo             if (username === 'admin' ^&^& password === 'gospel2024'^) {
echo                 localStorage.setItem('adminLoggedIn', 'true'^);
echo                 window.location.href = 'admin-dashboard.html';
echo             } else {
echo                 alert('Invalid credentials. Please try again.'^);
echo             }
echo         }^);
echo     ^</script^>
echo ^</body^>
echo ^</html^>
) > src\admin.html

echo Creating admin dashboard...
(
echo ^<!DOCTYPE html^>
echo ^<html lang="en"^>
echo ^<head^>
echo     ^<meta charset="UTF-8"^>
echo     ^<meta name="viewport" content="width=device-width, initial-scale=1.0"^>
echo     ^<title^>Admin Dashboard - Gospel Lyrics Platform^</title^>
echo     ^<style^>
echo         * { margin: 0; padding: 0; box-sizing: border-box; }
echo         body { font-family: Arial, sans-serif; background: #f4f4f4; }
echo         .header { background: #2c3e50; color: white; padding: 15px 0; box-shadow: 0 2px 5px rgba(0,0,0,0.1^); }
echo         .header-content { max-width: 1200px; margin: 0 auto; display: flex; justify-content: space-between; align-items: center; padding: 0 20px; }
echo         .logo h1 { font-size: 1.5rem; }
echo         .logout-btn { background: #e74c3c; color: white; border: none; padding: 10px 20px; border-radius: 5px; cursor: pointer; }
echo         .container { max-width: 1200px; margin: 0 auto; padding: 20px; }
echo         .dashboard-grid { display: grid; grid-template-columns: repeat(auto-fit, minmax(300px, 1fr^)^); gap: 20px; margin-bottom: 30px; }
echo         .dashboard-card { background: white; padding: 25px; border-radius: 10px; box-shadow: 0 2px 10px rgba(0,0,0,0.1^); }
echo         .card-header { display: flex; justify-content: space-between; align-items: center; margin-bottom: 15px; }
echo         .card-title { font-size: 1.2rem; color: #2c3e50; font-weight: bold; }
echo         .card-number { font-size: 2rem; color: #3498db; font-weight: bold; }
echo         .songs-management { background: white; padding: 25px; border-radius: 10px; box-shadow: 0 2px 10px rgba(0,0,0,0.1^); }
echo         .section-title { font-size: 1.3rem; color: #2c3e50; margin-bottom: 20px; border-bottom: 2px solid #3498db; padding-bottom: 10px; }
echo         .add-song-form { display: grid; grid-template-columns: 1fr 1fr; gap: 15px; margin-bottom: 20px; }
echo         .form-group { display: flex; flex-direction: column; }
echo         .form-group.full-width { grid-column: 1 / -1; }
echo         label { margin-bottom: 5px; color: #2c3e50; font-weight: bold; }
echo         input, textarea, select { padding: 10px; border: 1px solid #ddd; border-radius: 5px; font-size: 14px; }
echo         textarea { resize: vertical; min-height: 100px; }
echo         .btn { background: #3498db; color: white; border: none; padding: 12px 20px; border-radius: 5px; cursor: pointer; font-size: 14px; }
echo         .btn:hover { background: #2980b9; }
echo         .btn-danger { background: #e74c3c; }
echo         .btn-danger:hover { background: #c0392b; }
echo         .songs-list { overflow-x: auto; }
echo         table { width: 100%%; border-collapse: collapse; margin-top: 15px; }
echo         th, td { text-align: left; padding: 12px; border-bottom: 1px solid #ddd; }
echo         th { background: #f8f9fa; font-weight: bold; color: #2c3e50; }
echo         .action-buttons { display: flex; gap: 5px; }
echo         .btn-sm { padding: 5px 10px; font-size: 12px; }
echo         @media (max-width: 768px^) { .add-song-form { grid-template-columns: 1fr; } }
echo     ^</style^>
echo ^</head^>
echo ^<body^>
echo     ^<div class="header"^>
echo         ^<div class="header-content"^>
echo             ^<div class="logo"^>
echo                 ^<h1^>🎵 Gospel Lyrics Admin^</h1^>
echo             ^</div^>
echo             ^<button class="logout-btn" onclick="logout(^)"^>Logout^</button^>
echo         ^</div^>
echo     ^</div^>
echo     
echo     ^<div class="container"^>
echo         ^<div class="dashboard-grid"^>
echo             ^<div class="dashboard-card"^>
echo                 ^<div class="card-header"^>
echo                     ^<div class="card-title"^>Total Songs^</div^>
echo                 ^</div^>
echo                 ^<div class="card-number" id="totalSongs"^>3^</div^>
echo             ^</div^>
echo             
echo             ^<div class="dashboard-card"^>
echo                 ^<div class="card-header"^>
echo                     ^<div class="card-title"^>Total Users^</div^>
echo                 ^</div^>
echo                 ^<div class="card-number" id="totalUsers"^>1^</div^>
echo             ^</div^>
echo             
echo             ^<div class="dashboard-card"^>
echo                 ^<div class="card-header"^>
echo                     ^<div class="card-title"^>Revenue (UGX^)^</div^>
echo                 ^</div^>
echo                 ^<div class="card-number" id="totalRevenue"^>0^</div^>
echo             ^</div^>
echo         ^</div^>
echo         
echo         ^<div class="songs-management"^>
echo             ^<h2 class="section-title"^>Manage Gospel Songs^</h2^>
echo             
echo             ^<div class="add-song-form"^>
echo                 ^<div class="form-group"^>
echo                     ^<label for="songTitle"^>Song Title:^</label^>
echo                     ^<input type="text" id="songTitle" placeholder="Enter song title"^>
echo                 ^</div^>
echo                 
echo                 ^<div class="form-group"^>
echo                     ^<label for="songArtist"^>Artist:^</label^>
echo                     ^<input type="text" id="songArtist" placeholder="Enter artist name"^>
echo                 ^</div^>
echo                 
echo                 ^<div class="form-group"^>
echo                     ^<label for="songCategory"^>Category:^</label^>
echo                     ^<select id="songCategory"^>
echo                         ^<option value="HYMNS"^>Traditional Hymns^</option^>
echo                         ^<option value="CONTEMPORARY"^>Contemporary^</option^>
echo                         ^<option value="WORSHIP"^>Worship^</option^>
echo                         ^<option value="PRAISE"^>Praise^</option^>
echo                     ^</select^>
echo                 ^</div^>
echo                 
echo                 ^<div class="form-group"^>
echo                     ^<label for="lyricsPrice"^>Lyrics Price (UGX^):^</label^>
echo                     ^<input type="number" id="lyricsPrice" value="100"^>
echo                 ^</div^>
echo                 
echo                 ^<div class="form-group full-width"^>
echo                     ^<label for="songLyrics"^>Lyrics:^</label^>
echo                     ^<textarea id="songLyrics" placeholder="Enter song lyrics..."^>^</textarea^>
echo                 ^</div^>
echo                 
echo                 ^<div class="form-group full-width"^>
echo                     ^<button class="btn" onclick="addSong(^)"^>Add Gospel Song^</button^>
echo                 ^</div^>
echo             ^</div^>
echo             
echo             ^<div class="songs-list"^>
echo                 ^<h3^>Current Gospel Songs^</h3^>
echo                 ^<table^>
echo                     ^<thead^>
echo                         ^<tr^>
echo                             ^<th^>Title^</th^>
echo                             ^<th^>Artist^</th^>
echo                             ^<th^>Category^</th^>
echo                             ^<th^>Price^</th^>
echo                             ^<th^>Actions^</th^>
echo                         ^</tr^>
echo                     ^</thead^>
echo                     ^<tbody id="songsTable"^>
echo                         ^<tr^>
echo                             ^<td^>Amazing Grace^</td^>
echo                             ^<td^>Traditional^</td^>
echo                             ^<td^>HYMNS^</td^>
echo                             ^<td^>100 UGX^</td^>
echo                             ^<td^>
echo                                 ^<div class="action-buttons"^>
echo                                     ^<button class="btn btn-sm"^>Edit^</button^>
echo                                     ^<button class="btn btn-sm btn-danger"^>Delete^</button^>
echo                                 ^</div^>
echo                             ^</td^>
echo                         ^</tr^>
echo                         ^<tr^>
echo                             ^<td^>How Great Thou Art^</td^>
echo                             ^<td^>Traditional^</td^>
echo                             ^<td^>HYMNS^</td^>
echo                             ^<td^>100 UGX^</td^>
echo                             ^<td^>
echo                                 ^<div class="action-buttons"^>
echo                                     ^<button class="btn btn-sm"^>Edit^</button^>
echo                                     ^<button class="btn btn-sm btn-danger"^>Delete^</button^>
echo                                 ^</div^>
echo                             ^</td^>
echo                         ^</tr^>
echo                         ^<tr^>
echo                             ^<td^>Blessed Assurance^</td^>
echo                             ^<td^>Fanny Crosby^</td^>
echo                             ^<td^>HYMNS^</td^>
echo                             ^<td^>100 UGX^</td^>
echo                             ^<td^>
echo                                 ^<div class="action-buttons"^>
echo                                     ^<button class="btn btn-sm"^>Edit^</button^>
echo                                     ^<button class="btn btn-sm btn-danger"^>Delete^</button^>
echo                                 ^</div^>
echo                             ^</td^>
echo                         ^</tr^>
echo                     ^</tbody^>
echo                 ^</table^>
echo             ^</div^>
echo         ^</div^>
echo     ^</div^>
echo     
echo     ^<script^>
echo         // Check if admin is logged in
echo         if (localStorage.getItem('adminLoggedIn'^) !== 'true'^) {
echo             window.location.href = 'admin.html';
echo         }
echo         
echo         function logout(^) {
echo             localStorage.removeItem('adminLoggedIn'^);
echo             window.location.href = 'admin.html';
echo         }
echo         
echo         function addSong(^) {
echo             const title = document.getElementById('songTitle'^).value;
echo             const artist = document.getElementById('songArtist'^).value;
echo             const category = document.getElementById('songCategory'^).value;
echo             const price = document.getElementById('lyricsPrice'^).value;
echo             const lyrics = document.getElementById('songLyrics'^).value;
echo             
echo             if (!title || !artist || !lyrics^) {
echo                 alert('Please fill in all required fields'^);
echo                 return;
echo             }
echo             
echo             // Add to table (in real app, this would connect to your D1 database^)
echo             const table = document.getElementById('songsTable'^);
echo             const newRow = table.insertRow(^);
echo             newRow.innerHTML = `
echo                 ^<td^>${title}^</td^>
echo                 ^<td^>${artist}^</td^>
echo                 ^<td^>${category}^</td^>
echo                 ^<td^>${price} UGX^</td^>
echo                 ^<td^>
echo                     ^<div class="action-buttons"^>
echo                         ^<button class="btn btn-sm"^>Edit^</button^>
echo                         ^<button class="btn btn-sm btn-danger" onclick="deleteSong(this^)"^>Delete^</button^>
echo                     ^</div^>
echo                 ^</td^>
echo             `;
echo             
echo             // Clear form
echo             document.getElementById('songTitle'^).value = '';
echo             document.getElementById('songArtist'^).value = '';
echo             document.getElementById('songLyrics'^).value = '';
echo             
echo             // Update count
echo             const totalSongs = document.getElementById('totalSongs'^);
echo             totalSongs.textContent = parseInt(totalSongs.textContent^) + 1;
echo             
echo             alert('Gospel song added successfully!'^);
echo         }
echo         
echo         function deleteSong(button^) {
echo             if (confirm('Are you sure you want to delete this gospel song?'^)^) {
echo                 const row = button.closest('tr'^);
echo                 row.remove(^);
echo                 
echo                 // Update count
echo                 const totalSongs = document.getElementById('totalSongs'^);
echo                 totalSongs.textContent = parseInt(totalSongs.textContent^) - 1;
echo             }
echo         }
echo     ^</script^>
echo ^</body^>
echo ^</html^>
) > src\admin-dashboard.html

echo ✅ Admin features created!
echo.
echo 🚀 Deploying updated platform with admin features...
wrangler pages deploy src --project-name gospel-lyrics-platform

echo.
echo 🎉 Admin features added successfully!
echo.
echo 📋 Admin Access:
echo URL: https://your-platform-url/admin.html
echo Username: admin
echo Password: gospel2024
echo.
echo 🔐 IMPORTANT: Change default credentials after first login
echo.
pause