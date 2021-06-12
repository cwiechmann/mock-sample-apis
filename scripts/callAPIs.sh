#!/bin/sh

export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$HOME/Axway-7.7.0/apigateway/Linux.x86_64/lib

apis[0]=GET#/petstore/v2/pet/findByStatus?status=pending#KeyId:6cd55c27-675a-444a-9bc7-ae9a7869184d
apis[1]=GET#/petstore/v2/pet/findByStatus?status=sold#KeyId:6cd55c27-675a-444a-9bc7-ae9a7869184d
apis[2]=GET#/petstore/v2/store/inventory#KeyId:6cd55c27-675a-444a-9bc7-ae9a7869184d
apis[3]=GET#/petstore/v2/user/Chris#KeyId:6cd55c27-675a-444a-9bc7-ae9a7869184d
apis[4]=GET#/petstore/v2/pet/58914657#KeyId:6cd55c27-675a-444a-9bc7-ae9a7869184d
apis[5]=GET#/petstore/v2/user/login?username=chris&password=changeme#KeyId:6cd55c27-675a-444a-9bc7-ae9a7869184d
apis[6]=GET#/api/emr/diagnostic#Dummy:Header
apis[7]=GET#/careplan/CarePlan#KeyId:93ff2c6d-a257-4c73-93ea-ab1be8e55b43
apis[8]=GET#/api/ins/check#KeyId:47b01f8e-c955-4aec-a426-9824086e46dc
apis[9]=GET#/api/hl7/module/verif#"Authorization:Basic YmEyYmRlNTItOTYwNC00MTY1LTk1ZmEtZWNkMjhhMzY3NWMwOjQ1YWViNWUxLTU4NDgtNGRmMS1hM2QzLWI1YWYyNjJlOWQyZg=="
apis[10]=GET#/device/Device/_search#KeyId:93ff2c6d-a257-4c73-93ea-ab1be8e55b43
apis[11]=GET#/device/Device/_search#KeyId:71b7fe58-e0b3-413a-b1cb-39a185334d06
apis[12]=GET#/device/Device/_search#KeyId:ba2bde52-9604-4165-95fa-ecd28a3675c0
apis[13]=GET#/api/greet/greet?username=Chris#KeyId:ba2bde52-9604-4165-95fa-ecd28a3675c0
apis[14]=GET#/api/greet/greet?username=Axway#KeyId:6cd55c27-675a-444a-9bc7-ae9a7869184d
apis[15]=GET#/api/greet/greet?username=Axway#KeyId:6cd55c27-675a-444a-9bc7-ae9a7869184d
apis[16]=GET#/api/greet/greet?username=Axway#KeyId:6cd55c27-675a-444a-9bc7-ae9a7869184d
apis[17]=GET#/api/emr/surgery#Dummy:Header

while [ true ]
do
	test $? -gt 128 && break;
	apiNo=`shuf -i1-17 -n1`
	#apiNo=13
	echo "Using API-No: $apiNo"
	verb=$(echo ${apis[${apiNo}]} | cut -f1 -d#)
	uri=$(echo ${apis[${apiNo}]} | cut -f2 -d#)
	header=$(echo ${apis[${apiNo}]} | cut -f3 -d#)
	echo "Calling API: $uri"
	echo "Header: $header"
	echo "Verb: $verb"
	set -x
	sr -d 5 -w 8 -qq https://localhost:8065${uri} -A "${header}" -v GET
	set +x

done