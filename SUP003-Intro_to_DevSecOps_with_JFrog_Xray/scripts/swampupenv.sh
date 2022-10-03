#! /bin/sh
#
# USAGE: e.g. source swampupenv.sh on mac
#

echo "Setting ARTIFACTORY_HOSTNAME"
export ARTIFACTORY_HOSTNAME="HOSTNAME"
#e.g. export ARTIFACTORY_HOSTNAME="HOSTNAME"

echo "Setting ARTIFACTORY_LOGIN"
export ARTIFACTORY_LOGIN="a@a.com"

echo "Setting ARTIFACTORY_API_KEY"
export ARTIFACTORY_API_KEY="PASSWORD"


echo "\nPrinting Values"
echo $ARTIFACTORY_HOSTNAME
echo $ARTIFACTORY_LOGIN
echo $ARTIFACTORY_API_KEY
