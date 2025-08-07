FROM amazonlinux:2

# Install common dependencies
RUN yum install -y yum-utils git curl unzip wget

# Install MongoDB Shell
RUN curl -o /etc/yum.repos.d/mongodb-org-4.2.repo https://repo.mongodb.org/yum/amazon/2/mongodb-org/4.2/x86_64/mongodb-org-4.2.repo && \
    yum install -y mongodb-org-shell

# Install MySQL Client
RUN yum install -y https://dev.mysql.com/get/mysql80-community-release-el7-3.noarch.rpm && \
    yum install -y mysql

# Clean cache
RUN yum clean all

# Copy your install script
COPY install.sh /
RUN bash /install.sh

# Copy and set entrypoint
COPY run.sh /
ENTRYPOINT ["bash", "/run.sh"]
