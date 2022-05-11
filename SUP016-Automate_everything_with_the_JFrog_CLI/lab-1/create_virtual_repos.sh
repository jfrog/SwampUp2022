for row in $(cat ./virtual-repos.json | jq -r '.[] | @base64'); do
    _jq() {
      echo ${row} | base64 --decode | jq -r ${1}
    }

    jf rt repo-create template-virtual-rescue.json --vars "repo-name=$(_jq '.key');package-type=$(_jq '.packageType');repo-type=$(_jq '.rclass');repo-layout=$(_jq '.repoLayoutRef');deploy-repo-name=$(_jq '.defaultDeploymentRepo');external-remote-repo-name=$(_jq '.externalDependenciesRemoteRepo');repos=$(_jq '.repositories')"
done