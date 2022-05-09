#!/usr/bin/env sh

#################
# init process #
#################
curl -fL https://install-cli.jfrog.io | sh
echo -n "Configuration name for CLI (unique name) : "
read -r CLIName
export CLI_NAME=${CLIName}
echo -n "Make a note of this configuration name for further use"

echo -n "Jfrog instance Name (copy instancename from host - https://{{instancename}}.jfrog.io/): "
read -r instancename 
export INSTANCE_NAME=${instancename}

echo -n "Jfrog instance username : "
read -r username
export INSTANCE_USERNAME=${username}

echo -n "Jfrog API Key (Generate API Key from - Edit Profile > Authentication Settings > API Key) : "
read -r apikey
export APT_KEY=${apikey}

echo -n "Jfrog is accessible check : "
jf rt ping --url=http://$INSTANCE_NAME.jfrog.io/artifactory

echo -n
chmod +x jfrog
jf config add $CLI_NAME --artifactory-url https://$INSTANCE_NAME.jfrog.io/artifactory --user $INSTANCE_USERNAME --password $APT_KEY --interactive=false
