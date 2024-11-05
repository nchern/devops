# Installs cpu-mon as a systemd service

user = daemon
service = cpu-mon


.PHONY: install
install:
	@install cpu-mon -m 0755 -o root -g root /usr/local/bin/


.PHONY: install-systemd
install-systemd: install
	@install -m 0644 $(service).service /etc/systemd/system/
	@systemctl daemon-reload
	@systemctl enable $(service)
	@systemctl start $(service)
	@systemctl status $(service)
