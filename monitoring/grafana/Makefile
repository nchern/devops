

.PHONY: user
user:
	@useradd -rs /bin/false grafana || true


.PHONY: install
install: user
	@install grafana.sh /usr/local/bin/
	@./grafana.sh init


.PHONY: install-systemd
install-systemd: install
	@install -m 0644 grafana.service /etc/systemd/system/
	systemctl daemon-reload
	systemctl enable grafana 
	systemctl start grafana 
	systemctl status grafana 
