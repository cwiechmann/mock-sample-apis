#!/bin/sh

currentDir=$PWD
cliData=${currentDir}/apim-cli-data
APIM_CLI_VERSION="${APIM_CLI_VERSION:=1.3.10}"
CLI_DIR=$currentDir/apim-cli

if [ ! -d "$CLI_DIR/apim-cli-$APIM_CLI_VERSION" ]; then
    mkdir $CLI_DIR
    wget -qO- https://github.com/Axway-API-Management-Plus/apim-cli/releases/download/apimcli-$APIM_CLI_VERSION/axway-apimcli-$APIM_CLI_VERSION.tar.gz | tar xvfz  - -C $CLI_DIR
fi

CLI=$CLI_DIR/apim-cli-$APIM_CLI_VERSION/scripts/apim.sh

APIM_CLI_STAGE=$1
BACKEND_HOST=$2

if [ "$APIM_CLI_STAGE" == "" -o "$BACKEND_HOST" == "" ]; then
    echo "Missing APIM_CLI_STAGE. For example please call: ${currentDir}/setup-mock-apis.sh api-env \"http://mocked-apis:8280\""
    exit
fi

echo "Using backend host: $BACKEND_HOST for API-Mock ups"

export BACKEND_HOST


# Import all organizations
cd ${cliData}/Organizations || exit 99;
for orgDirectory in `find . -mindepth 1 -type d`
do
    echo "Import organization from config: $orgDirectory"
    $CLI org import -s ${APIM_CLI_STAGE} -c ${cliData}/Organizations/$orgDirectory/org-config.json
done

# Import all applications
cd ${cliData}/ClientApps || exit 99;
for appDirectory in `find . -mindepth 1 -type d`
do
    echo "Import applicaton from config directory: $appDirectory"
    $CLI app import -s ${APIM_CLI_STAGE} -c ${cliData}/ClientApps/$appDirectory/application-config.json
done

# Import all APIs
cd ${cliData}/APIs || exit 99;
for apiDirectory in `find . -mindepth 1 -type d`
do
    echo "Import API from config directory: $apiDirectory"
    $CLI api import -s ${APIM_CLI_STAGE} -c ${cliData}/APIs/$apiDirectory/api-config.json -force
done

exit