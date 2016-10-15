#! /bin/bash

xrdb -load ~/.Xresources & 
compton --config ~/.config/compton.conf &
sh ~/scripts/setResolution.sh &
unclutter -grab -idle 1 &
systemctl start dhcpcd &
sh ~/scripts/./lemonbuddy_launch.sh &
rmmod pcspkr &
exec i3

