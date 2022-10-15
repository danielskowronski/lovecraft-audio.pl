# https://lovecraft-audio.pl hugo

## run server - with drafts
```bash
hugo server -D # --bind=192.168.255.200 --baseURL=http://192.168.255.200
```

## build and deploy - without drafts
```bash
bash deploy.sh
```

## searches

new releases: https://www.youtube.com/results?search_query=lovecraft&sp=CAI%253D

youtube links with too many params:
```bash
yq -N '.audiobooks[].link' `find content/story -type f` | egrep '\?v\=.{11}\&'
```

inactive links:
```bash
./check_inactive_links.sh
```

channel count:
```bash
yq -N '.audiobooks[].channel' `find content/story -type f` | sort | uniq -c | sort -rn
```
