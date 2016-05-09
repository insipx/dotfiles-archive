#!/bin/sh

# Goes through all jpeg files in current directory, grabs date from each
# and sorts them into subdirectories according to the date
# Creates subdirectories corresponding to the dates as necessary.

for fil in *.png  # Also try *.JPG
do
	    datepath="$(identify -verbose $fil | grep DateTimeOri | awk '{print $2 }' | sed s%:%/%g)"
	        if ! test -e "$datepath"; then
			        mkdir -pv "$datepath"
				    fi

				        mv -v $fil $datepath
				done
