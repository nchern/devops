#!/bin/sh
set -ue

WEB_CONFIG="default.conf"

# MANUAL
vim web-server-restart
cp web-server-restart /usr/local/bin/

# MANUAL: Update nginx configuration (ssl_certificate{,_key} commented)
read -p "Comment out ssl_certificate on your web server [ENTER]"
vim $WEB_CONFIG

sudo -u acme /usr/local/bin/acme-update-certs

cat /var/log/acme.log # verify success

# MANUAL: Update nginx configuration
read -p "Enable SSL on your web server [ENTER]"
vim $WEB_CONFIG

chmod -R g+rX /etc/ssl/uacme /etc/ssl/uacme/private

/usr/local/bin/web-server-restart

(sudo -u acme crontab -l 2>/dev/null; echo "0 0 * * * chronic /usr/local/bin/acme-update-certs") | sudo -u acme crontab -

echo "Verify website has working SSL: curl -I https://DOMAIN"
