#!/usr/bin/env bash
# pomf.se uploader
# requires: curl

dest_url='http://pomf.sinister.ly/upload.php'
return_url='http://pomf.sinister.ly'

if [[ -n "${1}" ]]; then
	file="${1}"
	if [ -f "${file}" ]; then
		printf "Uploading ${file}...\n"
		my_output=$(curl --silent -sf -F files[]="@${file}" "${dest_url}")
		n=0  # Multipe tries
		while [[ $n -le 3 ]]; do
			printf "try #${n}..."
			if [[ "${my_output}" =~ '"success":true,' ]]; then
				return_file=$(echo "$my_output" | grep -Eo '"url":"[A-Za-z0-9]+.png",' | sed 's/"url":"//;s/",//')
				printf 'done.\n'
				break
			else
				printf 'failed.\n'
				((n = n +1))
			fi
		done
		if [[ -n ${return_file} ]]; then
			printf "File can be found at: ${return_url}/${return_file}.\n"
		else
			printf 'Error! File not uploaded.\n'
		fi
	else
		printf 'Error! File does not exist!\n'
		exit 1
	fi
else
	printf 'Error! You must supply a filename to upload!\n'
	exit 1
fi
