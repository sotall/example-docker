# Use the Debian base image
FROM debian

# Set the environment variable
ARG DEBIAN_FRONTEND="noninteractive"
ARG CYPRESS

# Term environment variable
ENV TERM xterm

# Update and install the required packages
RUN apt-get update -y
RUN apt-get install -y \
    curl \
    sudo \
    xvfb \
    lsb-release \
    nodejs \
    npm

# Install Chromium
RUN apt-get install chromium -y --no-install-recommends

# Copy the Cypress files
ADD cypress cypress
WORKDIR /cypress

# Install Cypress
RUN npm install --save-dev cypress@${CYPRESS}

# Cleanup
RUN rm -fr /var/lib/apt/lists/* /tmp/* /var/tmp/* && apt-get clean

# Run Cypress
ENTRYPOINT ["npx", "cypress", "run"]
CMD ["--config-file", "cypress.config.js", "--spec", "e2e/example.cy.js", "--browser", "chromium"]
