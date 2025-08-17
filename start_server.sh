#!/bin/bash
cd /home/user/webapp/src
echo "Starting server in $(pwd)"
ls -la index.html
python3 -m http.server 5001