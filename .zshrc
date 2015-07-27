autoload -Uz compinit promptinit up-line-or-beginning-search down-line-or-beginning-search

# completion
compinit
zstyle ':completion:*' completer _expand _complete _ignored
zstyle ':completion:*' matcher-list 'm:{[:lower:]}={[:upper:]}'
zstyle :compinstall filename '/home/foster/.zshrc'

# theme
promptinit
prompt gentoo

# history
HISTFILE=~/.histfile
HISTSIZE=10000
SAVEHIST=10000
setopt inc_append_history
setopt hist_find_no_dups

# options
setopt beep extendedglob

# vim compatibility
bindkey -v
bindkey "^?" vi-backward-delete-char

# arrow keys search through history
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search
bindkey "\e[A" up-line-or-beginning-search
bindkey "\e[B" down-line-or-beginning-search
bindkey -a "k" up-line-or-beginning-search
bindkey -a "j" down-line-or-beginning-search

# special keys (Home, End, Insert, Delete, PageUp, PageDown)
[[ -n "${terminfo[khome]}" ]] && bindkey "${terminfo[khome]}" vi-beginning-of-line
[[ -n "${terminfo[kend]}"  ]] && bindkey "${terminfo[kend]}"  vi-end-of-line
[[ -n "${terminfo[kich1]}" ]] && bindkey "${terminfo[kich1]}" vi-insert
[[ -n "${terminfo[kdch1]}" ]] && bindkey "${terminfo[kdch1]}" vi-delete-char
[[ -n "${terminfo[kpp]}"   ]] && bindkey "${terminfo[kpp]}"   up-history
[[ -n "${terminfo[knp]}"   ]] && bindkey "${terminfo[knp]}"   down-history

# start environment depending on vt
if [[ -z "$XDG_SESSION_DESKTOP" ]]; then
	case $XDG_VTNR in
		1)
			export XDG_SESSION_DESKTOP="qtile"
			exec startx
			;;

		2)
			export XDG_SESSION_DESKTOP="bspwm"
			exec startx
			;;

		3)
			export XDG_SESSION_DESKTOP="steam"
			exec startx
			;;
		4)
			;&
		5)
			;&
		6)
			export XDG_SESSION_DESKTOP="systemd-console"
			;;
	esac
fi
