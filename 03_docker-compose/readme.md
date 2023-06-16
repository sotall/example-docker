# Example using Docker Compose

## Description

This project provides a template and instructions for running Cypress tests using Docker Compose. It helps automate the setup and execution of Cypress tests by utilizing Docker containers. Docker Compose is used to define and manage the services required for running the tests. The project includes sample Cypress test files and a Docker Compose configuration file, along with a bash script for simplified execution.

-   Official Docker Hub page for the `cypress/included` image: [cypress/included](https://hub.docker.com/r/cypress/included)
-   Docker-compose: [Overview of Docker Compose](https://docs.docker.com/compose/)
-   Docker-compose: [Compose reference](https://github.com/docker/compose/blob/v2/docs/reference/compose.md)

## Prerequisites

-   Docker installed on your system. If Docker is not installed, download and install it from the official website: [Docker Desktop](https://www.docker.com/products/docker-desktop/).

## Project Structure

The project consists of the following files:

-   `docker-compose.yml`: This file contains the Docker Compose configuration. It defines the services and their configurations required for running the project.
-   `cypress.config.js`: This file provides additional configuration options for running the Cypress tests.
-   `example.cy.js`: This file includes the test cases written in Cypress. You can customize this file to add or modify the test scenarios.
-   `runme.sh`: A shell script to automate building and running the Docker container.

## Usage

1. Option 1: Run Manually
    - Run the following command to start the Docker Compose process and run the Cypress tests:
    ```
    docker-compose up
    ```
    - Once the tests are finished, you can stop the Docker Compose process by running:
    ```
    docker-compose down
    ```
2. Option 2: Run the bash script
    - Run the script will start the Docker Compose process and run the Cypress tests:
    ```bash
    ./runme.sh
    ```

## Results

When you execute the `docker-compose up` command, Docker Compose will create and start a container based on the "cypress" service defined in your `docker-compose.yml` file. This container will use the specified Cypress image, be named "03_docker-compose", and execute the Cypress command to run tests defined in "example.cy.js" with the provided configuration options. Additionally, the volume mapping specified in the `docker-compose.yml` file ensures that the project files are accessible within the container.

On the other hand, when you run the `docker-compose down` command, it will stop and remove the containers, networks, and volumes as defined in your `docker-compose.yml` file. However, if you need the containers, networks, or volumes to persist even after stopping, you can customize the `down` command by using additional options. For more detailed information and available options, please refer to the [Docker Compose documentation](https://docs.docker.com/compose/reference/).

## File Breakdown

---

### docker-compose.yml

This code is a configuration file for Docker Compose, and it describes a service named "cypress" with the following properties:

```
version: '3.2'
services:
  cypress:
    image: 'cypress/included:12.12.0'
    container_name: 03_docker-compose
    working_dir: /cypress
    volumes:
      - ./:/cypress
    command: ["cypress run --config-file cypress.config.js --spec example.cy.js"]

```

1. `version: '3.2'`: Specifies the version of the Docker Compose file format being used, which is version 3.2 in this case.
2. `services:`: Indicates the start of the services section, where individual services are defined.
3. `cypress:`: Defines a service named "cypress".
4. `image: 'cypress/included:12.12.0'`: Specifies the Docker image to be used for the "cypress" service, which is "cypress/included" version 12.12.0.
5. `container_name: 03_docker-compose`: Sets the name of the container to "03_docker-compose".
6. `working_dir: /cypress`: Sets the working directory inside the container to "/cypress".
7. `volumes:`: Specifies the volumes to be mounted for the service.
8. `- ./:/cypress`: Mounts the current directory (where the Docker Compose file is located) to the "/cypress" directory inside the container, allowing access to files and directories from the host machine.
9. `command: ["cypress run --config-file cypress.config.js --spec example.cy.js"]`: Specifies the command to be executed when the container starts, which is running Cypress tests using the given configuration file and test spec.

---

The `runme.sh` script automates the process of building and running the Docker container.

```
#!/bin/bash
docker-compose up
docker-compose down
```

1. `#!/bin/bash`: Specifies that the script should be executed using the Bash shell.
2. `docker-compose up`: Runs the Docker Compose command to start the services defined in the docker-compose.yml file.
3. `docker-compose down`: Executes the Docker Compose command to stop and remove the containers, networks, and volumes specified in the docker-compose.yml file.

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
