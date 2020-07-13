#!/bin/sh

export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$HOME/Axway-7.7.0/apigateway/Linux.x86_64/lib

# Reminder how to call SR - Delay 10ms send from two instance results into ap. 150 TPS
# On API-GW 1
# ~/Axway-7.7.0/apigateway/Linux.x86_64/bin/sr -d 14000 -w 8 -qq https://localhost:8065/petstore/v2/pet/findByStatus?status=pending -A KeyId:6cd55c27-675a-444a-9bc7-ae9a7869184d

# On API-GW 2
# ~/Axway-7.7.0/apigateway/Linux.x86_64/bin/sr -d 14000 -w 8 -qq https://localhost:8065/petstore/v2/store/inventory -A KeyId:6cd55c27-675a-444a-9bc7-ae9a7869184d

# On API-GW 3
# ~/Axway-7.7.0/apigateway/Linux.x86_64/bin/sr -d 14000 -w 8 -qq https://localhost:8065/petstore/v2/user/Chris -A KeyId:6cd55c27-675a-444a-9bc7-ae9a7869184d

# On API-GW 4
# ~/Axway-7.7.0/apigateway/Linux.x86_64/bin/sr -d 14000 -w 8 -qq https://localhost:8065/petstore/v2/pet/58914657 -A KeyId:6cd55c27-675a-444a-9bc7-ae9a7869184d

# On API-GW 5
# ~/Axway-7.7.0/apigateway/Linux.x86_64/bin/sr -d 14000 -w 8 -qq https://localhost:8065/petstore/v2/pet/58914657 -A KeyId:6c55c27-675a-444a-9bc7-ae9a7869184d

# On API-GW 6
# ~/Axway-7.7.0/apigateway/Linux.x86_64/bin/sr -d 14000 -w 8 -qq https://api-env:8065/petstore/v2/user/login?username=chris&password=changeme -A KeyId:6cd55c27-675a-444a-9bc7-ae9a7869184d