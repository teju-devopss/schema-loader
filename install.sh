#!/bin/bash
set -e

# Create MongoDB repository
cat <<EOF > /etc/yum.repos.d/mongo.repo
[mongodb-org-4.2]
name=MongoDB Repository
baseurl=https://repo.mongodb.org/yum/redhat/\$releasever/mongodb-org/4.2/x86_64/
gpgcheck=0
enabled=1
EOF

# Install required tools
yum install -y mongodb-org-shell mysql git && yum clean all


