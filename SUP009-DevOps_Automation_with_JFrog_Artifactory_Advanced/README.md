## swampup2022-SUP-009-DevOps Automation with JFrog Artifactory(Advanced) 

# pre-requisites 
git - https://git-scm.com/book/en/v2/Getting-Started-Installing-Git
docker - https://docs.docker.com/engine/install/
npm - https://nodejs.org/en/download/
pip - https://packaging.python.org/guides/installing-using-pip-and-virtual-environments/



## Clone the git repository 
```bash
git clone https://github.com/jfrog/SwampUp2022.git

```


## 0.1 Obtain Access token
Let's create an access token using the following documentation [How to generate an access token?](https://jfrog.com/knowledge-base/how-to-generate-an-access-token-video/#:~:text=So%20once%20you're%20logged,option%20to%20generate%20admin%20tokens.)


## 0.2 Set Environemnt Variables
- On Linux/Mac OS, please use
```bash
export ARTIFACTORY_HOSTNAME="sup009entsuxx.jfrog.io"
export ARTIFACTORY_LOGIN="taletsup009entsuxx@jfrog.com"
export ARTIFACTORY_PASSWORD="SwampUp2022!"
export ARTIFACTORY_ACCESS_TOKEN="xxxxxxxx"
```

- On Windows OS, please use
```bash
set ARTIFACTORY_HOSTNAME="sup009entsuxx.jfrog.io"
set ARTIFACTORY_LOGIN="taletsup009entsuxx@jfrog.com"
set ARTIFACTORY_PASSWORD="SwampUp2022!"
set ARTIFACTORY_ACCESS_TOKEN="xxxxxxxxxx"
```
![setting environemnt variables](https://i.imgur.com/BastCGE.gif)


## 0.3 Setting up your .env file
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

# Service admin token - see instructions on Lab 1.5 
export ARTIFACTORY_ACCESS_TOKEN="xxxxx"


# App name
export APP_ID=myApp

# Increment it everytime you run your lab
export APP_VERSION=1.1.40

# Increment it everytime you run your lab
export BUILD_NUMBER=1
```

## Set Environment variable 
### Option 1
**Using your workstation** :

```bash
source .env

```

### Option 2
**Using Docker image** :
- Please `cd SwampUp2022` folder and run the following docker command:
```
source SUP016-Automate_everything_with_the_JFrog_CLI/.env

docker run --rm --name my-project -it -v /var/run/docker.sock:/var/run/docker.sock soleng.jfrog.io/swampup2022-docker-local/docker20.10.16-npm18.1-maven3.8.5-jf2.16.4:11-jdk-alpine /bin/bash
```
## Proceed to the Lab-1-Intro_to_automation sub-folder now 
