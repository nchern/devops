# cpu-mon

A simple CPU monitoring script. Designed to keep the history of CPU consumers on the host.
It periodically runs `top`, saves top N processes from its output to a file and then sends this file to `syslog`.
Installs as a daemon.
