#!/usr/bin/env sh

#################
# init process #
#################

#!/usr/bin/env sh

#################
# init process #
#################

#echo "Configuration name for CLI (unique name) : "
#read -r CLIConfigName

export CLI_INSTANCE_ID=s003

jf config use $CLI_INSTANCE_ID

cd ../../lab-3/project-example/maven-vulnerable-example

echo "Jfrog is accessible check : "
jf rt ping

#Config Maven

jf mvnc --repo-resolve-snapshots s003-libs-snapshot --repo-resolve-releases s003-libs-release --repo-deploy-snapshots s003-libs-snapshot --repo-deploy-releases s003-libs-release

RANDOM=$$
export BUILD_NUMBER=${RANDOM}

#Run Maven Build

jf mvn clean install -Dmaven.test.skip=true -Dartifactory.publish.artifacts=true --build-name=swampup22_s003_mvn_pipeline --build-number=$BUILD_NUMBER

#Collect Environment Variables

jf rt bce swampup22_s003_mvn_pipeline $BUILD_NUMBER

#Collect GIT Variables

#jf rt bag swampup22_s003_mvn_pipeline $BUILD_NUMBER ../../.

#Publish Build Info

jf rt bp --build-url JFrog-CLI swampup22_s003_mvn_pipeline $BUILD_NUMBER

echo "START : Xray Scan"
jf bs swampup22_s003_mvn_pipeline $BUILD_NUMBER
echo "COMPLETE : Xray Scan"
