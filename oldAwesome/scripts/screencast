#!/bin/bash
#
# Author:       Twily                                                               2014 - 2015
# Description:  Records a window or the desktop and converts the video to webm format.
# Requires:     ffmpeg, xwininfo, libnotify, keybind (C-A-x) in your WM to "pkill -f 'x11grab'"
# Usage:        $ sh screencast -h|--help
#
# Make GIFs:    http://pastebin.com/ReNXZdGV

WINDOW=false                    # Set recording mode to "window"
MARGIN=`expr 24 + 0`            # Margin in window mode (px) (+ 0 for border)
TITLEBAR=0                      # Titlebar height in window mode (px)
FPS=30                          # Frames Per Second [12-60]
PRESET="ultrafast"              # Default "ultrafast" (x264 --help for preset list)
CRF=10                          # Constant Rate Factor [0-51] (Lower is better quality)
QMAX=10                         # Maximum Quantization [1-31] (Lower is better quality)
FULLSCREEN="1920x1080"          # Set your desktop resolution
#DISPLAY=:0.1                    # Set to record specific monitor 0.0 or 0.1?
DELAY=2                         # Delay before recording begins (seconds)
SOUND=false                     # Record with sound (Requires ALSA Loopback device); see http://pastebin.com/qXWFS81k
LOOPBACK="1,1"                  # Set loopback device
HELP=false
ERROR=0

OUTPUT="/home/guest/out.webm"
TMP="/home/guest/out.mkv"
KEEP=false                      # Keep original mkv file after conversion

OPTS=`getopt -o hwm:t:o:f:c:p:q:ksd: --long help,window,margin:,title:,output:,fps:,crf:,preset:,qmax:,keep,sound,delay: -- "$@"`
eval set -- "$OPTS"

while true; do
    case "$1" in
        -w|--window) WINDOW=true;   shift 1;;   -m|--margin) MARGIN="$2";  shift 2;;
        -o|--output) OUTPUT="$2";   shift 2;;   -p|--preset) PRESET="$2";  shift 2;;
        -f|--fps)    FPS="$2";      shift 2;;   -c|--crf)    CRF="$2";     shift 2;;
        -q|--qmax)   QMAX="$2";     shift 2;;   -k|--keep)   KEEP=true;    shift 1;;
        -t|--title)  TITLEBAR="$2"  shift 2;;   -s|--sound)  SOUND=true;   shift 1;;
        -h|--help)   HELP=true;     shift 1;;   -d|--delay)  DELAY="$2";   shift 2;;
        --)          shift; break;;             *)           echo "Internal error!"; exit 1
    esac
done

if $HELP; then
    echo -e "Useage: $ sh ./screencast [OPTIONS]\n"
    echo "  -h|--help               Display this help"
    echo "  -w|--window             Set recording mode to \"wwindow\""
    echo "  -m|--margin 24          Set margin in window mode (px)"
    echo "  -t|--title 24           Set titlebar height in window mode (px)"
    echo "  -f|--fps 30             Set Frames Per Second [12-60]"
    echo "  -c|--crf 10             Set Constant Rate Factor [0-51] (Lower is better quality)"
    echo "  -q|--qmax 10            Set Maximum Quantization [1-31] (Lower is better quality)"
    echo "  -p|--preset ultrafast   Set preset (x264 --help for preset list)"
    echo "  -k|--keep               Keep original mkv file after conversion "
    echo "  -s|--sound              Record with sound (Requires ALSA Loopback device); see http://pastebin.com/qXWFS81k"
    echo "  -d|--delay              Delay before recording begins (seconds)"
    echo "  -o|--output file.webm   Output webm file"
    echo ""
    exit 0
fi

