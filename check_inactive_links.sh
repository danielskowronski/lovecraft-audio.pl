#!/bin/bash

python3 -m pip install youtube_dl

for file in `find ./web/content/story -type f`; do
	for link in `yq '.audiobooks[].link' $file`; do
		youtube-dl $link -e > /dev/null 2>&1
		if [[ ${PIPESTATUS[0]} -eq 0 ]]; then
			true
		else
			echo "${file} - ${link}"
		fi
	done
done
