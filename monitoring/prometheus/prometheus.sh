#!/bin/sh
set -ue

VER="v2.32.1"
IMAGE="prom/prometheus:$VER"

VOLUME="prom_local"


init() {
    # docker volume create $VOLUME
    docker pull "$IMAGE"
}


case "${1:-}" in
	"init")
		init && exit 0
		;;
esac

exec docker run -ti --rm \
	--network="host" \
	--name="prometheus" \
	-v "$VOLUME:/prometheus" \
	-v /etc/prometheus/prometheus.yml:/etc/prometheus/prometheus.yml:ro \
	"$IMAGE" \
        --web.listen-address=localhost:9090 \
        --config.file=/etc/prometheus/prometheus.yml \
        --storage.tsdb.path=/prometheus
