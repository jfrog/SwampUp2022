#! /bin/sh
docker run --name sup003 --rm --env ARTIFACTORY_HOSTNAME="${ARTIFACTORY_HOSTNAME}" --env ARTIFACTORY_LOGIN="${ARTIFACTORY_LOGIN}" --env ARTIFACTORY_API_KEY="${ARTIFACTORY_API_KEY}" -it -v "/var/run/docker.sock:/var/run/docker.sock" soleng.jfrog.io/sup003-docker-virtual/lab-runner-init:latest /bin/bash
