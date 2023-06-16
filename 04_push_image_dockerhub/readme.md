# Building and Push to Docker Hub with Bitbucket Pipelines

## Description

This is an example project that demonstrates how to build a Docker image from a Dockerfile using Bitbucket Pipelines, then push it to Docker Hub.

## Prerequisites

-   Docker installed on your system. If Docker is not installed, download and install it from the official website: [Docker Desktop](https://www.docker.com/products/docker-desktop/).
-   Bitbucket account. If you don't have one, you can create one for free at [Bitbucket](https://bitbucket.org/).
-   Docker Hub account. If you don't have one, you can create one for free at [Docker Hub](https://hub.docker.com/).
-   Bitbucket Documentation: [Bitbucket Pipelines](https://support.atlassian.com/bitbucket-cloud/docs/get-started-with-bitbucket-pipelines/)

## Project Structure

The project consists of the following files:

-   `bitbucket-pipelines.yml`: Bitbucket Pipelines configuration file that defines the build and release process.
-   `Dockerfile`: Dockerfile used to build the Docker image.
-   `runme.sh`: Bash script to build and run the Docker image locally.
-   `cypress/cypress.config.js`: Cypress configuration file.
-   `cypress/e2e/example.cy.js`: Example Cypress test file.

## Usage

#### Options 1 - Build and run locally

-   If you want to run the image locally, you can do so by running the following command:
    ```
    docker build --build-arg CYPRESS=12.12.0 -t example . && docker run example
    ```
    OR, run the bash script:
    ```
    ./runme.sh
    ```
    -   The Cypress test will run and the results will be displayed in the console.

#### Option 2 - Build locally and push to Dockerhub

-   Notes:
    -   In case you have a Dockerhub account with an existing repository that you intend to push to, simply modify "04_push_image_dockerhub" to correspond with your repository name.
    -   If you don't have a Dockerhub account, you can create one along with a repository specifically for this example.
    -   If you omit the repository name, a new one will be created for you named "04_push_image_dockerhub" when you push the image.

1. Start by running the command "docker login" and provide your credentials when prompted.
    ```
    docker login
    ```
2. Proceed to build the image, ensuring you replace `<username>` with your own Dockerhub username
    ```
    docker build --build-arg CYPRESS=12.12.0 -t <username>/04_push_image_dockerhub:latest .
    ```
3. Finally, push the image to Dockerhub, again replacing `<username>` with your own Dockerhub username
    ```
    docker push <username>/04_push_image_dockerhub
    ```
4. Optionally, you may choose to log out after completing the process.
    ```
    docker logout
    ```

#### Option 3 - Build and push to Dockerhub from Bitbucket Pipelines

1.  Create Dockerhub repository for your project.
    1. Sign in or create a Docker Hub account.
    2. Navigate to the "Repositories" section.
    3. Click on "Create Repository".
    4. Choose a unique name for your repository.
    5. Select the visibility (public or private) for your repository.
    6. Configure additional options if needed.
    7. Click on "Create" to create the repository.
2.  Set up a Bitbucket repository for your project.
    1. Sign in or create a Bitbucket account.
    2. Navigate to your workspace.
    3. Click on the "+" icon or "Create" button.
    4. Select "Repository".
    5. Provide a unique name for your repository.
    6. Choose the visibility (public or private) for your repository.
    7. Click on "Create repository".
3.  Once the Bitbucket project is created
    1. Don't enter your Dockerhub credentials directly into the `bitbucket-pipelines.yml` file. Instead, use Bitbucket repository variables to store them securely.
    2. Make sure to set the `DOCKER_USERNAME` and `DOCKER_PASSWORD` environment variables in your Bitbucket repository settings with appropriate Docker Hub credentials.
    3. go to `Repository Settings > Repository variables > Add variable`
4.  Copy all files from this example project and Commit and Push them to your Bitbucket repository.
5.  Bitbucket Pipelines will automatically detect the `bitbucket-pipelines.yml` file and trigger a build and release process when you push changes.

## File Breakdown

---

### bitbucket-pipelines.yml

To build and push a Docker image to Docker Hub using Bitbucket Pipelines, the `bitbucket-pipelines.yml` file defines the pipeline configuration. The configuration includes key elements for building and pushing the Docker image.

```
definitions:
  steps:
    - step: &release
        name: Release to Dockerhub
        services:
          - docker
        script:
          - docker --version
          - docker login --username="${DOCKER_USERNAME}" --password="${DOCKER_PASSWORD}"
          - cypress_version=12.12.0
          - namespace=<DOCKERHUB_USER_NAME_HERE>
          - repository=04_push_image_dockerhub
          - git add -A
          - git tag -a "$cypress_version" --message "version $cypress_version" --force
          - git push --tags --force
          - docker build --build-arg VERSION=$cypress_version --tag $namespace/$repository:latest --tag $namespace/$repository:$version .
          - docker push $namespace/$repository:$cypress_version
          - docker push $namespace/$repository:latest

pipelines:
  default:
    - step: *release
```

1. `docker --version`: Prints the Docker version to the console.
2. `docker login --username="${DOCKER_USERNAME}" --password="${DOCKER_PASSWORD}"`: Authenticates with Docker Hub using the provided username and password. Make sure to set these environment variables in your Bitbucket repository settings.
3. `cypress_version=12.12.0`: Sets the Cypress version to be used for the Docker image.
4. `namespace=<DOCKERHUB_USER_NAME_HERE>` and `repository=04_push_image_dockerhub`: Sets the Docker image namespace and repository name.
5. `git add -A`: Adds all changes to the Git repository.
6. `git tag -a "$cypress_version" --message "version $cypress_version" --force`: Creates a Git tag for the specified Cypress version with a custom message.
7. `git push --tags --force`: Forces a push of the Git tags to the repository.
8. `docker build --build-arg VERSION=$cypress_version --tag $namespace/$repository:latest --tag $namespace/$repository:$version .`: Builds the Docker image using the specified Cypress version. It uses the `VERSION` build argument and sets appropriate tags for the image.
9. `docker push $namespace/$repository:$cypress_version`: Pushes the Docker image with the specific Cypress version tag to Docker Hub.
10. `docker push $namespace/$repository:latest`: Pushes the Docker image with the "latest" tag to Docker Hub.

---

## Dockerfile

The `Dockerfile` is used to build the Docker image. Here's an overview of its contents:

```
FROM debian
ARG DEBIAN_FRONTEND="noninteractive"
ARG CYPRESS
ENV TERM xterm
RUN apt-get update -y
RUN apt-get install -y \
    curl \
    sudo \
    xvfb \
    lsb-release
RUN curl -sL https://deb.nodesource.com/setup_14.x | sudo -E bash -
RUN apt-get install -y nodejs
RUN apt-get install chromium -y --no-install-recommends
ADD cypress cypress
WORKDIR /cypress
RUN npm install --save-dev cypress@${CYPRESS}
RUN rm -fr /var/lib/apt/lists/* /tmp/* /var/tmp/* && apt-get clean
ENTRYPOINT ["npx", "cypress", "run"]
CMD ["--config-file", "cypress.config.js", "--spec", "e2e/example.cy.js", "--browser", "chromium"]
```

1. `FROM debian`: Specifies that the base image for this Docker image is Debian. It serves as the starting point for building the container.
2. `ARG DEBIAN_FRONTEND="noninteractive"`: Defines an argument `DEBIAN_FRONTEND` with the value "noninteractive". This argument is used to set the frontend mode for the Debian package manager (apt) to non-interactive, which avoids any prompts during package installations.
3. `ARG CYPRESS`: Defines an argument `CYPRESS`. The value for this argument is expected to be provided at build time.
4. `ENV TERM xterm`: Sets the environment variable `TERM` to "xterm". This is used to define the terminal type to be used within the container.
5. `RUN apt-get update -y`: Updates the package lists for apt by running `apt-get update`. The `-y` flag automatically confirms any prompts or questions during the update process.
6. `RUN apt-get install -y`: Installs the following packages using apt-get:
    - `curl`: A command-line tool for transferring data using various protocols.
    - `sudo`: Allows executing commands with superuser privileges.
    - `xvfb`: X virtual framebuffer, a display server implementing the X11 display server protocol in virtual memory.
    - `lsb-release`: Provides information about the Linux Standard Base (LSB) distribution.
7. `RUN curl -sL https://deb.nodesource.com/setup_14.x | sudo -E bash -`: Downloads and executes a shell script from `https://deb.nodesource.com/setup_14.x`. This script is piped to the `bash` shell with `sudo -E` to execute it with superuser privileges.
8. `RUN apt-get install -y nodejs`: Installs Node.js by running `apt-get install` with the `-y` flag, which automatically confirms the installation.
9. `RUN apt-get install chromium -y --no-install-recommends`: Installs the Chromium browser using `apt-get install` with the `-y` flag and `--no-install-recommends` option. The `--no-install-recommends` option skips installing recommended packages along with Chromium.
10. `ADD cypress cypress`: Adds the contents of the local directory named "cypress" to the `/cypress` directory in the container.
11. `WORKDIR /cypress`: Sets the working directory to `/cypress` within the container.
12. `RUN npm install --save-dev cypress@${CYPRESS}`: Runs the `npm install` command to install the Cypress package as a development dependency. The version of Cypress is determined by the value of the `CYPRESS` argument provided at build time.
13. `RUN rm -fr /var/lib/apt/lists/* /tmp/* /var/tmp/* && apt-get clean`: Removes unnecessary files and clears the package manager cache to reduce the size of the Docker image.
14. `ENTRYPOINT ["npx", "cypress", "run"]`: Sets the entrypoint command for the container to execute the `cypress run` command using `npx`, which is a tool for executing Node.js packages.
15. `CMD ["--config-file", "cypress.config.js", "--spec", "e2e/example.cy.js", "--browser", "chromium"]`: Specifies the default command to be run when starting the container. It provides command-line arguments to the `cypress run` command, such as the configuration file, test specification, and the desired browser (Chromium) for running Cypress tests.

---

## runme.sh

The `runme.sh` script is provided to simplify building and running the Docker image locally. Here's an overview of its contents:

```
#!/bin/bash

# Build the image
docker build --build-arg CYPRESS=12.12.0 -t 04_push_image_dockerhub .

# Run the container
docker run 04_push_image_dockerhub
```

1. `docker build --build-arg CYPRESS=12.12.0 -t 04_push_image_dockerhub .`: This command builds a Docker image using the Dockerfile present in the current directory `(.)`.

    - `--build-arg CYPRESS=12.12.0`: Specifies a build argument (`CYPRESS`) and its value (`12.12.0`). Build arguments can be used in the Dockerfile during the build process.
    - `-t 04_push_image_dockerhub`: Tags the built image with the name 04_push_image_dockerhub.
    - `.`: Specifies the build context, in this case, the current directory.

2. `docker run 04_push_image_dockerhub`: This command runs a Docker container from the specified image (`04_push_image_dockerhub`). It executes the default command specified in the Dockerfile's `CMD` instruction.
    - `docker run`: The command to run a Docker container.
    - `04_push_image_dockerhub`: The name of the image from which the container should be created and run.

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
