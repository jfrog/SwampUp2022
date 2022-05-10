#!/usr/bin/env sh

echo "Configuration name for CLI (unique name) : "
read -r CLIName
export CLI_NAME=${CLIName}

jf config use $CLI_NAME
echo "\nJfrog is accessible check : "
jf rt ping

echo "START : Delete Watches : "
jf xr curl -XDELETE /api/v2/watches/swampup22_dev_watch
jf xr curl -XDELETE /api/v2/watches/swampup22_secops_watch
echo "\nComplete : Delete Watches : "


echo "START : Delete Policies : "
jf xr curl -XDELETE api/v2/policies/lic_policy
jf xr curl -XDELETE api/v2/policies/sec_policy
jf xr curl -XDELETE api/v2/policies/sec_critical_policy
echo "\nComplete : Delete Policies : "


echo "START : Non-Index Repositories for Xray : "
jf xr curl -XPUT /api/v1/binMgr/1/repos -H "Content-Type: application/json" -d @json/non-index-repos.json
echo "\nCOMPLETE : Non-Index Repositories for Xray"

echo "START : Non-Index Builds for Xray : "
jf xr curl -XPUT /api/v1/binMgr/1/builds -H "Content-Type: application/json" -d @json/non-index-builds.json
echo "\nCOMPLETE : Non-Index Builds for Xray"

echo "START : Delete Builds : "
jf rt curl -XPOST /api/build/delete -H "Content-Type: application/json" -d @json/delete-maven-build.json
jf rt curl -XPOST /api/build/delete -H "Content-Type: application/json" -d @json/delete-npm-build.json
echo "\nComplete : Delete Builds : "

echo "START : Delete Repositories : "
jf rt curl -XDELETE /api/repositories/s003-libs-release-local
jf rt curl -XDELETE /api/repositories/s003-libs-snapshot-local
jf rt curl -XDELETE /api/repositories/s003-maven-jcenter
jf rt curl -XDELETE /api/repositories/s003-libs-snapshot
jf rt curl -XDELETE /api/repositories/s003-libs-release
jf rt curl -XDELETE /api/repositories/s003-npm-local
jf rt curl -XDELETE /api/repositories/s003-npm-remote
jf rt curl -XDELETE /api/repositories/s003-npm
echo "\nComplete : Delete Repositories : "
