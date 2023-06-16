# Docker Examples

This project contains several Docker examples, each demonstrating different aspects of working with Docker. Each example is contained within its own folder and has a separate `readme.md` file with instructions on how to run the example. Additionally, you can use the `runme.sh` script provided in each directory to quickly test the project.

## Folder Structure

The project has the following folder structure:

-   `01_docker_run`: Example demonstrating how to use the `docker run` command.
-   `02_build_dockerfile`: Example demonstrating how to build a Docker image using a Dockerfile.
-   `03_docker_compose`: Example demonstrating how to use Docker Compose to manage multi-container applications.
-   `04_push_image_dockerhub`: Example demonstrating how to build a Docker image and push it to Docker Hub.

Each folder contains a `readme.md` file with detailed instructions on how to run the example.

## Running the Examples

To run an example, navigate to the respective example folder and follow the instructions provided in the `readme.md` file. Additionally, you can use the `runme.sh` script in each directory to quickly test the project. Simply execute `./runme.sh` within the desired example folder, and it will run the example based on the predefined configuration.

Make sure you have Docker installed and properly configured on your machine before running the examples.

Feel free to explore each example folder, read the individual `readme.md` files, and experiment with the Docker examples provided.

Enjoy learning and experimenting with Docker!

---

# Understanding Docker Layers

Docker is a popular containerization technology that allows you to package your application and its dependencies into a portable container. A Docker container is an instance of a Docker image, which is a read-only template that contains all the instructions needed to create a container.

Docker images are built using a layered architecture, which means that each image consists of a series of read-only layers that are stacked on top of each other. Each layer contains a specific set of instructions for configuring the container. When you run a container, Docker merges all the layers into a single writable layer, which is called the container layer.

## Docker Image Layers

Each layer in a Docker image is represented by a set of files and directories. When you build a Docker image, each instruction in the Dockerfile creates a new layer. For example, if you have a Dockerfile with the following instructions:

Dockerfile

```
FROM ubuntu:latest
RUN apt-get update && apt-get install -y nginx
COPY index.html /var/www/html/
```

This Dockerfile will create three layers:

1. The base layer, which is the Ubuntu image.
2. The second layer, which installs the Nginx web server on top of the Ubuntu image.
3. The third layer, which copies the index.html file into the Nginx web server directory.

Each layer is identified by a unique SHA256 hash, which is generated based on the contents of the layer. This allows Docker to cache layers and reuse them across multiple images, which can greatly improve build times.

## Docker Container Layers

When you run a Docker container, Docker creates a new writable layer on top of the image layers. This layer is used to store any changes made to the container during runtime, such as files created by the application or user input.

The container layer is created using a copy-on-write mechanism, which means that any changes made to the container are stored in a new layer rather than modifying the existing layers. This allows multiple containers to share the same image layers, while still maintaining their own separate writable layers.

## Conclusion

Understanding Docker layers is important for optimizing Docker image builds and improving container performance. By using a layered architecture, Docker is able to efficiently package and distribute applications and their dependencies, while still providing a lightweight and portable runtime environment.
