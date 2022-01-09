#!/bin/sh
set -ue

VER="8.3.3"

VOLUME="grafana-data"

IMAGE_BASE="grafana/grafana"
IMAGE="$IMAGE_BASE:$VER"

init() {
    # docker volume create $VOLUME
    docker pull "$IMAGE"
}

case "${1:-}" in
	"init")
		init && exit 0
		;;
esac

exec docker run --rm \
    --name grafana_local \
    --network="host" \
    --volume "$VOLUME:/var/lib/grafana" \
    -e "GF_SERVER_HTTP_ADDR=127.0.0.1" \
    "$IMAGE"
