#!/bin/bash
set -e

echo "Installing NGINX..."

sudo apt update -y
sudo apt install -y nginx

sudo systemctl enable nginx
sudo systemctl start nginx

echo "NGINX ready"
