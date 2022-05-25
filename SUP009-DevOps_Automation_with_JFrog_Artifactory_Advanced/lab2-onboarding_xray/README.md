# swampup2022-SUP-009-DevOps Automation with JFrog Artifactory(Advanced) 
# Lab2 - Onboarding Xray tool

```bash
cd $SCRIPT_DIR/lab2-onboarding_xray
```
[Xray REST API Main Document](https://www.jfrog.com/confluence/display/JFROG/Xray+REST+API)

The Platform REST URL is constructed of: 
```bash
<JFrog URL>/<Service Context>/api/<API-Version>
```

### Using your JFrog URL 
```bash
http://myart.jfrog.io/xray/api/v1
```

### Using your Artifactory server hostname and the Artifactory router port
```bash
http://ARTIFACTORY_SERVER_HOSTNAME:8082/xray/api/v1
```

## 2.1 Indexing repos using Update Repository Configuration API 
-  We are going to use the [Update Repository Configuration API](https://www.jfrog.com/confluence/display/JFROG/Artifactory+REST+API#ArtifactoryRESTAPI-UpdateRepositoryConfiguration)

```bash
curl --location --request POST "https://${ARTIFACTORY_HOSTNAME}/artifactory/api/repositories/teamA-alpine-dev-local" \
--header "Authorization: Bearer ${ARTIFACTORY_ACCESS_TOKEN}" \
--header 'Content-Type: application/json' \
--data-raw '{
    "xrayIndex": "true"
}'
```

## 2.2 Check Repository Configuration 
- We are going to first check the repository configurations using [Get Repositories Configurations Artifactory API endpoint](https://www.jfrog.com/confluence/display/JFROG/Xray+REST+API#XrayRESTAPI-GetRepositoriesConfigurations)

```bash
curl --location --request GET "https://${ARTIFACTORY_HOSTNAME}/artifactory/api/repositories/teamA-alpine-dev-local" \
--header "Authorization: Bearer ${ARTIFACTORY_ACCESS_TOKEN}"
```
- Xray sepcific repository configuration can be retrieved using [Get Repositories Configurations Xray API endpoint](https://www.jfrog.com/confluence/display/JFROG/Xray+REST+API#XrayRESTAPI-GetRepositoriesConfigurations)
```bash
curl --location --request GET "https://${ARTIFACTORY_HOSTNAME}/xray/api/v1/repos_config/teamA-alpine-dev-local" \
--header "Authorization: Bearer ${ARTIFACTORY_ACCESS_TOKEN}"
```
NOTE: Xray API Authentication
Most REST API calls need to be authenticated using your user and password or using an access token. A few calls (such as SYSTEM calls) do not require authentication.

## 2.3 On-Demand Binary Scanning using JFrog CLI 
- Refer to the following document [Scan a Docker Image, All From Your Command-Line!](https://jfrog.com/xray-scan-cli/)for information on how to easily see vulnerabilities in your scan results of your Docker images or local files, in less than 3 minutes!
PRE-REQUISITE: Please make sure that docker daemon and client are running in your system 

```bash
jf docker scan nginx:latest
```


## 2.4 Dependencies scan using JFrog CLI 
- We will be usinf a sample NPM Project available [here](https://github.com/shayki5/npm-demo)
```bash
#Clone source code
git clone https://github.com/shayki5/npm-demo.git
#Initialize jf project to store system configuration
jf project init
#Install NPM project 
jf npm install
#Scan for dependencies with Xray 
jf audit
```

## 2.5 Bonus Section - More Shift left tools for Developers 
- Check out our latest [Docker Desktop Extension](https://jfrog.com/blog/get-peace-of-mind-about-security-when-deploying-containers-from-docker-desktop/) enabling you to scan your containers for security vulnerabilities
- If you have an IDE installed in your system. Try our [IDE plugins](https://www.jfrog.com/confluence/display/JFROG/IDE+Integration). We Support Eclipse, IntelliJ (Webstorm, PyCharm, Android Studio, GoLand), VSCode, Eclipse Theia and Visual Studio. 
- Get JFrog Xray to scan your every pull requests automatically [Frogbot: Securing your git repository](https://jfrog.com/screencast/frogbot-securing-your-git-repository/)
