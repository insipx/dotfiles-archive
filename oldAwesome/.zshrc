# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
setopt appendhistory autocd beep extendedglob nomatch notify
bindkey -v
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/insidious/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall

#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

archey3

alias ls='ls --color=auto'
alias du='cdu -idh'
alias df='dfc -idh'
