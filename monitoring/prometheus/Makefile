

.PHONY: install
install:
	mkdir -p /etc/prometheus/
	install -m 0644 prometheus.yml /etc/prometheus/
	install prometheus.sh /usr/local/bin/


.PHONY: install-systemd
install-systemd: install
	install -m 0644 prometheus.service /etc/systemd/system/
	systemctl daemon-reload
	systemctl enable prometheus 
	systemctl start prometheus 
	systemctl status prometheus 
