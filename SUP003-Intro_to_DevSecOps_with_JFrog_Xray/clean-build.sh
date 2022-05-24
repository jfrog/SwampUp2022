#! /bin/sh
echo "\nCleaning maven-vulnerable-example build"
cd project-examples/maven-vulnerable-example
mvn clean

echo "\n\nCleaning maven-fixed-example build"
cd ../maven-fixed-example
mvn clean


echo "\n\nCleaning npm-fixed-example build"
cd ../npm-fixed-example
rm -rf node_modules
rm -f package-lock.json


echo "\n\nCleaning npm-fixed-vulnerable build"
cd ../npm-vulnerable-example
rm -rf node_modules
rm -f package-lock.json
