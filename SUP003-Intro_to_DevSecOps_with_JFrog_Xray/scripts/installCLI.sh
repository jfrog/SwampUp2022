#!/usr/bin/env sh

#################
# init process #
#################
curl -fL https://install-cli.jfrog.io | sh
echo "Configuration name for CLI (unique name) : "
read -r CLIConfigName
export CLI_CONFIG_NAME=${CLIConfigName}

echo "Jfrog instance Name (copy instancename from host - https://{{instancename}}.jfrog.io/): "
read -r instancename 
export INSTANCE_NAME=${instancename}

echo "Jfrog instance username : "
read -r username
export INSTANCE_USERNAME=${username}

echo "Jfrog API Key (Generate API Key from - Edit Profile > Authentication Settings > API Key) : "
read -r apikey
export API_KEY=${apikey}

echo "Jfrog is accessible check : "
jf rt ping --url=http://$INSTANCE_NAME.jfrog.io/artifactory

jf config add $CLI_CONFIG_NAME --user $INSTANCE_USERNAME --password $API_KEY --artifactory-url https://$INSTANCE_NAME.jfrog.io/artifactory --xray-url https://$INSTANCE_NAME.jfrog.io/xray/ --interactive=false

jf config use $CLI_CONFIG_NAME

echo "Make note of configuration name: " $CLI_CONFIG_NAME " which will be used for later CLI commands"

jf config show $CLI_CONFIG_NAME
