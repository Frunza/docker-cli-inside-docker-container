# Docker CLI inside Docker container

## Motivation

If you are used to running all of your pipeline scripts inside a Docker container, you might reach a point where you need to use `Docker CLI` in your pipeline scripts. This is not straightforward and needs some extra consideration.

## Prerequisites

A Linux or MacOS machine for local development. If you are running Windows, you first need to set up the *Windows Subsystem for Linux (WSL)* environment.

You need `docker cli` and `docker-compose` on your machine for testing purposes, and/or on the machines that run your pipeline.
You can check both of these by running the following commands:
```sh
docker --version
docker-compose --version
```

Credentials for a docker registry as environment variables:
- `DOCKER_USERNAME`
- `DOCKER_PASSWORD`
- `DOCKER_SERVER`: you can leave this out if you are logging into `Dockerhub`

## Implementation

First of all, install `docker-cli` in the Docker image:
```sh
RUN apk add --no-cache docker-cli
```

Now you have to start the Docker daemon:
```sh
RUN dockerd &
```

Now login into Docker:
```sh
ARG DOCKER_USERNAME
ARG DOCKER_PASSWORD
ARG DOCKER_SERVER
RUN echo "${DOCKER_PASSWORD}" | docker login -u "${DOCKER_USERNAME}" --password-stdin "${DOCKER_SERVER}"
```

In your Docker compose file, you need to add the following:
```sh
    volumes:
      # Mount the docker socket to allow docker commands to be run from within the container
      - /var/run/docker.sock:/var/run/docker.sock
```

For testing purposes, you can run the following inside the docker container:
```sh
docker images
```

## Usage

From the root of the repository call:
```sh
sh run.sh
```
