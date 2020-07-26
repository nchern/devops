#!/bin/sh
set -ue

CHALLENGE_CONTAINER="nginx-acme"

echo -n "Enter your domain name and press [ENTER]: "
read DOMAIN

# TODO: get domain value
sed -i s"/DOMAIN/$DOMAIN/g" acme-update-certs
sed -i s"/DOMAIN/$DOMAIN/g" nginx/default.conf
sed -i s"/DOMAIN/$DOMAIN/g" nginx/ssl.conf

# TODO: mange with nginx - start for challenges
# port 80 must be free
#docker run -d --name $CHALLENGE_CONTAINER \
#    -p 80:80 \
#    -v $(pwd)/nginx/default.conf:/etc/nginx/conf.d/default.conf:ro \
#    -v /var/www/.well-known/acme-challenge:/var/www/.well-known/acme-challenge:ro \
#    nginx:1.19-alpine
# sleep 2  # HACK
# curl -f -I "http://localhost/ping/"

sudo -u acme /usr/local/bin/acme-update-certs

cat /var/log/acme.log # verify success

[[ -f /etc/ssl/uacme/$DOMAIN/cert.pem ]]        || echo "cert.pem is MISSING!"
[[ -f /etc/ssl/uacme/private/$DOMAIN/key.pem ]] || echo "key.pem is MISSING!"

# TODO: mangle with nginx
# docker rm -f $CHALLENGE_CONTAINER

chmod -R g+rX /etc/ssl/uacme /etc/ssl/uacme/private

# /usr/local/bin/web-server-restart

(sudo -u acme crontab -l 2>/dev/null; echo "0 0 * * * chronic /usr/local/bin/acme-update-certs") | sudo -u acme crontab -

echo "Verify website has working SSL: curl -I https://$DOMAIN"
echo "Example web server configuration(nginx based):"
cat nginx/ssl.conf
