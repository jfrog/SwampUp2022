for row in $(cat ./repos.json | jq -r '.[] | @base64'); do
    _jq() {
      echo ${row} | base64 --decode | jq -r ${1}
    }
    #echo "key:"$(_jq '.key')
    key=$(_jq '.key')
    packageType=$(_jq '.packageType')
    rclass=$(_jq '.rclass')
    repoLayoutRef=$(_jq '.repoLayoutRef')
    xrayIndex=$(_jq '.xrayIndex')
    jf rt repo-create template-local.json --vars "repo-name=$key;package-type=$packageType;rclass=$rclass;repoLayoutRef=$repoLayoutRef"
done