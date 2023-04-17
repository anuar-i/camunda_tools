#!/bin/bash

FILES_DIR=$(pwd)
CAMUNDA_DEPLOYMENT_URL=http://172.25.43.101:10201/engine-rest/deployment/create

for file in $FILES_DIR/*.bpmn; do
    filename=$(basename -- "$file")
    directory=$(dirname -- "$file")
	curl $CAMUNDA_DEPLOYMENT_URL\
		-H "Content-Type: multipart/form-data" \
		-F "deployment-name="$filename \
		-F "deployment-source="$filename \
		-F 'deploy-changed-only=true' \
		-F "opload=@\"$directory/$filename\""
	#check result
	if [ $? -eq 0 ]; then
 	 echo -e "\n\e[32mProcess defenition deployed: \e[0m" -$filename
	else
	  echo -e "\n\e[31mError:Curl command failed. \e[0m" -$filename
	fi
done

for file in $FILES_DIR/*.dmn; do
    filename=$(basename -- "$file")
    directory=$(dirname -- "$file")
	curl $CAMUNDA_DEPLOYMENT_URL\
		-H "Content-Type: multipart/form-data" \
		-F "deployment-name="$filename \
		-F "deployment-source="$filename \
		-F 'deploy-changed-only=true' \
		-F "opload=@\"$directory/$filename\""		
 	#check result
	if [ $? -eq 0 ]; then
 	 echo -e "\n\e[32mBusiness rule deployed: \e[0m" -$filename
	else
	  echo -e "\n\e[31mError:Curl command failed. \e[0m" -$filename
	fi
done
