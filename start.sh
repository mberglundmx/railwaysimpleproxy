#!/bin/sh
set -e

echo "Updating packages..."
apt update

echo "Installing simpleproxy..."
apt install -y simpleproxy

echo "Starting simpleproxy on port $PROXY_PORT forwarding to $TARGET_HOST:$TARGET_PORT"
simpleproxy -v -L "$PROXY_PORT" -R minecraft-server:$TARGET_PORT
