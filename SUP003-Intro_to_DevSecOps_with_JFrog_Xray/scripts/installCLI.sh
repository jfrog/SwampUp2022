#!/usr/bin/env sh

#################
# init process #
#################
curl -fL https://install-cli.jfrog.io | sh
echo -n "Configuration name for CLI (unique name) : "
read -r CLIName
export CLI_NAME=${CLIName}

echo -n "Jfrog instance Name (copy instancename from host - https://{{instancename}}.jfrog.io/): "
read -r instancename 
export INSTANCE_NAME=${instancename}

echo -n "Jfrog instance username : "
read -r username
export INSTANCE_USERNAME=${username}

echo -n "Jfrog API Key (Generate API Key from - Edit Profile > Authentication Settings > API Key) : "
read -r apikey
export API_KEY=${apikey}

echo -n "Jfrog is accessible check : "
jf rt ping --url=http://$INSTANCE_NAME.jfrog.io/artifactory

echo -n
chmod +x jfrog
jf config add $CLI_NAME --user $INSTANCE_USERNAME --password $API_KEY --artifactory-url https://$INSTANCE_NAME.jfrog.io/artifactory --xray-url https://$INSTANCE_NAME.jfrog.io/xray/ --interactive=false

jf config use $CLI_NAME

echo -n "Make note of configuration name: " $CLI_NAME " which will be used for later CLI commands"

jf config show $CLI_NAME
