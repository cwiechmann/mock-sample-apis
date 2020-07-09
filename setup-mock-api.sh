#!/bin/sh

mkdir -p apim-cli

wget -qO- https://github.com/Axway-API-Management-Plus/apim-cli/releases/download/apimcli-1.2.0-RC1/axway-apimcli-1.2.0-SNAPSHOT.tar.gz | tar xvfz  - -C apim-cli

export JAVA_HOME=/home/ec2-user/Axway-7.7.0/apigateway/Linux.x86_64/jre

./apim-cli/apim-cli-1.2.0-SNAPSHOT/scripts/apim.sh api import -h localhost -u apiadmin -p changeme -c ../apim-cli-data/petstore-v2/api-config.json
