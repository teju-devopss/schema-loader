# Base image
FROM amazonlinux:2

# Set environment variables
ENV COMPONENT=shipping

# Install required packages
RUN yum install -y \
    curl \
    git \
    yum-utils \
    mysql \
    && yum clean all

# Add MongoDB repo and install mongosh
RUN curl -o /etc/yum.repos.d/mongodb-org-4.2.repo \
    https://repo.mongodb.org/yum/amazon/2/mongodb-org/4.2/x86_64/mongodb-org-4.2.repo && \
    yum install -y mongodb-org-shell && \
    yum clean all

# Create directories
RUN mkdir -p /app /parameters

# Copy the install script
COPY install.sh /

# Run the install script
RUN bash /install.sh

# Default workdir
WORKDIR /app
