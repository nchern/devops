#!/bin/sh
set -ue

TARGET="$1"

echo -n "Enter email address to be notified upon login [ENTER]: "
read -r EMAIL

sed -i s"/%EMAIL%/$EMAIL/g" "$TARGET"

echo "session optional pam_exec.so seteuid $TARGET" >> /etc/pam.d/sshd
