FROM       amazonlinux:2

# Install required tools
#RUN yum install -y yum-utils git curl unzip && \
#    yum install -y https://repo.mongodb.org/yum/amazon/2/mongodb-org/4.2/x86_64/RPMS/mongodb-org-shell-4.2.24-1.amzn2.x86_64.rpm

# Copy script files
COPY       install.sh /
RUN        bash /install.sh

COPY        run.sh /
ENTRYPOINT ["bash", "/run.sh"]
