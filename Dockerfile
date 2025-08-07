FROM amazonlinux:2

# Install prerequisites
RUN yum install -y yum-utils curl git mysql && yum clean all

# Copy and execute install.sh
COPY install.sh /
RUN bash /install.sh

# Copy and set entrypoint
COPY run.sh /
ENTRYPOINT ["bash", "/run.sh"]

