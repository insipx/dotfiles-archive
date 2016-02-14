#! /bin/bash
xrandr --setprovideroutputsource 1 0
sleep 2
xrandr --output DVI-1-0 --mode 1920x1080
xrandr --output eDP1 --left-of DVI-1-0

xrandr --output DVI-I-1 --mode 1920x1080
xrandr --output eDP1 --left-of DVI-I-1

