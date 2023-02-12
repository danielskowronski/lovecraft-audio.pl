#!/bin/bash

DATE=$(date +"%Y-%m-%d %H:%M:%S")
python3 -m pip install youtube_dl

report_channel_stats () {
	find content/story/ -type f -exec \
		yq --front-matter="extract" \
			'.audiobooks' \
		{} \+ \
		| yq -N '.| select(.|length!=0)' \
		| yq 'map({"channel": .channel}) | group_by(.channel) | map({"channel": .[0].channel, "count": length}) | .[] style="flow"' \
		| yq -r 'sort_by(.count)|reverse|.[]|"- **"+(.channel)+"**: "+(.count)+""';
}

report_inactive_links () {
	return 
	CNT=0
	for file in `find content/story -type f`; do
		for link in `yq '.audiobooks[].link' $file`; do
			youtube-dl $link -e > /dev/null 2>&1
			if [[ ${PIPESTATUS[0]} -eq 0 ]]; then
				true
			else
				echo "- \`${file}\` -> [${link}](${link})"
				CNT=$((CNT+1))
			fi
		done
	done

	if [[ $CNT -eq 0 ]]; then
		echo "N/A"
	fi
}

report_incorrect_links () {
	find content/story/ -type f -exec \
		yq --front-matter="extract" \
			'[{"title": .title, "link": .audiobooks[].link}]' \
		{} \+ \
		| yq -N '.| select(.|length!=0)' \
		| yq '.[] | select(.link != "https://www.youtube.com/watch?v=B8XPqsIGU_A&list=PLoyx3oE3BCfMnycgN4vAdNKSUaVpSsR93")' \
		| yq '. | select(.link|match("\?v\=.{11}\&")) | "- **"+(.title)+"**: ["+(.link)+"]("+(.link)+")"' \
		| yq '. |= with(select(.|length == 0); . = "N/A") '
}

report_releases () {
	find content/story/ -type f -exec \
		yq --front-matter="extract" \
			'{"title": .title, "titles_pl": .titles_pl, "links": .audiobooks} | [.]' \
	{} \; \
	| yq '.[] | select(.title != null and .links|length != 0) | [.]';
}

report () {
	echo "# REPORT ${DATE}"
	echo
	echo "## Channels stats"
	echo 
	report_channel_stats
	echo 
	echo "## Inactive links"
	echo
	report_inactive_links
	echo
	echo "## Incorrect links"
	echo
	report_incorrect_links
	echo 
	echo "## Releases"
	echo 
	echo "\`\`\`yaml"
	report_releases
	echo "\`\`\`"
}

report > REPORT.md
