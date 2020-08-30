#!/bin/sh -e
cd "$(dirname "$0")"

if grep -qi 'Microsoft\|WSL' /proc/version >/dev/null 2>/dev/null; then
	os="wsl"
elif uname -s | grep -qi 'Darwin' >/dev/null 2>/dev/null; then
	os="macos"
elif uname -s | grep -qi 'Linux' >/dev/null 2>/dev/null; then
	os="linux"
else
	os="unknown"
fi

echo "Detected OS: $os"

rsync -avv common/ "$HOME"/

if [ "$os" = "linux" ]; then
	mkdir -p "$HOME"/.backgrounds
	rsync -avv backgrounds/ "$HOME"/.backgrounds/
elif [ "$os" = "macos" ]; then
	mkdir -p "$HOME"/Pictures/Backgrounds
	rsync -avv backgrounds/1080/ "$HOME"/Pictures/Backgrounds
elif [ "$os" = "wsl" ]; then
	true
fi
