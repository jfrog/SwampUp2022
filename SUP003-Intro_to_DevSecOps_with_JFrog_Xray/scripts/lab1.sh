#!/usr/bin/env sh

echo "Configuration name for CLI (unique name) : "
read -r CLIName
export CLI_NAME=${CLIName}

jf config use $CLI_NAME

echo "START : Index Repositories for Xray : "
jf xr curl -XPUT /api/v1/binMgr/1/repos -H "Content-Type: application/json" -d @json/lab1-index-repos.json
echo "\nCOMPLETE : Index Repositories for Xray"

echo "START : Index Builds for Xray : "
jf xr curl -XPUT /api/v1/binMgr/1/builds -H "Content-Type: application/json" -d @json/lab1-index-builds.json
echo "\nCOMPLETE : Index Builds for Xray"

echo "START : Create Security Policies with rules"
jf xr curl -XPOST /api/v2/policies -H "Content-Type: application/json" -d @json/lab1-sec-policy.json
echo "\nCOMPLETE : Create Security Policies with rules"

echo "START : Create Security Critical Policies with rules"
jf xr curl -XPOST /api/v2/policies -H "Content-Type: application/json" -d @json/lab1-sec-critical-policy.json
echo "\nCOMPLETE : Create Security Critical Policies with rules"

echo "START : Create License Policies with rules"
jf xr curl -XPOST /api/v2/policies -H "Content-Type: application/json" -d @json/lab1-lic-policy.json
echo "\nCOMPLETE : Create License Policies with rules"