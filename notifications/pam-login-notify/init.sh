#!/bin/sh
set -ue

BIN_DIR="/usr/local/bin"
NOTIFY="pam-login-notify.sh"
TARGET="$BIN_DIR/$NOTIFY"

echo -n "Enter email address to be notified upon login [ENTER]: "
read -r EMAIL

install -c "$NOTIFY" "$BIN_DIR/"

chown root:root "$TARGET"

sed -i s"/%EMAIL%/$EMAIL/g" "$TARGET"

echo "session optional pam_exec.so seteuid $BIN_DIR/$NOTIFY" >> /etc/pam.d/sshd
