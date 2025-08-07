# Start from Amazon Linux 2
FROM amazonlinux:2

# Install dependencies
RUN yum install -y yum-utils curl && \
    yum install -y awscli mysql git && \
    yum clean all

# Add MongoDB repo correctly
RUN echo '[mongodb-org-4.2]
name=MongoDB Repository
baseurl=https://repo.mongodb.org/yum/redhat/\$releasever/mongodb-org/4.2/x86_64/
gpgcheck=0
enabled=1' > /etc/yum.repos.d/mongo.repo && \
    yum install -y mongodb-org-shell && \
    yum clean all

# Create working directory
WORKDIR /app

# Copy scripts into image
COPY install.sh /
COPY run.sh /

# Make scripts executable
RUN chmod +x /install.sh /run.sh

# Set entrypoint to run.sh
ENTRYPOINT ["/run.sh"]


