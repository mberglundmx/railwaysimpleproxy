#!/bin/sh
set -e

echo "🔧 Installing socat..."
apt update && apt install -y socat dnsutils

echo "🔍 Resolving $TARGET_HOST..."
IPV6_ADDR=$(getent ahosts "$TARGET_HOST" | awk '/STREAM/ { print $1; exit }')

if [ -z "$IPV6_ADDR" ]; then
  echo "❌ Failed to resolve $TARGET_HOST"
  exit 1
fi

echo "✅ Resolved $TARGET_HOST to $IPV6_ADDR"
echo "➡️  Starting proxy: TCP4-LISTEN:$PROXY_PORT -> [$IPV6_ADDR]:$TARGET_PORT"

socat -v TCP4-LISTEN:"$PROXY_PORT",fork,reuseaddr TCP6:[$IPV6_ADDR]:"$TARGET_PORT"
