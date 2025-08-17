@echo off
echo 🎵 Creating Gospel Lyrics Platform Files...
echo =========================================
echo.

echo Creating main HTML page...
(
echo ^<!DOCTYPE html^>
echo ^<html lang="en"^>
echo ^<head^>
echo     ^<meta charset="UTF-8"^>
echo     ^<meta name="viewport" content="width=device-width, initial-scale=1.0"^>
echo     ^<title^>Gospel Lyrics Platform^</title^>
echo     ^<style^>
echo         * { margin: 0; padding: 0; box-sizing: border-box; }
echo         body { font-family: Arial, sans-serif; background: linear-gradient(135deg, #667eea 0%%, #764ba2 100%%^); min-height: 100vh; color: white; }
echo         .container { max-width: 1200px; margin: 0 auto; padding: 20px; }
echo         header { text-align: center; margin-bottom: 40px; }
echo         h1 { font-size: 3rem; margin-bottom: 10px; text-shadow: 2px 2px 4px rgba(0,0,0,0.3^); }
echo         .subtitle { font-size: 1.2rem; opacity: 0.9; }
echo         .search-section { background: rgba(255,255,255,0.1^); padding: 30px; border-radius: 15px; margin-bottom: 30px; }
echo         .search-box { width: 100%%; padding: 15px; font-size: 1.1rem; border: none; border-radius: 10px; margin-bottom: 20px; }
echo         .songs-grid { display: grid; grid-template-columns: repeat(auto-fit, minmax(300px, 1fr^)^); gap: 20px; }
echo         .song-card { background: rgba(255,255,255,0.15^); padding: 25px; border-radius: 15px; backdrop-filter: blur(10px^); }
echo         .song-title { font-size: 1.4rem; font-weight: bold; margin-bottom: 10px; }
echo         .song-artist { opacity: 0.8; margin-bottom: 15px; }
echo         .song-lyrics { font-style: italic; line-height: 1.6; margin-bottom: 20px; }
echo         .pricing { display: flex; gap: 10px; flex-wrap: wrap; }
echo         .price-btn { background: #ff6b6b; color: white; border: none; padding: 8px 15px; border-radius: 5px; cursor: pointer; font-size: 0.9rem; }
echo         .price-btn:hover { background: #ff5252; }
echo         @media (max-width: 768px^) { h1 { font-size: 2rem; } .container { padding: 10px; } }
echo     ^</style^>
echo ^</head^>
echo ^<body^>
echo     ^<div class="container"^>
echo         ^<header^>
echo             ^<h1^>🎵 Gospel Lyrics Platform^</h1^>
echo             ^<p class="subtitle"^>Share the Gospel Through Music^</p^>
echo         ^</header^>
echo.
echo         ^<div class="search-section"^>
echo             ^<input type="text" class="search-box" placeholder="Search for gospel songs..."^>
echo         ^</div^>
echo.
echo         ^<div class="songs-grid"^>
echo             ^<div class="song-card"^>
echo                 ^<div class="song-title"^>Amazing Grace^</div^>
echo                 ^<div class="song-artist"^>Traditional^</div^>
echo                 ^<div class="song-lyrics"^>
echo                     Amazing grace, how sweet the sound^<br^>
echo                     That saved a wretch like me^<br^>
echo                     I once was lost, but now am found^<br^>
echo                     Was blind, but now I see
echo                 ^</div^>
echo                 ^<div class="pricing"^>
echo                     ^<button class="price-btn"^>Lyrics - 100 UGX^</button^>
echo                     ^<button class="price-btn"^>Audio - 70 UGX^</button^>
echo                     ^<button class="price-btn"^>Stream - 50 UGX^</button^>
echo                 ^</div^>
echo             ^</div^>
echo.
echo             ^<div class="song-card"^>
echo                 ^<div class="song-title"^>How Great Thou Art^</div^>
echo                 ^<div class="song-artist"^>Traditional^</div^>
echo                 ^<div class="song-lyrics"^>
echo                     O Lord my God, when I in awesome wonder^<br^>
echo                     Consider all the worlds thy hands have made^<br^>
echo                     I see the stars, I hear the rolling thunder^<br^>
echo                     Thy power throughout the universe displayed
echo                 ^</div^>
echo                 ^<div class="pricing"^>
echo                     ^<button class="price-btn"^>Lyrics - 100 UGX^</button^>
echo                     ^<button class="price-btn"^>Audio - 70 UGX^</button^>
echo                     ^<button class="price-btn"^>Stream - 50 UGX^</button^>
echo                 ^</div^>
echo             ^</div^>
echo.
echo             ^<div class="song-card"^>
echo                 ^<div class="song-title"^>Blessed Assurance^</div^>
echo                 ^<div class="song-artist"^>Fanny Crosby^</div^>
echo                 ^<div class="song-lyrics"^>
echo                     Blessed assurance, Jesus is mine^<br^>
echo                     O what a foretaste of glory divine^<br^>
echo                     Heir of salvation, purchase of God^<br^>
echo                     Born of His Spirit, washed in His blood
echo                 ^</div^>
echo                 ^<div class="pricing"^>
echo                     ^<button class="price-btn"^>Lyrics - 100 UGX^</button^>
echo                     ^<button class="price-btn"^>Audio - 70 UGX^</button^>
echo                     ^<button class="price-btn"^>Stream - 50 UGX^</button^>
echo                 ^</div^>
echo             ^</div^>
echo         ^</div^>
echo     ^</div^>
echo ^</body^>
echo ^</html^>
) > src\index.html

echo ✅ Gospel Lyrics Platform created!
echo.
echo 🚀 Deploying updated platform...
wrangler pages deploy src --project-name gospel-lyrics-platform

echo.
echo 🎉 Your Gospel Lyrics Platform is now live with content!
echo Visit: https://783f25c7.gospel-lyrics-platform.pages.dev
echo.
pause