if $WINDOW; then
    WINFO=$(xwininfo)
    WINX=$(($(echo $WINFO|grep -Po 'Absolute upper-left X: \K[^ ]*')-$MARGIN))
    WINY=$(($(echo $WINFO|grep -Po 'Absolute upper-left Y: \K[^ ]*')-$MARGIN-$TITLEBAR))
    WINW=$(($(echo $WINFO|grep -Po 'Width: \K[^ ]*')+($MARGIN*2)))
    WINH=$(($(echo $WINFO|grep -Po 'Height: \K[^ ]*')+($MARGIN*2+$TITLEBAR)))

    echo -n "Recording begins in "
    while [ "$DELAY" -gt 0 ]; do
        echo -n $DELAY".."
        let DELAY=$DELAY-1
        sleep 1
    done
    notify-send "Window is now being recorded.\nStop by pressing Ctrl+Alt+X."

    # Record Window
    if $SOUND; then
        ffmpeg -f alsa -ac 2 -i hw:$LOOPBACK -f x11grab -s "$WINW"x"$WINH" -r $FPS -i $DISPLAY"+$WINX,$WINY" -c:v libx264 -preset $PRESET -crf $CRF -y "$TMP" #|| ERROR=1
    else
        ffmpeg -f x11grab -s "$WINW"x"$WINH" -r $FPS -i $DISPLAY"+$WINX,$WINY" -c:v libx264 -preset $PRESET -crf $CRF -y "$TMP" #|| ERROR=1
    fi
else
    echo -n "Recording begins in "
    while [ "$DELAY" -gt 0 ]; do
        echo -n $DELAY".."
        let DELAY=$DELAY-1
        sleep 1
    done
    notify-send "Desktop is now being recorded.\nStop by pressing Ctrl+Alt+X."

    # Record Fullscreen
    if $SOUND; then
        ffmpeg -f alsa -ac 2 -i hw:$LOOPBACK -f x11grab -s $FULLSCREEN -r $FPS -i $DISPLAY -c:v libx264 -preset $PRESET -crf $CRF -y "$TMP" #|| ERROR=1
    else
        ffmpeg -f x11grab -s $FULLSCREEN -r $FPS -i $DISPLAY -c:v libx264 -preset $PRESET -crf $CRF -y "$TMP" #|| ERROR=1
    fi
fi
notify-send "Desktop is no longer being recorded.\nVideo is now being converted to webm."

# Convert Video: mkv -> webm
# ffmpeg -i out.mkv -c:v libvpx -qmin 1 -qmax 10 -preset ultrafast -c:a libvorbis out.webm
if $SOUND; then
    diff="0.6" # Cut off X seconds from the end of the webm (Workaround to recording w/ sound)
    duration=$(ffprobe -loglevel quiet -of compact=p=0:nk=1 -show_entries format=duration -i "$TMP")
    durationDiff=$(echo "$duration-$diff"|bc -l)

    ffmpeg -i "$TMP" -t $durationDiff -c:v libvpx -qmin 1 -qmax $QMAX -preset $PRESET -c:a libvorbis "$OUTPUT" || ERROR=1
else
    ffmpeg -i "$TMP" -c:v libvpx -qmin 1 -qmax $QMAX -preset $PRESET -c:a libvorbis "$OUTPUT" || ERROR=1
fi

# MKV -> WEBM conversion by Ushibro
#ffmpeg -y -i "$TMP" -c:v libvpx -qmin 1 -qmax $QMAX -an -threads 4 -slices 8 -auto-alt-ref 1 -lag-in-frames 16 -pass 1 -f webm /dev/null || ERROR=1
#ffmpeg -i "$TMP" -c:v libvpx -qmin 1 -qmax $QMAX -an -threads 4 -slices 8 -auto-alt-ref 1 -lag-in-frames 16 -pass 2 "$OUTPUT" || ERROR=1
#rm ffmpeg2pass*.log

if [ "$ERROR" -eq 0 ]; then
    if [[ -f "$TMP" && "$KEEP" = false ]]; then rm -f "$TMP"; fi

    echo -e "\n\n\033[0;32mRecording and Converting has finished and"\
        "\"\033[0;34m$OUTPUT\033[0;32m\" has been \033[1;32mSuccessfully created\033[0;32m.\033[0m\n\n";

    notify-send "Video was successfully converted to webm!\n\"$OUTPUT\"."
    exit 0
else
    echo -e "\n\n\033[0;31mAn unexpected Error prevented the screen recorder to complete,"\
        "screencast was \033[1;31mNot converted\033[0;31m.\033[1;30m\n(Attempting to keep all data recorded in \"$TMP\")\033[0m\n\n";

    notify-send "An unexpected error prevented the video conversion to complete."
    exit 1
fi
