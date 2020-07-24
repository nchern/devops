#!/bin/sh
set -ue

function password {
    openssl rand -base64 24
}


apt-get -y update && 
    apt-get -y install  \
        fail2ban        \
        nvim            \
        git             \
        screen          \
        docker.io       \
        make            \
        htop            \
        openssl

docker_compose_path="/usr/local/bin/docker-compose"
curl -L "https://github.com/docker/compose/releases/download/1.24.0/docker-compose-$(uname -s)-$(uname -m)" -o $docker_compose_path
chmod +x $docker_compose_path

# echo -n "Enter host name and press [ENTER]: "
# read host_name

# set root password
root_passwd=$(password)
echo "Root password: $root_passwd"


# TODO create sudoer

# TODO remove ssh root / password logins
sshd_config="/etc/ssh/sshd_config"

echo "Checkout https://drewdevault.com/new-server.html"
