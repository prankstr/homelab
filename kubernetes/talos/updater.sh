#!/bin/bash

REMOTE=https://raw.githubusercontent.com/prankstr/homelab/main/kubernetes/talos/docker-compose.yaml

if curl -s $REMOTE | cmp -s docker-compose-remote.yaml; then
    exit 0
fi

curl -o docker-compose-remote.yaml $REMOTE
sed 's/${MY_DOMAIN}/<actual domain>/g' docker-compose-remote.yaml > docker-compose.yaml

docker compose up -d