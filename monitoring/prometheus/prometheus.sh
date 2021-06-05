#!/bin/sh
set -ue


VER="v2.22.0"
PROM_VOLUME="prom_local"

exec docker run -ti --rm \
	--network="host" \
	--name="prometheus" \
	-v "$PROM_VOLUME":/prometheus \
	-v /etc/prometheus/prometheus.yml:/etc/prometheus/prometheus.yml:ro \
	prom/prometheus:"$VER" \
	    --web.listen-address=localhost:9090 \
        --config.file=/etc/prometheus/prometheus.yml \
        --storage.tsdb.path=/prometheus
