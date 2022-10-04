#! /bin/sh

# $1 --> version. e.g. 4.0 or latest

if [[ $# -eq 0 ]] ; then
    echo '\nUsage ./build-docker [version number OR latest]'
    echo 'For example" ./build-docker 4.0 or ./build-docker latest\n\n'
    exit 1
fi

echo "\ndocker build --tag soleng.jfrog.io/sup003-docker-virtual/lab-runner-init:$1 ."
docker build --tag soleng.jfrog.io/sup003-docker-virtual/lab-runner-init:$1 .