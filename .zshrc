#Completion
zstyle ':completion:*' completer _expand _complete _ignored
zstyle ':completion:*' matcher-list 'm:{[:lower:]}={[:upper:]}'
zstyle :compinstall filename '/home/foster/.zshrc'

autoload -Uz compinit promptinit
compinit
promptinit

#Theme
prompt gentoo

#History
HISTFILE=~/.histfile
HISTSIZE=100
SAVEHIST=10000
setopt appendhistory

#Options
setopt beep extendedglob

#Vim compatibility
bindkey -v
bindkey "^?" vi-backward-delete-char

#Special keys (Home, End, Insert, Delete, PageUp, PageDown)
[[ -n "${terminfo[khome]}" ]]  && bindkey  "${terminfo[khome]}" vi-beginning-of-line
[[ -n "${terminfo[kend]}"  ]]  && bindkey  "${terminfo[kend]}"  vi-end-of-line
[[ -n "${terminfo[kich1]}" ]]  && bindkey  "${terminfo[kich1]}" vi-insert
[[ -n "${terminfo[kdch1]}" ]]  && bindkey  "${terminfo[kdch1]}" vi-delete-char
[[ -n "${terminfo[kpp]}"   ]]  && bindkey  "${terminfo[kpp]}"   up-history
[[ -n "${terminfo[knp]}"   ]]  && bindkey  "${terminfo[knp]}"   down-history
