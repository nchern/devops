#!/bin/sh
set -ue

CONF_FILE="users.conf"
GENERATED_FILE="add_users.generated.sh"

echo "#!/bin/sh" > "$GENERATED_FILE"
echo "set -ue" >> "$GENERATED_FILE"

grep -vE '(^#|^\s*$)' "$CONF_FILE" | while read -r _LOGIN; do
    _UID=$(id -u "$_LOGIN")
    _GID=$(id -g "$_LOGIN")

    echo "addgroup -g $_GID $_LOGIN" >> "$GENERATED_FILE"
    echo "adduser -u $_UID -G $_LOGIN -H -D $_LOGIN" >> "$GENERATED_FILE"
done
chmod +x "$GENERATED_FILE"
