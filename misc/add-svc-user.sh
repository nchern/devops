#!/bin/sh
set -ue

# Help: creates a system user account on different systems

NAME="$1"
COMMENT="service user"

mk_user_alpine() {
    addgroup -S "$NAME" # alpine assigns system users to nogroup
    # System, password disabled, no home dir
    adduser -g "$COMMENT" -S -D -H -G "$NAME" "$NAME"
}


if uname -a | grep -i -q alpine ; then
    mk_user_alpine
    exit
fi

# Debian / Ubuntu - works 100%

useradd -r -s /bin/false -c "$COMMENT" "$NAME"
