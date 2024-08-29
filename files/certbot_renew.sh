#!/bin/bash

# Stopping nginx container if running
docker ps -q --filter "name=nginx" | grep -q . && docker stop nginx || true

# Performing force renewal of TLS certificates using certbot
docker run -it --rm --name certbot \
  -v "/etc/letsencrypt:/etc/letsencrypt" \
  -v "/var/lib/letsencrypt:/var/lib/letsencrypt" \
  -v "/var/log/letsencrypt:/var/log/letsencrypt" \
  -p 80:80 \
  certbot/certbot renew --standalone --non-interactive --quiet --force-renewal

# Starting nginx container if exists
docker ps -a --filter "name=nginx" | grep -q . && docker start nginx || true