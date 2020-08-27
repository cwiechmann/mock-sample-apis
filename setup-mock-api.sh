#!/bin/sh


if [ ! -d "$DIR" ]; then
    mkdir -p apim-cli
    wget -qO- https://github.com/Axway-API-Management-Plus/apim-cli/releases/download/apimcli-1.2.0-RC1/axway-apimcli-1.2.1.tar.gz | tar xvfz  - -C apim-cli
fi

export JAVA_HOME=/home/ec2-user/Axway-7.7.0/apigateway/Linux.x86_64/jre

./apim-cli/apim-cli-1.2.1/scripts/apim.sh app import -h localhost -u apiadmin -p changeme -c $PWD/apim-cli-data/Client-App/application-config.json

./apim-cli/apim-cli-1.2.1/scripts/apim.sh api import -h localhost -u apiadmin -p changeme -c $PWD/apim-cli-data/petstore-v2/api-config.json
