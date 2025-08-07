FROM amazonlinux:2

# Enable Amazon Linux extras for MongoDB and install required packages
RUN amazon-linux-extras enable corretto8 && \
    yum install -y \
        mongodb-org-shell \
        mysql \
        git \
        awscli && \
    yum clean all

WORKDIR /app

COPY install.sh /
COPY run.sh /

RUN chmod +x /install.sh /run.sh

ENTRYPOINT ["/run.sh"]




