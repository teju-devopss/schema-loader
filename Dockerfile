FROM amazonlinux:2

# Install core utilities
RUN yum install -y yum-utils curl git mysql awscli && \
    yum clean all


# ✅ FIXED: repo file must be multiline
RUN echo '[mongodb-org-4.2]
name=MongoDB Repository
baseurl=https://repo.mongodb.org/yum/amazon/2/mongodb-org/4.2/x86_64/
gpgcheck=0
enabled=1' > /etc/yum.repos.d/mongodb-org-4.2.repo && \
    yum install -y mongodb-org-shell && \
    yum clean all

# Create working directory and copy scripts
WORKDIR /app
COPY install.sh /install.sh
COPY run.sh /run.sh
RUN chmod +x /install.sh /run.sh

# Run installation script
RUN /install.sh

# Final command (assumes run.sh handles schema load logic)
CMD ["/run.sh"]

