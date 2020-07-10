#!/bin/sh

export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$HOME/Axway-7.7.0/apigateway/Linux.x86_64/lib

# Reminder how to call SR
# ~/Axway-7.7.0/apigateway/Linux.x86_64/bin/sr -d 7200 -w 10 https://localhost:8065/petstore/v2/pet/findByStatus?status=pending -A KeyId:6cd55c27-675a-444a-9bc7-ae9a7869184d