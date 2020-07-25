#!/bin/sh
set -ue

BASE_URL="https://raw.githubusercontent.com/nchern/devops/master/acme-certs"

for name in acme-update-certs init-acme.sh start-certs.sh web-server-restart
do
    curl -o "$BASE_URL/$name"
    chmod +x $name
done

cp acme-update-certs /usr/local/bin/acme-update-certs

./init-acme.sh
