#!/bin/sh
set -ue

CONF_FILE="users.conf"

grep -vE '(^#|^\s*$)' "$CONF_FILE" | while read -r line; do
    _LOGIN=$(echo "$line" | awk '{print $1}')
    _UID=$(echo "$line" | awk '{print $2}')
    _GID=$(echo "$line" | awk '{print $3}')

    addgroup -g "$_GID" "$_LOGIN"
    adduser -u "$_UID" -G "$_LOGIN" -H -D "$_LOGIN"
done
