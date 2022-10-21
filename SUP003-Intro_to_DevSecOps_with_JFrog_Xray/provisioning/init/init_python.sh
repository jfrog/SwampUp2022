#!/bin/bash

# inputs :
#   - $1 : python project path
#   - $2 : python virtual
#   - $3 : docker virtual
#   - $4 : server ID
#   - $5 : docker user
#   - $6 : docker path
#   - $7 : generic virtual

cd $1

# Python BUILD
bname=python-webapp
webapp_tarball=webapp_python_1.0.0.tar.gz

jf pip-config \
    --repo-resolve $1 \
    --server-id-resolve $4 \
    -global=true

jf pip install --module=python_webapp

tar -czvf $webapp_tarball *.yaml *.txt *.py
jf rt upload $webapp_tarball $7/ \
    --target-props "maturity=release-candidate;platform=windows,linux;test.unit=ready" \
    --module=python_webapp \
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
docker_tag=$docker_reg/$3/python-webapp:1.0.0

echo "[DOCKER] registry :  $docker_reg"
echo "[DOCKER] image tag : $docker_tag"

echo "[DOCKER] Logging on $docker_reg/$3 ..."
docker login $docker_reg/$3 --username "$5" --password "$6"

echo "[DOCKER] building  ..."
docker build \
    --build-args REGISTRY=$docker_reg \
    --build-args DOCKER_REPO=$3 \
    --build-args RT_USER=$5 \
    --build-args RT_TOKEN=$6 \
    --build-args PYTHON_REPO=$1 \
    -t $docker_tag
    .

jf docker push $docker_tag \
    --build-name=docker-$bname --build-number=1

jf rt bad docker-$bname 1  $webapp_tarball
jf rt bce docker-$bname 1 
jf rt bag docker-$bname 1 
jf rt bp docker-$bname 1 

