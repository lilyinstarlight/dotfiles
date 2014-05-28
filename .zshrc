zstyle ':completion:*' completer _expand _complete _ignored
zstyle ':completion:*' matcher-list 'm:{[:lower:]}={[:upper:]}'
zstyle :compinstall filename '/home/foster/.zshrc'

autoload -Uz compinit promptinit
compinit
promptinit

prompt gentoo

HISTFILE=~/.histfile
HISTSIZE=100
SAVEHIST=10000
setopt appendhistory beep extendedglob
