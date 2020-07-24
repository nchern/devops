#!/bin/sh
set -ue

password() {
    openssl rand -base64 24
}


apt-get -y update && 
    apt-get -y install  \
        fail2ban        \
        neovim          \
        git             \
        screen          \
        docker.io       \
        make            \
        htop            \
        openssl

docker_compose_path="/usr/local/bin/docker-compose"
curl -L "https://github.com/docker/compose/releases/download/1.24.0/docker-compose-$(uname -s)-$(uname -m)" -o $docker_compose_path
chmod +x $docker_compose_path

# set root password
root_passwd=$(password)
echo "Root password: $root_passwd" && echo "root:$root_passwd" | chpasswd  # ubuntu only

# Create sudoer admin
admin_user="watcher"
admin_user_ssh_dir="/home/$admin_user/.ssh/"
adduser --gecos "" --disabled-password $admin_user && usermod -aG sudo $admin_user
mkdir $admin_user_ssh_dir && cp ~/.ssh/authorized_keys $admin_user_ssh_dir && chown -R $admin_user:$admin_user $admin_user_ssh_dir

# tweak ssh accesses
sshd_config="/etc/ssh/sshd_config"

cp  $sshd_config $sshd_config.original

sed s'/#PermitEmpty/PermitEmpty/g' -i $sshd_config
sed s'/#PasswordAuthentication yes/PasswordAuthentication no/g' -i $sshd_config
sed s'/PermitRootLogin yes/PermitRootLogin no/g' -i $sshd_config

echo "Checkout https://drewdevault.com/new-server.html"
