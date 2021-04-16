#!/bin/sh

if [ ! -f conf/env.properties ]
then
  export $(cat conf/env.properties | sed 's/#.*//g' | xargs)
fi

currentDir=$PWD
APIM_CLI_VERSION="${APIM_CLI_VERSION:=1.3.6}"
CLI_DIR=$currentDir/../apim-cli
BACKEND_HOST="${BACKEND_HOST:=http://localhost:8280}"
APIMANAGER_HOST="${APIMANAGER_HOST:=localhost}"
APIMANAGER_USER="${APIMANAGER_USER:=apiadmin}"
APIMANAGER_PASS="${APIMANAGER_PASS:=changeme}"

if [ ! -d "$CLI_DIR/apim-cli-$APIM_CLI_VERSION" ]; then
    mkdir $CLI_DIR
    wget -qO- https://github.com/Axway-API-Management-Plus/apim-cli/releases/download/apimcli-$APIM_CLI_VERSION/axway-apimcli-$APIM_CLI_VERSION.tar.gz | tar xvfz  - -C $CLI_DIR
fi

CLI=$CLI_DIR/apim-cli-$APIM_CLI_VERSION/scripts/apim.sh

echo "Using backend host: $BACKEND_HOST for API-Mock ups"


# Import all organizations
cd $currentDir/apim-cli-data/Organizations
for orgDirectory in `find . -mindepth 1 -type d`
do
    echo "Import organization from config: $orgDirectory"
    $CLI org import -c $currentDir/apim-cli-data/Organizations/$orgDirectory/org-config.json
done

# Import all applications
cd $currentDir/apim-cli-data/ClientApps
for appDirectory in `find . -mindepth 1 -type d`
do
    echo "Import applicaton from config directory: $appDirectory"
    $CLI app import -c $currentDir/apim-cli-data/ClientApps/$appDirectory/application-config.json
done

# Import all APIs
cd $currentDir/apim-cli-data/APIs
for apiDirectory in `find . -mindepth 1 -type d`
do
    echo "Import API from config directory: $apiDirectory"
    $CLI api import -c $currentDir/apim-cli-data/APIs/$apiDirectory/api-config.json - force
done

exit
