#!/bin/sh

# Exit immediately if a simple command exits with a nonzero exit value
set -e

docker build --build-arg DOCKER_USERNAME="$DOCKER_USERNAME" --build-arg DOCKER_PASSWORD="$DOCKER_PASSWORD" --build-arg DOCKER_SERVER="$DOCKER_SERVER" -t dockercli .
docker-compose -f docker-compose.yml run --rm test
