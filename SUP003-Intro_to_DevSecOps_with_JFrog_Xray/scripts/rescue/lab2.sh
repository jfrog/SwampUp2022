#!/usr/bin/env sh

echo "Configuration name for CLI (unique name) : "
read -r CLIConfigName
export CLI_CONFIG_NAME=${CLIConfigName}

jf config use $CLI_CONFIG_NAME

echo "START : Create Watches"
jf xr curl -XPOST /api/v2/watches -H "Content-Type: application/json" -d @../json/lab2-watch-general.json
echo "\nCOMPLETE : Create Watches"

echo "START : Create Critical Watches"
jf xr curl -XPOST /api/v2/watches -H "Content-Type: application/json" -d @../json/lab2-watch-critical.json
echo "\nCOMPLETE : Create Critical Watches"