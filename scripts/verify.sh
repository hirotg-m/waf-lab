#!/usr/bin/env bash
set -euo pipefail

TARGET_URL="${1:-http://localhost}"

echo "[1/3] Checking container status"
docker ps --filter "name=waf-lab" --format "table {{.Names}}\t{{.Status}}\t{{.Ports}}"

echo "[2/3] Basic health check"
curl -i "$TARGET_URL" || true

echo "[3/3] Basic malicious pattern test"
curl -i "$TARGET_URL/?id=1%20OR%201=1" || true

echo "Inspect logs to confirm blocking behavior."
