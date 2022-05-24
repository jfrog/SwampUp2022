#!/usr/bin/env sh

echo "START : Index Repositories for Xray : "
jf xr curl -XPUT /api/v1/binMgr/1/repos -H "Content-Type: application/json" -d @../json/lab1-index-repos.json
echo "\nCOMPLETE : Index Repositories for Xray"

echo "START : Index Builds for Xray : "
jf xr curl -XPUT /api/v1/binMgr/1/builds -H "Content-Type: application/json" -d @../json/lab1-index-builds.json
echo "\nCOMPLETE : Index Builds for Xray"


echo "START : Create Security Critical Policies"
jf xr curl -XPOST /api/v2/policies -H "Content-Type: application/json" -d @../json/lab1-prod-sec-policy.json
echo "\nCOMPLETE : Create Security Critical Policies"

echo "START : Create License Policies"
jf xr curl -XPOST /api/v2/policies -H "Content-Type: application/json" -d @../json/lab1-prod-lic-policy.json
echo "\nCOMPLETE : Create License Policies"
