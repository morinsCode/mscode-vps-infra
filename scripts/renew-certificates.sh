#!/usr/bin/env bash

set -euo pipefail

cd /home/moe/projects/mscode-vps-infra

/usr/bin/docker compose run --rm certbot renew --quiet

/usr/bin/docker exec morinscode-reverse-proxy nginx -s reload
