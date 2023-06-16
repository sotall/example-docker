# Set the base image for the Docker container to the Python 3.9 slim version.
# The slim version is a smaller image size compared to the full version, which
# can be beneficial for optimizing container size and performance.
FROM python:3.9-slim

# This command sets the working directory inside the container to `/app`.
# It means that all subsequent commands and operations will be performed
# in this directory unless explicitly specified otherwise.
WORKDIR /app

# This command copies the file `my_script.py` from the host machine (the machine running Docker)
# to the current working directory inside the container (`/app`). The dot (`.`) indicates
# that the file should be copied to the current directory.
COPY my_script.py .

# You can uncomment and modify this line to install additional Python packages using pip
# This line is commented out and serves as an example of how to install additional Python
# packages using pip. If you want to install more packages, you can uncomment this line and
# modify it accordingly. For example, you can replace `package_name` with the name of the
# package you want to install.
# Example: RUN pip install package_name

# This command sets the default command that will be executed when the container starts.
# In this case, it specifies that the command to be executed is `python my_script.py`.
# This means that when the container starts, it will run the Python script `my_script.py` as the main process.
ENTRYPOINT ["python", "my_script.py"]
