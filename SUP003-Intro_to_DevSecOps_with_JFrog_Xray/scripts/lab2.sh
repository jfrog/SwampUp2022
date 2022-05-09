#!/usr/bin/env sh
echo "Enter CLI Configuration name created during JFrog CLI Installation"
read -r CLIName
export CLI_NAME=${CLIName}

jf config use $CLI_NAME

echo "START : Create Watches"
jf xr curl -XPOST /api/v2/watches -H "Content-Type: application/json" -d @json/lab2-watch-general.json
echo "\nCOMPLETE : Create Watches"

echo "START : Create Critical Watches"
jf xr curl -XPOST /api/v2/watches -H "Content-Type: application/json" -d @json/lab2-watch-critical.json
echo "\nCOMPLETE : Create Critical Watches"