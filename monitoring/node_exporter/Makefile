# This script installs prometheus node_exporter: https://github.com/prometheus/node_exporter
# as a systemd service on the node. By default it is configured to listen on localhost.

install_dir = /usr/local/bin

ver = "1.0.1"
pkg = "node_exporter-$(ver).linux-amd64"
tar_file = $(pkg).tar.gz


.PHONY: user
user:
	@useradd -rs /bin/false node_exporter || true 


node_exporter:
	curl -LO "https://github.com/prometheus/node_exporter/releases/download/v$(ver)/$(tar_file)"
	@tar -xvf $(tar_file)
	@cp $(pkg)/node_exporter .


.PHONY: install
install: user node_exporter
	@install -o node_exporter -g node_exporter $(pkg)/node_exporter $(install_dir)


.PHONY: install-systemd
install-systemd: install
	@install -m 0644 node_exporter.service /etc/systemd/system/
	@systemctl daemon-reload
	@systemctl enable node_exporter
	@systemctl start node_exporter
	@systemctl status node_exporter


.PHONY: clean
clean:
	@rm -rf node_exporter $(pkg) $(tar_file)
