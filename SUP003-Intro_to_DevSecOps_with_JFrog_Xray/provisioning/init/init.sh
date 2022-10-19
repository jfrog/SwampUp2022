#!/bin/bash

server_id="jfrog-platform-training"
ci_created=false 

# install CLI in the current folder
curl -fL -s https://getcli.jfrog.io/v2-jf | sh
./jf --version

./jf c s | grep $server_id > /dev/null

if [[ $? -eq 0 ]]; then 
    echo "[ERROR] an existing profile $server_id already exists." 
    exit 1
fi 

# configure CLI 
./jf c add $server_id  --interactive=false \
    --url="$1" --user="$2" --password="$3" 
./jf rt ping --server-id $server_id

# RT - CONFIG
##### Create repositories
./jf rt curl -XPATCH api/system/configuration -T rt/repositories.yml --server-id $server_id
    
##### Generate a user
password="`echo $RANDOM | shasum | cut -d" " -f1`L@Z"
./jf rt user-create ci "${password}" "robot.doe@nobody.org" --server-id $server_id

if [[ $? -eq 0 ]]; then 
    #### Create Permission Targets
    ./jf rt ptu rt/ci_permissions.json --server-id $server_id
    ci_created=true 
fi

# XRAY - CONFIG
##### Create policies 
for p in `ls xr/policy*`; do  
    ./jf xr curl -H "Content-Type: application/json" -XPOST api/v2/policies -T $p --server-id $server_id
done

##### Index build info 
./jf xr curl -XPOST api/v1/binMgr/builds -H "Content-Type: application/json" -d '{"names": ["java-webapp-gha", "js-webapp-gha","python-webapp-gha","docker-java-webapp-gha","docker-js-webapp-gha","docker-python-webapp-gha"]}' --server-id $server_id

##### Create watches
for w in `ls xr/watch*`; do  
    ./jf xr curl -H "Content-Type: application/json" -XPOST api/v2/watches -T $w --server-id $server_id
done

# Configuring GHA requires to create 2 secrets : 
# A/ configure CLI
# B/ Docker registry

# A/ show the token for GHA
jf_secret=`./jf c export $server_id`

echo "*********************************"
echo "Use these secret(s) to run your Github Workflows :"
echo -e "\t  - JF_SECRET : $jf_secret"

# B/ show the ci user's password only if he was created
if [[ $ci_created == "true" ]]; then 
    echo -e "\t  - JF_CI_SECRET : $password"
fi
echo "*********************************"
echo "truc"