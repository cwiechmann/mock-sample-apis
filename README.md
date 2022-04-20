# Mock Example APIs

This project mocks a number of APIs using Axway API-Builder, which are registered before into the API-Manager using the [APIM-CLI](https://github.com/Axway-API-Management-Plus/apim-cli). The APIs are simulating different response-codes, response-times and are using different Client-Applications.   

## Setup

### Custom-Properties

The Example APIs and Applications are using custom properties. Please configure them in your API-Manager before registering the APIs.

```
vi /opt/Axway/APIM/apigateway/webapps/apiportal/vordel/apiportal/app/app.config
```

Custom-Properties:
```
        application: {
            publicApp: {
                label: 'Public Application',
                required: true,
                help: "Controls if the Application is pulic. Public application cannot access private APIs.",
                type: "switch",
                options: [
                    {value: true, label: 'True'},
                    {value: false, label: 'False'}
                ]
            }
        },
        api: {
            // custom properties...
            publicAPI: {
                label: 'Public API',
                required: true,
                help: "Controls if the API is externally available",
                type: "switch",
                options: [
                    {value: true, label: 'True'},
                    {value: false, label: 'False'}
                ]
            },
            securityLevel: {
                label: 'Security level',
                required: true,
                help: "Is required for each API to set the appropriate level.",
                type: "select",
                options: [
                    {value: 'public', label: 'Public'},
                    {value: 'private', label: 'Private'},
                    {value: 'confidential', label: 'Confidential'}
                ]
            }
        }
```

A complete example: [app.config](https://github.com/cwiechmann/axway-api-management-automated/blob/main/gateway-config/apigateway/merge-dir/apigateway/webapps/apiportal/vordel/apiportal/app/app.config)

### Register APIs, Apps and Organizations

Clone the repository: 
```
git clone https://github.com/cwiechmann/mock-sample-apis.git
cd mock-sample-apis

# Adjust the api-env if required
# vi apim-cli/apim-cli-*/conf/env.api-env.properties

./scripts/setup-mock-apis.sh "-s api-env" "http://localhost:8280"

# When running in Kubernetes using the Service mocked-apis
# ./scripts/setup-mock-apis.sh "-s api-env" "http://mocked-apis:8280"
```

### API Mock-Service

To install the API-Builder Mock-Server in a K8S-Cluster using __Helm__:

```
helm install -n apim mocked-apis https://github.com/cwiechmann/mock-sample-apis/releases/download/v0.0.10/helm-chart-mock-sample-apis-v0.0.10.tgz
```

or using __docker-compose__:

```
git clone https://github.com/cwiechmann/mock-sample-apis.git
cd mock-sample-apis
docker-compose up -d
```

## Run API-Requests

Call the APIs using a background process. The script is using `sr`, therefore an API-Gatway must be installed on this machine.
```
git clone https://github.com/cwiechmann/mock-sample-apis.git
cd mock-sample-apis
nohup ./callAPIs.sh /opt/Axway/APIM/apigateway https://api-env:8065 >/dev/null 2>&1 &
```
