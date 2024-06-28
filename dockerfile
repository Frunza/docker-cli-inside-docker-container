FROM alpine:3.18.0

# Install Docker
RUN apk add --no-cache docker-cli
# Start Docker daemon
RUN dockerd &
# Login to Docker
ARG DOCKER_USERNAME
ARG DOCKER_PASSWORD
ARG DOCKER_SERVER
RUN echo "${DOCKER_PASSWORD}" | docker login -u "${DOCKER_USERNAME}" --password-stdin "${DOCKER_SERVER}"

# Copy scripts to the expected location
COPY ./scripts /app

CMD ["sh"]
