#! /bin/sh

# $1 --> version. e.g. 4.0 or latest

if [[ $# -eq 0 ]] ; then
    echo '\nUsage ./push-docker [version number OR latest]'
    echo 'For example" ./push-docker 4.0 or ./push-docker latest\n\n'
    exit 1
fi

echo "\ndocker push soleng.jfrog.io/sup003-docker-virtual/lab-runner-init:$1"
docker push soleng.jfrog.io/sup003-docker-virtual/lab-runner-init:$1 