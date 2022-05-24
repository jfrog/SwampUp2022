for row in $(cat ./repos-for-push.json | jq -r '.[] | @base64'); do
    _jq() {
      echo ${row} | base64 --decode | jq -r ${1}
    }

    jf rt rplc template-push-rescue.json --vars "repo-name=$(_jq '.key');target-server-id=$(_jq '.targetServerId');target-repo-key=$(_jq '.targetRepoKey')"
done