#!/bin/bash

REMOTE=https://raw.githubusercontent.com/prankstr/homelab/main/kubernetes/talos/docker-compose.yaml

if curl -s $REMOTE | cmp -s docker-compose.yaml; then
  # No diff
  exit 0
fi

curl -O $REMOTE

docker compose down
docker compose up -d
