#!/bin/bash
set -e

APP_PATH="/var/www/yash"

echo "Starting safe Git pull for Laravel app"
echo "App path: $APP_PATH"

echo "Step 1: Temporarily giving ownership to ubuntu"
sudo chown -R ubuntu:ubuntu "$APP_PATH"

echo "Step 2: Pulling latest code from GitHub"
cd "$APP_PATH"
git pull origin main

echo "Step 3: Restoring Laravel production ownership"
sudo chown -R www-data:www-data "$APP_PATH"
sudo chown -R ubuntu:ubuntu "$APP_PATH/.git"

echo "Step 4: Fixing writable directories"
sudo chmod -R 775 "$APP_PATH/storage" "$APP_PATH/bootstrap/cache"

echo "Safe Git pull completed successfully"
