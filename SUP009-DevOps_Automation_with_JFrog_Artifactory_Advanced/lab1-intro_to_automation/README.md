# swampup2022-SUP-009-DevOps Automation with JFrog Artifactory(Advanced) 
# Lab1 - Intro to Automation Tools

```bash
cd cd $SCRIPT_DIR/lab1-intro_to_automation
```

## 1.1 Validate the environment variables before proceeding REST API

- Make sure to follow instructions in the previous section and validate the environemnt variables before proceeding

Base URL
The Platform REST URL is constructed of: 
```bash
<JFrog URL>/<Service Context>/
```

### Using your JFrog URL 
```bash
http://myjfrog.acme.org/artifactory/
```

### 1.2 Using your Artifactory server hostname and port
```bash
http://ARTIFACTORY_SERVER_HOSTNAME:8081/artifactory/
```

Please review the following examples on how to use REST API and JFrog CLI for [Deploying an Artifact](https://www.jfrog.com/confluence/display/JFROG/Artifactory+REST+API#ArtifactoryRESTAPI-Example-DeployinganArtifact)

## 1.3 Create your first repository using REST API 
- We are going to create a repository using the [Create Repository REST API Endpoint](https://www.jfrog.com/confluence/display/JFROG/Artifactory+REST+API#ArtifactoryRESTAPI-CreateRepository)
- This endpoint needs a [Repository Configuration JSON](https://www.jfrog.com/confluence/display/JFROG/Repository+Configuration+JSON) file as an input

```bash
curl --location --request PUT "https://${ARTIFACTORY_HOSTNAME}/artifactory/api/repositories/teamA-alpine-dev-local" --header "Authorization: Bearer ${ARTIFACTORY_ACCESS_TOKEN}" --header 'Content-Type: application/json' --data-raw '{
"rclass": "local",
"packageType": "alpine",
"description": "A Test Alpine Repository"
}'
```
You can also use a repository-config.json file to provide the configuration 

```bash
curl --location --request PUT "https://${ARTIFACTORY_HOSTNAME}/artifactory/api/repositories/teamB-alpine-dev-local" \
--header "Authorization: Bearer ${ARTIFACTORY_ACCESS_TOKEN}" \
--header 'Content-Type: application/json' \
-T repository-config.json
```

## 1.4 Create a new User and assign permissions using REST API  
- We are going to create a new User using the [Create or Replace User API endpoint](https://www.jfrog.com/confluence/display/JFROG/Artifactory+REST+API#ArtifactoryRESTAPI-CreateorReplaceUser)
- This endpoint needs a [Security Configuration JSON - User](https://www.jfrog.com/confluence/display/JFROG/Security+Configuration+JSON#SecurityConfigurationJSON-application/vnd.org.jfrog.artifactory.security.User+json) file as an input

```bash
curl --location --request PUT "https://${ARTIFACTORY_HOSTNAME}/artifactory/api/security/users/davids" \
--header "Authorization: Bearer ${ARTIFACTORY_ACCESS_TOKEN}" \
--header 'Content-Type: application/json' \
--data-raw '{
	"email" : "davids@jfrog.com",
    "password": "SwampUp2022!"
}'
```

Verify if the User got created using the endpoint [Get Users](https://www.jfrog.com/confluence/display/JFROG/Artifactory+REST+API#ArtifactoryRESTAPI-GetUsers)
```bash
curl --location --request GET "https://${ARTIFACTORY_HOSTNAME}/artifactory/api/security/users" \
--header "Authorization: Bearer ${ARTIFACTORY_ACCESS_TOKEN}"

```
## 1.5 Create a new Project using REST API 
We are going to create a new Project using the [Create or Replace User API endpoint](https://www.jfrog.com/confluence/display/JFROG/Artifactory+REST+API#ArtifactoryRESTAPI-AddaNewProject)

This API needs Bearer token for Authorization as noted in the API docuemntation. 

FYI, JFrog Projects uses access API endpoint  
<JFrog Base URL>/access/api
#For example:
http://ARTIFACTORY_SERVER_HOSTNAME:8082/access/api

```bash
curl --location --request POST "https://${ARTIFACTORY_HOSTNAME}/access/api/v1/projects" \
--header "Authorization: Bearer ${ARTIFACTORY_ACCESS_TOKEN}" \
--header 'Content-Type: application/json' \
--data-raw '{
  "display_name": "aplha",
  "description": "Aplha team works on following applications- Shopping cart",
  "admin_privileges": {
    "manage_members": true,
    "manage_resources": true,
    "manage_security_assets": true,
    "index_resources": true,
    "allow_ignore_rules": true
  },
  "storage_quota_bytes": 1073741824,
  "project_key": "alpha"
}'
```

## 1.6 Assign newly created repo to the Project 
We are using the [Move Repository in a Project endpoint](https://www.jfrog.com/confluence/display/JFROG/Artifactory+REST+API#ArtifactoryRESTAPI-MoveRepositoryinaProject)
```bash
curl --location --request PUT "https://${ARTIFACTORY_HOSTNAME}/access/api/v1/projects/_/attach/repositories/teamA-alpine-dev-local/alpha?force=false" \
--header "Authorization: Bearer ${ARTIFACTORY_ACCESS_TOKEN}"
```
## 1.7 Assign the role of Project Administrator to the User 
 We are using the [Update User in Project API](https://www.jfrog.com/confluence/display/JFROG/Artifactory+REST+API#ArtifactoryRESTAPI-UpdateUserinProject)

```bash
curl --location --request PUT "https://${ARTIFACTORY_HOSTNAME}/access/api/v1/projects/alpha/users/davids" \
--header "Authorization: Bearer ${ARTIFACTORY_ACCESS_TOKEN}" \
--header 'Content-Type: application/json' \
--data-raw '{
  "name": "davids",
  "roles": [
    "Project Admin"
  ]
}'
```

# Intro to JFrogCLI 
## 1.8 Getting started with JFrogCLI 
Downlaod and install JFrog CLI using the various options available [GETCLI](https://jfrog.com/getcli/)

LINUX USERS 
```bash
curl -fL https://install-cli.jfrog.io | sh
```
WINDOWS USERS 

```bash
powershell "Start-Process -Wait -Verb RunAs powershell '-NoProfile iwr https://releases.jfrog.io/artifactory/jfrog-cli/v2-jf/[RELEASE]/jfrog-cli-windows-amd64/jf.exe -OutFile $env:SYSTEMROOT\system32\jf.exe'" ; jf setup
```
Let's setup JFrogCLI to integrate with our Artifactory instance. Add the access profile using the [Adding Server Configuration document here](https://www.jfrog.com/confluence/display/CLI/JFrog+CLI#JFrogCLI-AddingandEditingConfiguredServers)

We are going to turn off the interactive prompts and progress bar by setting the environemnt variable CI as true. To verify if the JFrogCLI is successfully able to connect to the platform, we are performing a quick health check [Verifying Artifactory is accessible](https://www.jfrog.com/confluence/display/CLI/CLI+for+JFrog+Artifactory#CLIforJFrogArtifactory-VerifyingArtifactoryisAccessible)

```bash
export CI=true 
jf c add ${ARTIFACTORY_HOSTNAME} --url "https://${ARTIFACTORY_HOSTNAME}" --access-token ${ARTIFACTORY_ACCESS_TOKEN}
jf config show
jf c use ${ARTIFACTORY_HOSTNAME}
jf rt ping
```
