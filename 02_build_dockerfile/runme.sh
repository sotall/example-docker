#!/bin/bash

# Opional argument to the script, which will be assigned to the NAME variable
# If the script is executed with an argument, the value of the argument is assigned to the NAME variable
# If no argument is provided, the default value "John" is assigned to the NAME variable
NAME=${1:-"John"}

# Build the Docker image using the Dockerfile in the current directory
# The Dockerfile contains instructions for creating a Docker image, including dependencies and configurations
# The `-t` flag tags the image with the name "02_dockerfile" for easy reference
# The `.` specifies the current directory as the build context, meaning the Dockerfile is located in the same directory as the script
docker build -t 02_dockerfile .

# Run the Docker container with the USER_NAME environment variable set to the provided or default name
# The `docker run` command creates and starts a new Docker container based on the specified image
# The `--rm` flag ensures that the container is automatically removed after it finishes executing, cleaning up resources
# The `--name` assigns the name "MY_Container" to the Docker container. This allows you to identify and reference the container using this name in subsequent Docker commands or operations.
# The `-e` flag sets an environment variable within the container, in this case, USER_NAME is set to the value of the NAME variable from the script
# The `02_dockerfile` argument specifies the image to use for running the container
# When the container starts, it will execute the commands defined in the Dockerfile, which includes running the Python script with the provided or default name
docker run --rm --name MY_Container -e USER_NAME="$NAME" 02_dockerfile
