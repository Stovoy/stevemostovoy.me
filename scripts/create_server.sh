#!/bin/bash -e

docker-machine create --driver=digitalocean \
    --digitalocean-access-token=$DIGITAL_OCEAN_ACCESS_TOKEN \
    --digitalocean-image=coreos-stable \
    --digitalocean-region=sfo1 \
    --digitalocean-size=512MB \
    --digitalocean-ssh-user=core \
    stevemostovoy.me
