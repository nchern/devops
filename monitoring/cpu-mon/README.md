# cpu-mon

A simple CPU monitoring script. Designed to keep the history of CPU consumers on a host.
It periodically runs `top`, captures top N processes from its output and sends them to `syslog`.
Installs as a daemon.
