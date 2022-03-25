#!/bin/sh

yq r $SCRIPT_DIR/lab-1/repo-conf-creation-main.yaml -j | jq -r '.[]|keys[]' |
while read -r repo_id; do
    curl -X PUT https://$JFROG_PLATFORM/access/api/v1/projects/_/share/repositories/$repo_id/su115 -H "accept: application/json" -H "Authorization: Bearer ${token}"
done