#!/bin/bash
git show --summary | awk '$1=="commit"{print $2}' > last_commit_id.txt # workaround for https://github.com/gohugoio/hugo/issues/5533 - when fixed web/layouts/partials/custom/footer-text.html should use $.GitInfo.Hash and $.Page.Lastmod

hugo --minify

echo "post-deploy-stage" > last_commit_id.txt

rsync -avz --delete public/ root@10.0.1.1:/srv/lovecraft-audio.pl

curl -X POST "https://api.cloudflare.com/client/v4/zones/273bc8069874627e50c5dd2298d150c4/purge_cache" \
  -H "Authorization: Bearer ${CLOUDFLARE_API_TOKEN}" \
  -H "Content-Type: application/json" \
  --data '{"purge_everything":true}'
