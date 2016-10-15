#! /bin/bash

xrdb -load ~/.Xresources & 
compton --config ~/.config/compton.conf &
nm-applet &
exec i3

