#!/bin/sh -e
if grep -qi 'Microsoft\|WSL' /proc/version &>/dev/null; then
	os="wsl"
elif uname -s | grep -qi 'Darwin' &>/dev/null; then
	os="macos"
elif uname -s | grep -qi 'Linux' &>/dev/null; then
	os="linux"
else
	os="unknown"
fi

echo "Detected OS: $os"

rsync -avv common/ "$HOME"/

if [ "$os" == "linux" ]; then
	true
fi
