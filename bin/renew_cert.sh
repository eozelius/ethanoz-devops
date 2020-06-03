#!/bin/bash
#################################################
# Renew Letsencrypt Certificate
#
# Generate or renew a Letsencrypt Certificate
# For more info:
# https://www.humankode.com/ssl/how-to-set-up-free-ssl-certificates-from-lets-encrypt-using-docker-and-nginx
#
#################################################

input="../.email"
while IFS= read -r line
do
  EMAIL="$line"
done < "$input"

echo "email: $EMAIL"

docker run -it --rm \
-v /docker-volumes/etc/letsencrypt:/etc/letsencrypt \
-v /docker-volumes/var/lib/letsencrypt:/var/lib/letsencrypt \
-v /docker/letsencrypt-docker-nginx/src/letsencrypt/letsencrypt-site:/data/letsencrypt \
-v "/docker-volumes/var/log/letsencrypt:/var/log/letsencrypt" \
certbot/certbot \
certonly --webroot \
--email "$EMAIL" --agree-tos --no-eff-email \
--webroot-path=/data/letsencrypt \
-d ethanoz.com \
-d minesweeper.ethanoz.com \
-d weather.ethanoz.com
