#!/usr/bin/env sh

#################
# init process #
#################
export CLI_INSTANCE_ID="my-instance"

jf config add "${CLI_INSTANCE_ID}" --user "${ARTIFACTORY_LOGIN}" --password "${ARTIFACTORY_API_KEY}" --artifactory-url https://${ARTIFACTORY_HOSTNAME}.jfrog.io/artifactory --xray-url https://${ARTIFACTORY_HOSTNAME}.jfrog.io/xray/ --interactive=false

jf config use "${CLI_INSTANCE_ID}"