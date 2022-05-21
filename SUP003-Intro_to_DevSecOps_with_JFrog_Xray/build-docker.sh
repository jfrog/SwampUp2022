#! /bin/sh

# $1 --> version. e.g. 4.0 or latest
# Usage ./build-docker 4.0 or ./build-docker latest

echo "docker build --tag soleng.jfrog.io/sup003-docker-virtual/lab-runner-init:$1 ."

docker build --tag soleng.jfrog.io/sup003-docker-virtual/lab-runner-init:$1 .