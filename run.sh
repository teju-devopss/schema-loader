## We assume we get the following variables from K8S
## COMPONENT
## SCHEMA_TYPE
#
#mkdir /app
## shellcheck disable=SC2164
#cd /app
#git clone https://github.com/teju-devopss/$COMPONENT .
#
#source /parameters/params
#
#if [ "$SCHEMA_TYPE" == "mongo" ]; then
#  curl -L -O https://truststore.pki.rds.amazonaws.com/global/global-bundle.pem
##  mongo --ssl --host $DOCDB_ENDPOINT:27017 --sslCAFile global-bundle.pem --username $DOCDB_USER --password $DOCDB_PASS < /app/schema/$COMPONENT.js
#  mongo --tls --host $DOCDB_ENDPOINT:27017 --tlsCAFile global-bundle.pem --username $DOCDB_USER --password $DOCDB_PASS </app/schema/$COMPONENT.js
#fi
#
#if [ "$SCHEMA_TYPE" == "mysql" ]; then
#  mysql -h "$DB_HOST" -u"$DB_USER" -p"$DB_PASS" </app/schema/$COMPONENT.sql
#fi

#!/bin/bash
set -e

echo "📥 Cloning schema repo for component: $COMPONENT"
mkdir -p /app
cd /app
git clone https://github.com/teju-devopss/$COMPONENT .
echo "✅ Repo cloned."

# Load DB connection parameters
if [ -f /parameters/params ]; then
  echo "🔹 Loading DB parameters from /parameters/params"
  cat /parameters/params
  source /parameters/params
else
  echo "❌ Parameters file missing in /parameters"
  exit 1
fi

# Check required env vars
if [ -z "$COMPONENT" ] || [ -z "$SCHEMA_TYPE" ]; then
  echo "❌ COMPONENT or SCHEMA_TYPE is not set"
  exit 1
fi

if [ "$SCHEMA_TYPE" == "mongo" ]; then
  echo "⚙️ Running Mongo schema load"
  curl -L -O https://truststore.pki.rds.amazonaws.com/global/global-bundle.pem
  mongo --tls --host "$DOCDB_ENDPOINT:27017" --tlsCAFile global-bundle.pem \
        --username "$DOCDB_USER" --password "$DOCDB_PASS" \
        </app/schema/$COMPONENT.js
fi

if [ "$SCHEMA_TYPE" == "mysql" ]; then
  echo "⚙️ Running MySQL schema load"
  if [ ! -f "/app/schema/$COMPONENT.sql" ]; then
    echo "❌ Schema file /app/schema/$COMPONENT.sql not found"
    exit 1
  fi
  mysql -h "$DB_HOST" -u"$DB_USER" -p"$DB_PASS" </app/schema/$COMPONENT.sql
fi

echo "✅ Schema load completed."
