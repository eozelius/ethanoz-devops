#################################################
# List Letsencrypt certificate Info
#
# Starts a docker container with mapped volumes
# to print location, expiration & domains of certs.
#
# Example:
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# Found the following certs:
#   Certificate Name: ethanoz.com
#     Domains: minesweeper.ethanoz.com ethanoz.com
#     Expiry Date: 2020-08-15 21:45:23+00:00 (VALID: 89 days)
#     Certificate Path: /etc/letsencrypt/live/ethanoz.com/fullchain.pem
#     Private Key Path: /etc/letsencrypt/live/ethanoz.com/privkey.pem
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
#
#################################################

docker run --rm -it --name certbot \
-v /docker-volumes/etc/letsencrypt:/etc/letsencrypt \
-v /docker-volumes/var/lib/letsencrypt:/var/lib/letsencrypt \
-v /docker/letsencrypt-docker-nginx/src/letsencrypt/letsencrypt-site:/data/letsencrypt \
certbot/certbot \
certificates