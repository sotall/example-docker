#!/bin/bash

# Build the image
docker build --build-arg CYPRESS=12.12.0 -t 04_push_image_dockerhub .

# Run the container
docker run --rm --name my_cypress 04_push_image_dockerhub
