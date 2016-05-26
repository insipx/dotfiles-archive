
~/scripts/setResolution.sh
#~/scripts/startMusic.sh

pulseaudio &
megasync &
feh --bg-scale ~/.wallpaper.jpg &
compton --config ~/.config/compton.conf &

exec i3
