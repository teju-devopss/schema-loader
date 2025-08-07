FROM amazonlinux:2

# Install MongoDB Shell, MySQL, Git, AWS CLI
RUN yum install -y \
    amazon-linux-extras \
    && amazon-linux-extras enable corretto8 \
    && yum install -y \
       mongodb-org-shell \
       mysql \
       git \
       awscli \
    && yum clean all

WORKDIR /app

COPY run.sh /run.sh
RUN chmod +x /run.sh

ENTRYPOINT ["/run.sh"]




