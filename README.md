# https://lovecraft-audio.pl - indeks audiobooków z opowiadaniami H.P. Lovecrafta

## searches

new releases:
https://www.youtube.com/results?search_query=lovecraft&sp=CAI%253D

youtube links with too many params:
```bash
yq -N '.audiobooks[].link' `find content/story -type f` | egrep '\?v\=.{11}\&'
```
