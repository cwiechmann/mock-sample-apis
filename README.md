# mock-sample-apis
 Mocks a number of APIs using API-Builder

To install the API-Builder Mock-Server in a K8S-Cluster using Helm:

```
helm install -n apim mocked-apis https://github.com/cwiechmann/mock-sample-apis/releases/download/v0.0.8/helm-chart-mock-sample-apis-v0.0.8.tgz
```

Call the APIs in the background:
```
nohup ./callAPI.sh /opt/Axway/apigateway https://traffic.axway-amplify-central.com >/dev/null 2>&1 &
```
