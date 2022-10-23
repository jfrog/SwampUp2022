#!/bin/bash

# inputs :
#   - $1 : platform url
#   - $2 : admin user
#   - $3 : admin pass
#   - $4 : server ID
#   - $5 : new username
#   - $6 : new pass

server_id=$4 
ci_created=false 

# install CLI in the current folder
#curl -fL -s https://getcli.jfrog.io/v2-jf | sh
#./jf --version

jf c rm $server_id --quiet

jf c s | grep $server_id > /dev/null

if [[ $? -ne 0 ]]; then 
    # configure CLI 
    jf c add $server_id  --interactive=false \
    --url="$1" --user="$2" --password="$3" 
fi 

jf rt ping --server-id $server_id

# RT - CONFIG
##### Create repositories
jf rt curl -XPATCH api/system/configuration -T rt/repositories.yml --server-id $server_id

#### Generate admin group
jf rt curl -XPUT  \
    -d '{ "name": "administrators", "description" : "created via automation", "adminPrivileges" : true}' \
    -H 'Content-Type: application/json' \
api/security/groups/administrators  --server-id $server_id

##### Generate ci user
password="`echo $RANDOM | shasum | cut -d" " -f1`L@Z"
jf rt user-create ci "${password}" "robot.doe@nobody.org" --server-id $server_id

if [[ $? -eq 0 ]]; then 
    #### Create Permission Targets
    jf rt ptu rt/ci_permissions.json --server-id $server_id
    ci_created=true 
fi

#### Generate user
jf rt user-create "$5" "$6" "$5@jfrog-training.com" --server-id $server_id
jf rt group-add-users administrators "$5" --server-id $server_id

# seems like a bug ... the previous command removes the admin privileges to the group
# forcing group to be admin 
jf rt curl -XPUT  \
    -d '{ "name": "administrators", "description" : "created via automation", "adminPrivileges" : true}' \
    -H 'Content-Type: application/json' \
api/security/groups/administrators  --server-id $server_id

# XRAY - CONFIG
##### Create policies 
for p in `ls xr/policy*`; do  
    jf xr curl -H "Content-Type: application/json" -XPOST api/v2/policies -T $p --server-id $server_id
done

##### Index build info 
jf xr curl -XPOST api/v1/binMgr/builds -H "Content-Type: application/json" \
    -d '{"names": ["java-webapp", "js-webapp","python-webapp","docker-java-webapp","docker-js-webapp","docker-python-webapp"]}' \
    --server-id $server_id

##### Create watches
for w in `ls xr/watch*`; do  
    jf xr curl -H "Content-Type: application/json" -XPOST api/v2/watches -T $w --server-id $server_id
done

# Configuring GHA requires to create 2 secrets : 
# A/ configure CLI
# B/ Docker registry

# A/ show the token for GHA
# jf_secret=`jf c export $server_id`

# echo "*********************************"
# echo "Use these secret(s) to run your Github Workflows :"
# echo -e "\t  - JF_SECRET : $jf_secret"

# # B/ show the ci user's password only if he was created
if [[ $ci_created == "true" ]]; then 
    echo -e "\t  - CI_SECRET : $password"
fi
# echo "*********************************"

