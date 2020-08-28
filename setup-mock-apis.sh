#!/bin/sh


if [ ! -d "$DIR" ]; then
    mkdir -p apim-cli
    wget -qO- https://github.com/Axway-API-Management-Plus/apim-cli/releases/download/apimcli-1.2.1/axway-apimcli-1.2.1.tar.gz | tar xvfz  - -C apim-cli
fi

export JAVA_HOME=/home/ec2-user/Axway-7.7.0/apigateway/Linux.x86_64/jre

currentDir=$PWD

# Import all organizations
cd $currentDir/apim-cli-data/Organizations
for org in *.json
do
    ./apim-cli/apim-cli-1.2.1/scripts/apim.sh org import -h localhost -u apiadmin -p changeme -c $org
done

# Import all applications
cd $currentDir/apim-cli-data/ClientApps
for appDirectory in *.json
do
    ./apim-cli/apim-cli-1.2.1/scripts/apim.sh app import -h localhost -u apiadmin -p changeme -c $appDirectory/application-config.json
done

# Import all APIs
cd $currentDir/apim-cli-data/APIs
for apiDirectory in *.json
do
    ./apim-cli/apim-cli-1.2.1/scripts/apim.sh org import -h localhost -u apiadmin -p changeme -c $apiDirectory/api-config.json
done
