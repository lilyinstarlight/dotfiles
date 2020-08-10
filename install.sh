#!/bin/sh -e
if uname -s | grep -qi 'Linux' &>/dev/null; then
	os="linux"
elif uname -s | grep -qi 'Darwin' &>/dev/null; then
	os="macos"
elif grep -qi 'Microsoft\|WSL' /proc/version &>/dev/null; then
	os="wsl"
else
	os="common"
fi

# TODO: commmon overlay

if [ "$os" == "linux" ]; then
fi
