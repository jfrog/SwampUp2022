# Lab3 - Shift Left Security

## Prerequisites

- A SAAS Instance of JFrog. This will be provided as part of your enrollment to the Training class.
- Locally cloned Github [Project](https://github.com/jfrog/SwampUp2022/tree/main/SUP003-Intro_to_DevSecOps_with_JFrog_Xray/lab-3) where IDE is installed.
- Preferred IDE (Integrated Development Environment) like [Intellij](https://www.jetbrains.com/idea/download/#section=mac), [VSCode](https://code.visualstudio.com/download), [Eclipse](https://www.eclipse.org/downloads/)
- JFrog CLI is installed on your machine by running `jf -v`

## IDE Plugin

- Open one of the above IDE and install plugin/extension called `JFrog`.
- Configure plugin against the JFrog Platform by providing `JFrog Platform URL`, `Username`, `Password` or `Access Token`
- Open either `npm-vulnerable-example` or `maven-vulnerable-example` project from `project-examples`
  - Run `npm install` or `mvn clean install` (NOTE: make sure your native client is pointing to Artifactory instance to download dependencies)
- Open `JFrog` tab and review list of vulnerabilities

## Docker Desktop Extension [Optional]

- Download Docker Desktop application
- Install [JFrog Extension](https://hub.docker.com/extensions/jfrog/jfrog-docker-desktop-extension)
- Configure Extension pointing to your JFrog Platform instance
- More Information on [Docker Desktop Extension for JFrog Xray](https://jfrog.com/solution-sheet/docker-desktop-extension-for-jfrog-xray/)

## JFrog CLI : Build Scan (required C++ project)

```bash

mkdir cpp_lab
cd cpp_lab

# download cpp libs from 
jf rt dl jfrog-training/cpp/ .  \
  --url=https://yann.jfrog.io/artifactory \
  --access-token=$yannToken

# Crafting Build Info
## adding cpp libs to build info 
jf rt bad --server-id jfrog-training cpp_build 1 cpp/

## changing build type and id of each artifact
jq '.modules[] += {"type":"cpp"}' build_info.json |\
jq '.modules[].dependencies[] += {"type":"cpp"}'  |\
jq '(.modules[].dependencies[] | select(.id == "Poco.dll" ) | .id)     |= "poco:1.8.0"' |\
jq '(.modules[].dependencies[] | select(.id == "libcurl.dll" ) | .id)  |= "haxx:libcurl:7.70.0"' |\
jq '(.modules[].dependencies[] | select(.id == "sqlite.dll" ) | .id)   |= "sqlite:3.15.1"' |\
jq '(.modules[].dependencies[] | select(.id == "zlib.dll" ) | .id)     |= "zlib:1.2.0"' > build_info_xray.json

## generating the Build Info (JSON file)
jf rt bp --dry-run=true  cpp_build 1 > build_info.json

## publishing the Build Info
jf xr curl  api/v1/forceReindex  \
-XPOST \
-H "Accept: application/json" -H "Content-Type: application/json" \
-d '{"builds": [{"name": "cpp_build", "number": "1" }]}' \
--server-id jfrog-training
```


## JFrog CLI : Dependency scanning

```bash
cd SwampUp2022/SUP003-Intro_to_DevSecOps_with_JFrog_Xray/lab-3/project-examples

# Configure the CLI to wor with a client 
## for a JS project (containing a package.json)
## jf rt npmc
##
## for a Java project (containing a pom.xml)
## jf rt mvnc

# run the audit
jf audit --format=table
```

### EXERCISES

1. run the audit command to display the result in a JSON format
2. run the audit to list violations based on one or several polices

## On Demand scanning

```bash
cd SwampUp2022/SUP003-Intro_to_DevSecOps_with_JFrog_Xray/provisioning

# Configure the CLI to wor with a client 
## for a JS project (containing a package.json)
## jf rt npmc
##
## for a Java project (containing a pom.xml)
## jf rt mvnc

# run the scanning 
jf scan java-demo/src/multi-module-application.jar
jf docker scan sup011epsu<NUMBER>.jfrog.io/punch-docker/python-webapp:1.0.0
```

> More Information on [on-demand binary scan](https://www.jfrog.com/confluence/display/CLI/CLI+for+JFrog+Xray#CLIforJFrogXray-On-DemandBinaryScan)

### EXERCISES

1. run the on-demand command to display the result in a JSON format
2. run the on-demand command to list violations based on one or several polices