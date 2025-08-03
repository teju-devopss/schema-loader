#We assume we get the following variables from K8S
#COMPONENT
#SCHEMA_TYPE

mkdir /app
cd /app
git clone https://github.com/teju-devopss/$COMPONENT .

source /parameters/params

if [ "$SCHEMA_TYPE" == "mongo" ]; then
curl -L -O https://truststore.pki.rds.amazonaws.com/global/global-bundle.pem
mongosh $DOCDB_ENDPOINT:27017 --tls --tlsCAFile global-bundle.pem --retryWrites=false --username $DOCDB_USER --password $DOCDB_PASS </app/schema/$COMPONENT.js
fi