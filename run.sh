#!/bin/bash
set -e
set -x

mkdir -p /parameters
> /parameters/params

# Fetch parameters from SSM and export to /parameters/params
for param in $PARAMS ; do
  PARAM=$(echo $param | awk -F, '{print $1}')
  KEY=$(echo $param | awk -F, '{print $2}')
  VALUE=$(aws ssm get-parameter --name $PARAM --region us-east-1 --with-decryption --query "Parameter.Value" --output text)
  echo "export $KEY=\"$VALUE\"" >> /parameters/params
done

# Source parameters
source /parameters/params

# Clone your app repo
git clone https://github.com/teju-devopss/learn-kubernetes.git /app

cd /app/schema/${component}

# Load the schema based on db type
if [ "$db" == "mongo" ]; then
  mongo --host ${MONGO_ENDPOINT} < ${component}.js
elif [ "$db" == "mysql" ]; then
  mysql -h ${MYSQL_HOST} -u${MYSQL_USER} -p${MYSQL_PASSWORD} < /app/schema/${component}/shipping.sql
else
  echo "Unsupported DB: $db"
  exit 1
fi
