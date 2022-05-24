#!/usr/bin/env sh


echo "START : Create Watch"
jf xr curl -XPOST /api/v2/watches -H "Content-Type: application/json" -d @../json/lab2-prod-watch.json
echo "\nCOMPLETE : Create Watch"
