# Installs cpu-mon as a systemd service

user = daemon


.PHONY: install
install:
	@install cpu-mon -o $(user) -g $(user) /usr/local/bin/


.PHONY: install-systemd
install-systemd: install
	@install -m 0644 cpu-mon.service /etc/systemd/system/
	@systemctl daemon-reload
	@systemctl enable node_exporter
	@systemctl start node_exporter
	@systemctl status node_exporter
