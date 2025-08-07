FROM amazonlinux:2

# Install dependencies
RUN yum install -y yum-utils curl awscli git mysql && yum clean all

# Add MongoDB repo using safe multi-line heredoc
RUN cat <<EOF > /etc/yum.repos.d/mongodb-org-4.2.repo
[mongodb-org-4.2]
name=MongoDB Repository
baseurl=https://repo.mongodb.org/yum/redhat/\$releasever/mongodb-org/4.2/x86_64/
gpgcheck=0
enabled=1
EOF

# Install MongoDB shell
RUN yum install -y mongodb-org-shell && yum clean all

# Create working directory
WORKDIR /app

# Copy install and run scripts
COPY install.sh /
COPY run.sh /

# Make scripts executable
RUN chmod +x /install.sh /run.sh

# Default command
ENTRYPOINT ["/run.sh"]



