

.PHONY: install
install:
	mkdir -p /etc/prometheus/
	install prometheus.yml /etc/prometheus/
	install prometheus.sh /usr/local/bin/
	install prometheus.service /etc/systemd/system/
	systemctl daemon-reload
	systemctl enable prometheus 
	systemctl start prometheus 
	systemctl status prometheus 
