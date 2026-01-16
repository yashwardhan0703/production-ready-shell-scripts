#!/bin/bash
set -e

echo "🔹 Starting Databases via Docker..."

docker compose -f docker/docker-compose.db.yml up -d

echo "MongoDB & PostgreSQL running in Docker"
