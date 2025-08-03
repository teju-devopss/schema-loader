#We assume we get the following variables from K8S
#COMPONENT
#SCHEMA_TYPE

mkdir /app
cd /app
git clone https://github.com/teju-devopss/$COMPONENT .

source /parameters/params

if ["$SCHEMA_TYPE" == 'mongo' ]; then
mongosh dev-roboshop-docdb.cluster-cqxq6884ocuz.us-east-1.docdb.amazonaws.com:27017 --tls --tlsCAFile global-bundle.pem --retryWrites=false --username admin1 --password <insertYourPassword>
fi