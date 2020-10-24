#!/bin/sh
set -ue

# This script installs prometheus node_exporter(https://github.com/prometheus/node_exporter) as a systemd service
# on the node. By default it is configured to listen on localhost.

NODE_EXPORTER="node_exporter-1.0.1.linux-amd64"

INSTALL_DIR="/usr/local/bin"

curl -LO https://github.com/prometheus/node_exporter/releases/download/v1.0.1/${NODE_EXPORTER}.tar.gz 
tar -xvf $NODE_EXPORTER.tar.gz 

useradd -rs /bin/false node_exporter || true 

mv $NODE_EXPORTER/node_exporter $INSTALL_DIR/ && chown node_exporter:node_exporter $INSTALL_DIR/node_exporter 

cat > /etc/systemd/system/node_exporter.service << EOF
[Unit]
Description=Node Exporter
After=network.target

[Service]
User=node_exporter
Group=node_exporter
Type=simple
Restart=on-failure
ExecStart=/usr/local/bin/node_exporter --web.listen-address="localhost:9100"

[Install]
WantedBy=multi-user.target
EOF

systemctl daemon-reload
systemctl start node_exporter
systemctl status node_exporter
systemctl enable node_exporter
