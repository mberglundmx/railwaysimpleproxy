#!/bin/sh
set -e

apt update && apt install -y simpleproxy dnsutils

echo "🔍 Resolving target host..."
IPV6_ADDR=$(getent ahosts "$TARGET_HOST" | awk '/STREAM/ { print $1; exit }')

if [ -z "$IPV6_ADDR" ]; then
  echo "❌ Failed to resolve $TARGET_HOST to IPv6"
  exit 1
fi

echo "✅ Resolved $TARGET_HOST to $IPV6_ADDR"
echo "➡️  Starting proxy on port $PROXY_PORT to [$IPV6_ADDR]:$TARGET_PORT"

simpleproxy -v -L "$PROXY_PORT" -R "[$IPV6_ADDR]:$TARGET_PORT"
