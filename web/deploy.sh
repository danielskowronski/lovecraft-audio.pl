#!/bin/bash
hugo

# hugo deploy

# curl -X POST "https://api.cloudflare.com/client/v4/zones/273bc8069874627e50c5dd2298d150c4/purge_cache" \
#      -H "Authorization: Bearer ${CLOUDFLARE_API_TOKEN}" \
#      -H "Content-Type: application/json" \
#      --data '{"purge_everything":true}'
