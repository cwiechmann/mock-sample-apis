#!/bin/sh

currentDir=$PWD
APIM_CLI_VERSION=1.2.1
CLI_DIR=$currentDir/apim-cli

if [ ! -d "$CLI_DIR/apim-cli-$APIM_CLI_VERSION" ]; then
    mkdir $CLI_DIR
    wget -qO- https://github.com/Axway-API-Management-Plus/apim-cli/releases/download/apimcli-$APIM_CLI_VERSION/axway-apimcli-$APIM_CLI_VERSION.tar.gz | tar xvfz  - -C $CLI_DIR
fi

CLI=$CLI_DIR/apim-cli-$APIM_CLI_VERSION/scripts/apim.sh

export JAVA_HOME=/home/ec2-user/Axway-7.7.0/apigateway/Linux.x86_64/jre


# Import all organizations
cd $currentDir/apim-cli-data/Organizations
for orgDirectory in `find . -mindepth 1 -type d`
do
    echo "Import organization from config: $orgDirectory"
    $CLI org import -h localhost -u apiadmin -p changeme -c $currentDir/apim-cli-data/Organizations/$orgDirectory/org-config.json
done

# Import all applications
cd $currentDir/apim-cli-data/ClientApps
for appDirectory in `find . -mindepth 1 -type d`
do
    echo "Import applicaton from config directory: $appDirectory"
    $CLI app import -h localhost -u apiadmin -p changeme -c $currentDir/apim-cli-data/ClientApps/$appDirectory/application-config.json
done

# Import all APIs
cd $currentDir/apim-cli-data/APIs
for apiDirectory in `find . -mindepth 1 -type d`
do
    echo "Import API from config directory: $apiDirectory"
    $CLI api import -h localhost -u apiadmin -p changeme -c $currentDir/apim-cli-data/APIs/$apiDirectory/api-config.json
done

exit
