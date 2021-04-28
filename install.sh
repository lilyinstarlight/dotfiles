#!/bin/sh -e
cd "$(dirname "$0")"

if grep -qi 'Microsoft\|WSL' /proc/version >/dev/null 2>/dev/null; then
	os="wsl"
elif uname -s 2>/dev/null | grep -qi 'Darwin' >/dev/null 2>/dev/null; then
	os="macos"
elif uname -o 2>/dev/null | grep -qi 'Android' >/dev/null 2>/dev/null; then
	os="android"
elif uname -s 2>/dev/null | grep -qi 'Linux' >/dev/null 2>/dev/null; then
	os="linux"
else
	os="unknown"
fi

printf 'Detected OS: %s\n' "$os"

printf 'Copying common files...'

rsync -avv common/ "$HOME"/

printf '\n'
printf 'Copying backgrounds files...'

if [ "$os" = 'linux' ]; then
	printf '\n'
	mkdir -p "$HOME"/.backgrounds
	rsync -avv backgrounds/ "$HOME"/.backgrounds/
elif [ "$os" = 'macos' ]; then
	printf '\n'
	mkdir -p "$HOME"/Pictures/Backgrounds
	rsync -avv backgrounds/1080/ "$HOME"/Pictures/Backgrounds
elif [ "$os" = 'wsl' ]; then
	printf 'skipped\n'
	true
elif [ "$os" = 'android' ]; then
	printf 'skipped\n'
	true
fi

printf 'Done\n'
