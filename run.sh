##We assume we get the following variables from K8S
##COMPONENT
##SCHEMA_TYPE
#
#mkdir /app
#cd /app
#git clone https://github.com/teju-devopss/$COMPONENT .
#
#source /parameters/params
#
#if [ "$SCHEMA_TYPE" == "mongo" ]; then
#curl -L -O https://truststore.pki.rds.amazonaws.com/global/global-bundle.pem
#mongosh $DOCDB_ENDPOINT:27017 --tls --tlsCAFile global-bundle.pem --retryWrites=false --username $DOCDB_USER --password $DOCDB_PASS </app/schema/$COMPONENT.js
#fi
#
#if [ "$SCHEMA_TYPE" == "mysql" ]; then
#mysql -h $DB_HOST -u$DOCDB_USER -p$DOCDB_PASS </app/schema/$COMPONENT.sql
#fi


#!/bin/bash

# Clone component code
mkdir -p /app
cd /app
git clone https://github.com/teju-devopss/$COMPONENT .

# Load environment variables
source /parameters/params

if [ "$SCHEMA_TYPE" == "mongo" ]; then
  curl -L -O https://truststore.pki.rds.amazonaws.com/global/global-bundle.pem
  mongo $DOCDB_ENDPOINT:27017 --ssl --sslCAFile global-bundle.pem --username $DOCDB_USER --password $DOCDB_PASS </app/schema/$COMPONENT.js
fi

if [ "$SCHEMA_TYPE" == "mysql" ]; then
  mysql -h $DB_HOST -u$DOCDB_USER -p$DOCDB_PASS </app/schema/$COMPONENT.sql
fi
