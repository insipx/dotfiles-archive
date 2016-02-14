#!/bin/bash

	xrandr --newmode "1920x1080_59.00" 169.00 1920 2040 2240 2560 1080 1083 1088 1120 -hsync +vsync
	xrandr --addmode eDP1 "1920x1080_59.00"
	xrandr --output eDP1 --mode "1920x1080_59.00"
