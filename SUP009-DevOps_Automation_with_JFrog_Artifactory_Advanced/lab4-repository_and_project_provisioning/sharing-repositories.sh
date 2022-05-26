#!/bin/sh

yq e $SCRIPT_DIR/lab4-repository_and_project_provisioning/repo-conf-creation-main.yaml -o=j -I=0 |  jq -r '.[]|keys[]' |
while read -r repo_id; do
    curl -X PUT https://$ARTIFACTORY_HOSTNAME/access/api/v1/projects/_/share/repositories/$repo_id/su115 -H "accept: application/json" -H "Authorization: Bearer ${ARTIFACTORY_ACCESS_TOKEN}"
done
