## swampup2022-SUP-009-DevOps Automation with JFrog Artifactory(Advanced) 

# pre-requisites 
git - https://git-scm.com/book/en/v2/Getting-Started-Installing-Git

## Clone the git repository 
```bash
git clone https://github.com/jfrog/SwampUp2022.git

```
## Setting up your .env file
```bash
cd SwampUp2022/SUP009-DevOps_Automation_with_JFrog_Artifactory_Advanced/
vi .env

```
## Sample .env file 

```bash
# current location - make sure you are under swampup2022/SUP009-DevOps_Automation_with_JFrog_Artifactory_Advanced
export SCRIPT_DIR=$(pwd)

# Please use your assigned testbed (https://sup009entsuxx.jfrog.io/)
# Please ask the Trainer or TAs for your assigned JFrog Cloud testbed
export ARTIFACTORY_HOSTNAME="sup009entsuxx.jfrog.io"
# admin user
export ARTIFACTORY_LOGIN="taletsup009entsuxx@jfrog.com"

# admin password (check your testbed details with your TA)
export ARTIFACTORY_PASSWORD="SwampUp2022!"
#Please generate API KEY and enter it below - Lab 1.1
export ARTIFACTORY_API_KEY="xxxxx"
# Service admin token - Lab 1.5 
export token="xxxx"


# App name
export APP_ID=myApp

# Increment it everytime you run your lab
export APP_VERSION=1.1.40

# Increment it everytime you run your lab
export BUILD_NUMBER=1
```

## Set Environment variable 
```bash
source .env

```
