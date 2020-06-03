#################################################
# Generate DH key
# 
# more info on DH params: 
# https://security.stackexchange.com/questions/94390/whats-the-purpose-of-dh-parameters
#
#################################################

openssl dhparam -out /docker/letsencrypt-docker-nginx/src/production/dh-param/dhparam-2048.pem 2048
