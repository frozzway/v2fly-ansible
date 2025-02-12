#!/bin/bash

# Stopping nginx container if running
if [ "$(docker ps -q --filter "name=nginx")" ]; then
    docker stop nginx
fi

# Performing force renewal of TLS certificates using certbot
docker run --rm --name certbot \
  -v "/etc/letsencrypt:/etc/letsencrypt" \
  -v "/var/lib/letsencrypt:/var/lib/letsencrypt" \
  -v "/var/log/letsencrypt:/var/log/letsencrypt" \
  -p 80:80 \
  certbot/certbot renew --standalone --non-interactive --quiet --force-renewal

# Stopping nginx container if running
if [ "$(docker ps -q --filter "name=nginx")" ]; then
    docker start nginx
fi

# Restarting v2fly container if running
if [ "$(docker ps -q --filter "name=v2fly")" ]; then
    docker restart v2fly
fi

date
