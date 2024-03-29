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

printf '\n'
printf 'Copying common files...\n'

rsync -avv common/ "$HOME"/

printf '\n'
printf 'Copying OS-specific files...\n'

if [ "$os" != "unknown" ] && [ -d "$os" ]; then
	rsync -avv "$os"/ "$HOME"/
fi

printf '\n'
printf 'Bootstrapping Neovim...'

if [ ! -e "$HOME"/.local/share/nvim/site/autoload/plug.vim ]; then
	printf '\n'
	mkdir -p "$HOME"/.local/share/nvim/plugged
	git clone https://github.com/junegunn/vim-plug.git "$HOME"/.local/share/nvim/plugged/vim-plug

	mkdir -p "$HOME"/.local/share/nvim/site/autoload
	ln -s ../../plugged/vim-plug/plug.vim "$HOME"/.local/share/nvim/site/autoload/plug.vim
else
	printf 'skipped\n'
fi

printf '\n'
printf 'Updating Neovim plugins...\n'

nvim --headless -c ':PlugUpdate | qall' >/dev/null
nvim --headless -c ':lua local server_mapping = require "mason-lspconfig.mappings.server" local lsp_packages = {} for _, server in pairs(vim.g.lsp_servers) do print(server) table.insert(lsp_packages, server_mapping.lspconfig_to_package[server]) end print(table.concat(lsp_packages, " ")) vim.api.nvim_command("MasonInstall " .. table.concat(lsp_packages, " ")) vim.api.nvim_command("qall")' >/dev/null

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
elif [ "$os" = 'android' ]; then
	printf 'skipped\n'
fi

printf '\n'
printf 'Done\n'
