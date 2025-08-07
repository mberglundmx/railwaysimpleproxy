#!/bin/sh
set -e

echo "🔧 Installing socat..."
apt update && apt install -y socat

while true; do
  echo "➡️  Starting proxy: TCP4-LISTEN:$PROXY_PORT -> $TARGET_HOST:$TARGET_PORT"
  socat TCP4-LISTEN:"$PROXY_PORT",fork,reuseaddr TCP6:$TARGET_HOST:"$TARGET_PORT"
  echo "socat exited. Restarting in 3 seconds..."
  sleep 3
done
