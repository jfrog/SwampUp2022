#!/usr/bin/env sh

echo "Configuration name for CLI (unique name) : "
read -r CLIName
export CLI_NAME=${CLIName}

jf config use $CLI_NAME
echo "Jfrog is accessible check : "
jf rt ping

echo "START : Create local Repository in JFrog Artifactory"
jf rt repo-create ./json/npm-local.json
jf rt repo-create ./json/mvn-snapshot-local.json
jf rt repo-create ./json/mvn-release-local.json
echo "\nCOMPLETE : Create local Repository in JFrog Artifactory"

echo "START: Create remote Repository in JFrog Artifactory"
jf rt repo-create ./json/npm-remote.json
jf rt repo-create ./json/mvn-remote.json
echo "\nCOMPLETE : Create remote Repository in JFrog Artifactory"

echo "START: Create virtual Repository in JFrog Artifactory"
jf rt repo-create ./json/npm-virtual.json
jf rt repo-create ./json/mvn-snapshot-virtual.json
jf rt repo-create ./json/mvn-release-virtual.json
echo "\nCOMPLETE : Create remote Repository in JFrog Artifactory"

RANDOM=$$
export BUILD_NUMBER=${RANDOM}

echo "Publish Dummy Build to Artifactory"
jf rt bp --build-url JFrog-CLI swampup22_s003_mvn_pipeline $BUILD_NUMBER
jf rt bp --build-url JFrog-CLI swampup22_s003_npm_pipeline $BUILD_NUMBER
