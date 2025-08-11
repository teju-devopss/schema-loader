# We assume we get the following variables from K8S
# COMPONENT
# SCHEMA_TYPE

mkdir /app
cd /app
git clone https://github.com/raghudevopsb77/$COMPONENT .

source /parameters/params

if [ "$SCHEMA_TYPE" == "mongo" ]; then
  curl -L -O https://truststore.pki.rds.amazonaws.com/global/global-bundle.pem
#  mongo --ssl --host $DOCDB_ENDPOINT:27017 --sslCAFile global-bundle.pem --username $DOCDB_USER --password $DOCDB_PASS < /app/schema/$COMPONENT.js
  mongo --tls --host $DOCDB_ENDPOINT:27017 --tlsCAFile global-bundle.pem --username ${DOCDB_USER} --password $DOCDB_PASS </appschema/${COMPONENT}.js
fi

if [ "$SCHEMA_TYPE" == "mysql" ]; then
  mysql -h $DB_HOST -u$DB_USER -p$DB_PASS </app/schema/$COMPONENT.sql
fi