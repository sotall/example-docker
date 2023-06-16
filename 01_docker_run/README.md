# Pull and Run Hello World Image from Docker Hub

---

test
test 2
test 3
test 4
test 5

## Description

This README provides instructions for pulling and running the `hello-world` Docker image from Docker Hub. The `hello-world` image is a simple test image that prints a "Hello from Docker!" message.

Official Docker Hub page for the `hello-world` image: [hello-world](https://hub.docker.com/_/hello-world)

## Prerequisites

-   Docker installed on your system. If Docker is not installed, download and install it from the official website: [Docker Desktop](https://www.docker.com/products/docker-desktop/).

## Project Structure

The project consists of the following files:

-   `runme.sh`: A shell script to automate building and running the Docker container.

## Usage

1. Option 1: Run Manually
    - Pull the `hello-world` image from Docker Hub:
        ```
        docker pull hello-world
        ```
    - Run the `hello-world` image:
        ```
        docker run hello-world
        ```
2. Option 2: Run the bash script
    - Run the provided bash script `runme.sh`:
        ```
        ./runme.sh
        ```

## Results

After pulling the hello-world image from Docker Hub using the `docker pull` command, we proceed to run the image using the `docker run` command. The output message "Hello from Docker!" is then displayed in the terminal, accompanied by additional information about the Docker installation.

### Notes

The `docker pull` command is used to pull an image or a repository from a registry, downloading it to your local Docker environment.

On the other hand, the `docker run` command runs a command or a process in a new container. If you use `docker run` with an image that is not already available locally, Docker will automatically pull the image from the registry before creating and running the container.

In summary, `docker pull` explicitly fetches the image from a registry, while `docker run` implicitly triggers a pull if the image is not found locally before creating and running the container.

## File Breakdown

---

### runme.sh

The `runme.sh` script automates the process of Pulling and running the Docker container.

```
#!/bin/bash
docker pull hello-world
docker run --rm --name 01_docker_run hello-world
```

1. `docker pull`: command is used to download Docker images from a registry to your local machine, enabling you to run containers based on those images.
    - `hello-world`: This is the name of the Docker image you want to pull. In this case, it refers to the "hello-world" image.
2. `docker run`: Executes the Docker run command to start a new container.
    - `--rm`: Specifies that the container should be automatically removed after it finishes running.
    - `--name 01_docker_run`: Assigns the name "01_docker_run" to the running container.
    - `hello-world`: Specifies the name of the Docker image to use for creating the container, in this case, "hello-world".

---

## Contributing

If you find any issues with the project or would like to contribute to its development, please feel free to open an issue or submit a pull request.

## Acknowledgements

-   [Docker](https://www.docker.com/) - The open platform for developing, shipping, and running applications.
-   [Docker Hub](https://hub.docker.com/) - A cloud-based registry service for sharing Docker images.

<br>
<br>
<br>
Thank you for using and contributing to this project. Happy coding!
