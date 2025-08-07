FROM ubuntu:20.04

# Set noninteractive for clean install
ENV DEBIAN_FRONTEND=noninteractive

# Install dependencies
RUN apt-get update && apt-get install -y \
    curl gnupg git wget unzip lsb-release software-properties-common

# Install MongoDB Shell (mongosh)
RUN curl -fsSL https://pgp.mongodb.com/server-6.0.asc | gpg --dearmor -o /usr/share/keyrings/mongodb-server-6.0.gpg && \
    echo "deb [ signed-by=/usr/share/keyrings/mongodb-server-6.0.gpg ] https://repo.mongodb.org/apt/ubuntu focal/mongodb-org/6.0 multiverse" | tee /etc/apt/sources.list.d/mongodb-org-6.0.list && \
    apt-get update && apt-get install -y mongodb-mongosh

# Install MySQL client
RUN apt-get install -y mysql-client

# Clean up
RUN apt-get clean && rm -rf /var/lib/apt/lists/*

# Add your files
COPY install.sh /
RUN bash /install.sh

COPY run.sh /
ENTRYPOINT ["bash", "/run.sh"]
