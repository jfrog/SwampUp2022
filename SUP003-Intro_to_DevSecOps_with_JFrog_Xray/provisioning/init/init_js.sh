#!/bin/bash

# inputs :
#   - $1 : js project path
#   - $2 : js virtual
#   - $3 : docker virtual
#   - $4 : server ID
#   - $5 : docker user
#   - $6 : docker pass
#   - $7 : generic virtual

cd $1
jf c use $4

# JS BUILD
bname=js-webapp
webapp_tarball=webapp.tar.gz

jf npm-config \
    --repo-resolve $2 \
    --server-id-resolve $4 \
    -global=true

jf npm install --module=node_webapp \
    --build-name=$bname --build-number=1 


npm run build && cd build
tar -czvf $webapp_tarball *

jf rt upload $webapp_tarball $7/ \
    --target-props "maturity=release-candidate;platform=windows,linux;test.unit=ready" \
    --module=node_webapp \
    --build-name=$bname --build-number=1 

# Collect environment variables for the build
jf rt bce $bname 1 
# Collect VCS details from git and add them to the build
jf rt bag $bname 1 
# Publish build info
jf rt bp $bname 1 

cd $1

### DOCKER BUILD
echo "[DOCKER] Preparations ..."

docker_reg=`jf c s $4 | grep platform | tr -d "[:space:]" | cut -d'/'  -f3`
docker_tag=$docker_reg/$3/js-webapp:1.0.0

echo "[DOCKER] registry :  $docker_reg"
echo "[DOCKER] image tag : $docker_tag"

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

jf rt bad docker-$bname 1  $webapp_tarball
jf rt bce docker-$bname 1 
jf rt bag docker-$bname 1 
jf rt bp docker-$bname 1 

