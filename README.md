# https://lovecraft-audio.pl - indeks audiobooków z opowiadaniami H.P. Lovecrafta

## searches

new releases:
https://www.youtube.com/results?search_query=lovecraft&sp=CAI%253D

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
yq -N '.audiobooks[].channel' `find ./web/content/story -type f` | sort | uniq -c | sort -rn
```
