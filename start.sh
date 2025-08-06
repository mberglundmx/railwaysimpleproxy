#!/bin/sh
set -e

echo "Updating packages..."
apt update

echo "Installing simpleproxy..."
apt install -y simpleproxy

echo "Starting simpleproxy on port $PROXY_PORT forwarding to minecraft-server:$TARGET_PORT"
simpleproxy -v -L "$PROXY_PORT" -R minecraft-server:$TARGET_PORT
