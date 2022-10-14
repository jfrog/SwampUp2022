jf c use s003

sh create_local_repos.sh
sh create_remote_repos.sh
sh create_virtual_repos.sh


RANDOM=$$
export BUILD_NUMBER=${RANDOM}

echo "Publish Dummy Build to Artifactory"
jf rt bp --build-url JFrog-CLI swampup22_s003_mvn_pipeline $BUILD_NUMBER
jf rt bp --build-url JFrog-CLI swampup22_s003_npm_pipeline $BUILD_NUMBER

