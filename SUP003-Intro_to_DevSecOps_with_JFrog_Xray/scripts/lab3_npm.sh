#!/usr/bin/env sh

#################
# init process #
#################

#!/usr/bin/env sh

#################
# init process #
#################
cd ../npm-example
echo "Enter already create CLI Configuration name"
read -r CLIName
export CLI_NAME=${CLIName}

jf config use $CLI_NAME

echo -n "Jfrog is accessible check : "
jf rt ping


#Config Maven

jf npmc --repo-resolve s003-npm --repo-deploy s003-npm

RANDOM=$$
export BUILD_NUMBER=${RANDOM}

#Run NPM Build

jf npm install --build-name=swampup22_s003_npm_pipeline --build-number=$BUILD_NUMBER

jf npm publish --build-name=swampup22_s003_npm_pipeline --build-number=$BUILD_NUMBER


#Collect Environment Variables

jf rt bce swampup22_s003_npm_pipeline $BUILD_NUMBER

#Collect GIT Variables

jf rt bag swampup22_s003_npm_pipeline $BUILD_NUMBER ../../.

#Publish Build Info

jf rt bp swampup22_s003_npm_pipeline $BUILD_NUMBER

echo "START : Xray Scan"
jf bs swampup22_s003_npm_pipeline $BUILD_NUMBER
echo "COMPLETE : Xray Scan"