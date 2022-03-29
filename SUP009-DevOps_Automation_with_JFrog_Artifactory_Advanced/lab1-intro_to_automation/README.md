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

## 1.4 Create a new User and assign permissions using REST API  
- We are going to create a new User using the [Create or Replace User API endpoint](https://www.jfrog.com/confluence/display/JFROG/Artifactory+REST+API#ArtifactoryRESTAPI-CreateorReplaceUser)
- This endpoint needs a [Security Configuration JSON - User](https://www.jfrog.com/confluence/display/JFROG/Security+Configuration+JSON#SecurityConfigurationJSON-application/vnd.org.jfrog.artifactory.security.User+json) file as an input

```bash
curl --location --request PUT "https://${ARTIFACTORY_HOSTNAME}/artifactory/api/security/users/davids" \
--header "X-JFrog-Art-Api: ${ARTIFACTORY_API_KEY}" \
--header 'Content-Type: application/json' \
--data-raw '{
	"email" : "davids@jfrog.com",
    "password": "SwampUp2022"
}'
```

Verify if the User got created using the endpoint [Get Users](https://www.jfrog.com/confluence/display/JFROG/Artifactory+REST+API#ArtifactoryRESTAPI-GetUsers)
```bash
curl --location --request GET "https://${ARTIFACTORY_HOSTNAME}/artifactory/api/security/users" \
--header "X-JFrog-Art-Api: ${ARTIFACTORY_API_KEY}"

```
## 1.5 Create a new Project using REST API 
We are going to create a new Project using the [Create or Replace User API endpoint](https://www.jfrog.com/confluence/display/JFROG/Artifactory+REST+API#ArtifactoryRESTAPI-AddaNewProject)

This API needs Bearer token for Authorization as noted in the API docuemntation. Let's create an access token using the following documentation [How to generate an access token?](https://jfrog.com/knowledge-base/how-to-generate-an-access-token-video/#:~:text=So%20once%20you're%20logged,option%20to%20generate%20admin%20tokens.)

```bash
export ARTIFACTORY_ACCESS_TOKEN="xxxxxxxxxxxxxxxxxxxxxx"
```
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

# SECTION 2 - Intro to JFrogCLI 
## 2.1 Getting started with JFrogCLI 
Downlaod and install JFrog CLI using the various options available [GETCLI](https://jfrog.com/getcli/)
I am using curl to install JFrog CLI 
```bash
curl -fL https://install-cli.jfrog.io | sh
```
Let's setup JFrogCLI to integrate with our Artifactory instance. Add the access profile using the [Adding Server Configuration document here](https://www.jfrog.com/confluence/display/CLI/JFrog+CLI#JFrogCLI-AddingandEditingConfiguredServers)
```bash
curl -fL https://install-cli.jfrog.io | sh
```
We are going to turn off the interactive prompts and progress bar by setting the environemnt variable CI as true. To verify if the JFrogCLI is successfully able to connect to the platform, we are performing a quick health check [Verifying Artifactory is accessible](https://www.jfrog.com/confluence/display/CLI/CLI+for+JFrog+Artifactory#CLIforJFrogArtifactory-VerifyingArtifactoryisAccessible)

```bash
export CI=true 
jf c add ${ARTIFACTORY_HOSTNAME} --url "https://${ARTIFACTORY_HOSTNAME}" --access-token ${ARTIFACTORY_ACCESS_TOKEN}
jf rt ping
```

## 2.2 Builing your PyPi project with JFrogCLI


We have our sample PyPi project example docuemnted in a public [Github repo here](https://github.com/jfrog/project-examples/tree/master/python-example/pip-example)


## Overview
This example demonstrates how to build a Python Pip project with Artifactory, while collecting build-info.

## Before Running the Example
### Set Up the Environment 
1. Make sure **Python** is installed and the **python** command is in your PATH.
2. Install **pip**. You can use the [Pip Documentation](https://pip.pypa.io/en/stable/installing/) and also [Installing packages using pip and virtual environments](https://packaging.python.org/guides/installing-using-pip-and-virtual-environments/)
3. Create three Pypi repositories in Artifactory - a local, remote and a virtual repository. You can use the [PyPi Repositories Documentation](https://www.jfrog.com/confluence/display/RTF/PyPI+Repositories).
* The remote repository should proxy *https://files.pythonhosted.org* (the default when creating a Pypi remote repository). 
* Name the virtual repository *pipy*.
* The virtual repository should include the remote repository.
* The virtual repository should have the local repository set as the *Default Deployment Repository*.
Hint - Uisng the quick Setup option, let us create a set of PyPi repositories which will be used in this lab 
Screen recording here (3/29/7:30 AM)

4. Make sure **wheel** and **setuptools** are installed. You can use the [Installing Packages Documentation](https://packaging.python.org/tutorials/installing-packages/).
5. Make sure version 1.28.0 or above of [JFrog CLI](https://jfrog.com/getcli/) is installed.

### Validate the Setup
In your terminal, validate that the following commands work.
```console
> source env/bin/activate
> pip install wheel
Output Python version:
> python --version

Output pip version:
> pip --version

Verify wheel is installed:
> wheel -h

Verify setuptools is installed:
> pip show setuptools

Verify that virtual-environment is activated:
> echo $VIRTUAL_ENV

Output JFrog CLI version:
> jfrog --version
```

## Running the Example
CD to the root project directory

```console
export CI=false
```

Configure the project's resolution repository. You shoud set the virtual repository you created.

Learn about [Building Python Packages with JFrog CLI](https://www.jfrog.com/confluence/display/CLI/CLI+for+JFrog+Artifactory#CLIforJFrogArtifactory-BuildingPythonPackages)

```console
> jf pipc --server-id-resolve ${ARTIFACTORY_HOSTNAME} --repo-resolve alpha-pypi-virtual
```

Install project dependencies with pip from Artifactory:
```console
> jf pip install -r requirements.txt --build-name=my-pip-build --build-number=1 --module=jfrog-python-example
```

Package the project, create distribution archives (tar.gz and whl):
```console
> python setup.py sdist bdist_wheel
```

Upload the packages to the pypi repository in Artifactory:
```
> jf rt u dist/ alpha-pypi-virtual/ --build-name=my-pip-build --build-number=1 --module=jfrog-python-example
```
Collect environment variables and add them to the build info:
```
> jf rt bce my-pip-build 1
jf rt bag my-pip-build 1 ../../.
```

Publish the build info to Artifactory:
```
> jf rt bp my-pip-build 1
```

Install published package by installing it from Artifactory using pip:
```
> jf pip install jfrog-python-example
```

Validate package successfully installed:
```
> pip show jfrog-python-example
```
```
> deactivate
```





