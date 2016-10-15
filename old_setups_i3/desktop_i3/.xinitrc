#! /bin/bash

xrdb -load ~/.Xresources & 
compton --config ~/.config/compton.conf &
sh ~/scripts/setResolution.sh &
feh --bg-scale ~/Pictures/Wallpapers/who_we_were.jpg &
exec i3

