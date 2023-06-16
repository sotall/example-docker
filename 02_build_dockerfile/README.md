# Build a Docker Image using a Dockerfile

## Description

This project focuses on building a Docker image using a Dockerfile to run a Python script inside a container. The Python script, my_script.py, greets the user by printing a personalized message. The project provides instructions for building and running the Docker container manually or using a provided bash script.

-   Official Docker Hub page for the `python` image: [python](https://hub.docker.com/_/python)
-   Dockerfile reference: [Dockerfile reference](https://docs.docker.com/engine/reference/builder/)

## Prerequisites

-   Docker installed on your system. If Docker is not installed, download and install it from the official website: [Docker Desktop](https://www.docker.com/products/docker-desktop/).

## Project Structure

The project consists of the following files:

-   `Dockerfile`: Specifies the instructions for building the Docker image.
-   `my_script.py`: Contains a Python script that greets the user.
-   `runme.sh`: A shell script to automate building and running the Docker container.

## Usage

1. Option 1: Run Manually
    - Run the following command to build the Docker image:
        ```bash
        docker build -t 02_dockerfile .
        ```
    - After the image is built, run the following command to start a Docker container and execute the Python script:
        ```
        docker run 02_dockerfile
        ```
        Or
        ```
        docker run --rm --name MY_Container -e USER_NAME="<name>" 02_dockerfile
        ```
        Replace `<name>` with the desired name or leave it empty to use the default value.
2. Option 2: Run the bash script
    - Run the script with the desired name as an argument or leave it empty to use the default value:
        ```
        ./runme.sh <name>
        ```

## Results

After building the Docker image using the `docker build` command, we proceed to run the image using the `docker run` command. The output message "Hello, John! Welcome to the Matrix!" is then displayed in the terminal.

## Notes

Calling `docker build` after the initial build will typically utilize cached layers from previous builds, resulting in a faster build process. However, if you make modifications to the Dockerfile or any of the files it relies on, the build process will be triggered again, and Docker will not use the cached layers. To force a rebuild, even if the Dockerfile and its dependencies have not changed, you can use the `--no-cache` option. This option ensures that Docker ignores the cached layers and performs a full rebuild of the image, incorporating the latest changes.

## File Breakdown

---

### Dockerfile

The `Dockerfile` sets up the Docker container environment.

```
FROM python:3.9-slim
WORKDIR /app
COPY my_script.py .
ENTRYPOINT ["python", "my_script.py"]
```

1. `FROM` - Sets the base image to Python 3.9 slim version.
2. `WORKDIR` - Sets the working directory inside the container to `/app`.
3. `COPY` - Copies the `my_script.py` file to the current working directory inside the container.
4. `ENTRYPOINT` - Sets the default command to execute when the container starts, which is running `my_script.py` using Python.

---

### runme.sh

The `runme.sh` script automates the process of building and running the Docker container.

```
#!/bin/bash
NAME=${1:-"John"}
docker build -t 02_dockerfile .
docker run --rm --name MY_Container -e USER_NAME="$NAME" 02_dockerfile
```

1. `NAME` variable to the provided argument or defaults to "John" if no argument is provided.
2. `docker build`: Executes the Docker build command to create a new Docker image.
    - `-t 02_dockerfile`: Tags the resulting image with the name "02_dockerfile".
    - `.`: Specifies the context for the build, indicating that the current directory should be used as the build context.
3. `docker run`: Executes the Docker run command to start a new container.
    - `--rm`: Removes the container automatically after it exits.
    - `--name MY_Container`: Assigns the name "MY_Container" to the running container.
    - `-e USER_NAME="$NAME"`: Sets an environment variable named "USER_NAME" with the value stored in the variable "$NAME" within the container.
    - `02_dockerfile`: Specifies the image to be used for creating the container.

---

### my_script.py

The `my_script.py` file contains a Python script that retrieves the name from the environment variable and greets the user.

```
import os
name = os.getenv("USER_NAME", "Unknown")
print(f"Hello, {name}! Welcome to the script.")
```

1. Imports the `os` module for working with environment variables.
2. Retrieves the value of the `USER_NAME` environment variable using `os.getenv`.
3. If the environment variable is not set or does not exist, it uses the default value "Unknown".
4. Prints a greeting message to the user, including the retrieved or default name.

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
