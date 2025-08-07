#!/bin/bash
set -e
set -x

# Load parameters from init container
source /parameters/params

# Clone schema repo
git clone https://github.com/teju-devopss/learn-kubernetes.git /app

cd /app/schema/${COMPONENT}

# Load schema based on SCHEMA_TYPE
if [ "$SCHEMA_TYPE" == "mongo" ]; then
  mongo --host ${DOCDB_ENDPOINT} -u ${DOCDB_USER} -p ${DOCDB_PASS} < ${COMPONENT}.js
elif [ "$SCHEMA_TYPE" == "mysql" ]; then
  mysql -h ${MYSQL_HOST} -u${MYSQL_USER} -p${MYSQL_PASSWORD} < ${COMPONENT}.sql
else
  echo "Unsupported schema type: $SCHEMA_TYPE"
  exit 1
fi

