# swampup2022-SUP-009-DevOps Automation with JFrog Artifactory(Advanced) 
# Lab1 - Intro to Automation Tools


## 1.1 Obtain API Key 
- Login to Artifactory using the provided details through email
- Generate an Artifactory [API Key](https://www.jfrog.com/confluence/display/JFROG/User+Profile#UserProfile-APIKey) for the User account
- Save the API KEY
- Please follow the recording below for the step by step walkthrough of the process

![geenrate API key](https://i.imgur.com/ElFGv6b.gif)

## 1.2 Configure environment variables for REST API

- Open a terminal
- Set environemnt variables to store Artifactory server and authentication details 
- See instructions for Windows OS and Linux/Mac OS below

- On Linux/Mac OS, please use
```bash
export ARTIFACTORY_HOSTNAME="my-instance.jfrog.io"
export ARTIFACTORY_LOGIN="foo@bar.com"
export ARTIFACTORY_API_KEY="MY_API_KEY"
```

- On Windows OS, please use
```bash
set ARTIFACTORY_HOSTNAME="my-instance.jfrog.io"
set ARTIFACTORY_LOGIN="foo@bar.com"
set ARTIFACTORY_API_KEY="MY_API_KEY"
```
![setting environemnt variables](https://i.imgur.com/BastCGE.gif)

## 1.3 Create your first repository using REST API 
- We are going to create a repository using the [Create Repository REST API Endpoint](https://www.jfrog.com/confluence/display/JFROG/Artifactory+REST+API#ArtifactoryRESTAPI-CreateRepository)
- This endpoint needs a [Repository Configuration JSON](https://www.jfrog.com/confluence/display/JFROG/Repository+Configuration+JSON) file as an input

```bash
curl --location --request PUT "https://${ARTIFACTORY_HOSTNAME}/artifactory/api/repositories/teamA-alpine-dev-local" --header "X-JFrog-Art-Api: ${ARTIFACTORY_API_KEY}" --header 'Content-Type: application/json' --data-raw '{
"rclass": "local",
"packageType": "alpine",
"description": "A Test Alpine Repository"
}'
```
You can also use a repository-config.json file to provide the configuration 

```bash
curl --location --request PUT "https://${ARTIFACTORY_HOSTNAME}/artifactory/api/repositories/teamB-alpine-dev-local" \
--header "X-JFrog-Art-Api: ${ARTIFACTORY_API_KEY}" \
--header 'Content-Type: application/json' \
-T repository-config.json
```