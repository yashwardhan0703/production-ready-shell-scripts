#!/bin/bash
set -e

NETWORK="prod-network"

if docker network inspect $NETWORK >/dev/null 2>&1; then
  echo "ℹ️ Docker network already exists"
else
  docker network create $NETWORK
  echo "✅ Docker network created: $NETWORK"
fi
