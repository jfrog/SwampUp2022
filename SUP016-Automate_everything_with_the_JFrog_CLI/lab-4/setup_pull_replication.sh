for row in $(cat ./repos-for-pull.json | jq -r '.[] | @base64'); do
    _jq() {
      echo ${row} | base64 --decode | jq -r ${1}
    }

    jf rt rplc template-pull-rescue.json --vars "repo-name=$(_jq '.key');url=$(_jq '.url')"
done