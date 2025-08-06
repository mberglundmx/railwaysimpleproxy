#!/bin/sh
set -e

echo "Updating packages..."
apt update

echo "Installing simpleproxy..."
apt install -y simpleproxy dnsutils net-tools

echo "🔍 DNS lookup with dig:"
dig "$TARGET_HOST" || echo "dig failed"

echo "🔍 DNS lookup with getent:"
getent hosts "$TARGET_HOST" || echo "getent failed"

echo "Starting simpleproxy on port $PROXY_PORT forwarding to minecraft-server:$TARGET_PORT"
simpleproxy -v -L "$PROXY_PORT" -R minecraft-server:$TARGET_PORT
