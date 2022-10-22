#!/bin/bash

# inputs :
#   - $1 : java project path
#   - $2 : mvn virtual
#   - $3 : docker virtual
#   - $4 : server ID
#   - $3 : docker user
#   - $4 : docker path

cd $1
jf c use $4

# MVN BUILD
bname=java-webapp

jf mvnc \
    --server-id-resolve=$4 \
    --repo-resolve-releases=$2	\
    --repo-resolve-snapshots=$2	\
    --server-id-deploy=$4 \
    --repo-deploy-releases=$2 \
    --repo-deploy-snapshots=$2

jf mvn clean install -f src/  \
    --no-transfer-progress \
    --build-name=$bname --build-number=1 

# Collect environment variables for the build
jf rt bce $bname 1 
# Collect VCS details from git and add them to the build
jf rt bag $bname 1 
# Publish build info
jf rt bp $bname 1 


### DOCKER BUILD
echo "[DOCKER] Preparations ..."

docker_reg=`jf c s $4 | grep platform | tr -d "[:space:]" | cut -d'/'  -f3`
docker_tag=$docker_reg/$3/java-webapp:3.0.0

echo "[DOCKER] registry :  $docker_reg"
echo "[DOCKER] image tag : $docker_tag"

cd $1/src
cp $1/src/application/target/*application*.jar multi-module-application.jar

echo "[DOCKER] Logging on $docker_reg/$3 ..."
docker login $docker_reg/$3 --username "$5" --password "$6"

echo "[DOCKER] building  ..."
docker build \
    --build-arg REGISTRY=$docker_reg \
    --build-arg DOCKER_REPO=$3 \
    -t $docker_tag \
    .
jf docker push $docker_tag \
    --build-name=docker-$bname --build-number=1

jf rt bad docker-$bname 1  multi-module-application.jar
jf rt bce docker-$bname 1 
jf rt bag docker-$bname 1 
jf rt bp docker-$bname 1 

