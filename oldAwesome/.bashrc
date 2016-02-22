#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

archey3

alias ls='ls --color=auto'
alias du='cdu -idh'
alias df='dfc -idh'
PS1='[\u@\h \W]\$ '
