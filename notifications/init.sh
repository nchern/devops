#!/bin/sh
set -ue

NOTIFY="pam-login-notify.sh"
BIN_DIR="/usr/local/bin"

echo -n "Enter email address to be notified upon login [ENTER]: "
read -r EMAIL

cp $NOTIFY "$BIN_DIR/$NOTIFY"
sed -i s"/%EMAIL%/$EMAIL/g" "$BIN_DIR/$NOTIFY"

echo "session optional pam_exec.so seteuid $BIN_DIR/$NOTIFY" >> /etc/pam.d/sshd
