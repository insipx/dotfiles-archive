#! /bin/bash

cd ~
mv .zsh_history .zsh_history_bad
strings .zsh_history_bad > .zsh_history

fc -R .zsh_history
