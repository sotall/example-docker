#!/bin/bash

# Check if Docker is installed
if ! docker info &>/dev/null; then
    echo "*************************************************************************************************"
    echo "Docker is not running. Please start the 'Docker Desktop' app or install Docker from https://www.docker.com/products/docker-desktop"
    echo "*************************************************************************************************"
    echo
    exit
fi

# Pull hello-world image from Docker Hub
docker pull hello-world

# Run hello-world image
# The `docker run` command creates and starts a new Docker container based on the specified image
# The `--rm` flag ensures that the container is automatically removed after it finishes executing, cleaning up resources
# The `--name` assigns the name "01_docker_run" to the Docker container. This allows you to identify and reference the container using this name in subsequent Docker commands or operations.
# The `hello-world` argument specifies the image to use for running the container
# When the container starts, it will execute the commands defined in the Dockerfile
docker run --rm --name 01_docker_run hello-world
