#!/bin/sh
set -ue

CERT_EMAIL=""  # optional email to register certs with

apt-get install -y uacme moreutils

useradd -md /var/lib/acme -s /sbin/nologin acme

mkdir -p /etc/ssl/uacme/private /var/www/.well-known/acme-challenge

chown acme:acme /etc/ssl/uacme /etc/ssl/uacme/private

chmod g+rX /etc/ssl/uacme /etc/ssl/uacme/private

chown acme:acme /var/www/.well-known/acme-challenge

touch /var/log/acme.log

chown acme:acme /var/log/acme.log

# TODO: let acme resrt web server
# doas usermod -aG acme nginx

# Register this node as acme client(email is optional)
sudo -u acme uacme new $CERT_EMAIL

# MANUAL
vim web-server-restart
cp web-server-restart /usr/local/bin/

chmod "u+s" /usr/local/bin/web-server-restart
