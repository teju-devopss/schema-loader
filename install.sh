echo '[mongodb-org-4.2]
name=MongoDB Repository
baseurl=https://repo.mongodb.org/yum/amazon/2/mongodb-org/4.2/x86_64/
gpgcheck=0
enabled=1' > /etc/yum.repos.d/mongo.repo

yum install -y mongodb-org-shell -y

