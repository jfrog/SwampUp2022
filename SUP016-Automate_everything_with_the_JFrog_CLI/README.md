# SUP016-Automate everything with the JFrog CLI

### Prerequisites

- Generate a Github personnal [access token](https://docs.github.com/en/github/authenticating-to-github/keeping-your-account-and-data-secure/creating-a-personal-access-token). <br/>
  - **NOTE**: if you already have GitHub access token then skip this step else create GitHub account first and then follow above steps.
- Confirm `git` [client](https://git-scm.com/book/en/v2/Getting-Started-First-Time-Git-Setup) has been configured with your user
  - verify with ``git config --list``
- Fork [jfrog/SwampUp2022](https://github.com/jfrog/SwampUp2022) github repository.
  - Reference document to [fork repository](https://docs.github.com/en/get-started/quickstart/fork-a-repo#forking-a-repository).
- `git clone` the forked repo on your workstation
  - Reference document to [clone repository](https://docs.github.com/en/get-started/quickstart/fork-a-repo#cloning-your-forked-repository).
- All content related today's training is under "**SUP016-Automate everything with the JFrog CLI/**".


### Run Labs
**Option 1** 
- We will be using IDE (any with terminal) or terminal/CMD as part of our labs so please download and install one if you do not have one on your workstation.
- Download [JFrog CLI](https://jfrog.com/getcli/) based on our machine.
- Setup MAVEN or NPM and Docker Client. 
  - so we can run commands like `mvn install`, `npm install` or `docker pull image:tag`

**Option 2**
### .env config 
- Our directory `SwampUp2022/SUP016-Automate_everything_with_the_JFrog_CLI` has .env file where we can define environment variables.
  - Mandatory - JFROG_EDGE, ADMIN_USER, ADMIN_PASSWORD, JFROG_PLATFORM
  - Optional - ACCESS_TOKEN

### Using Docker image :
- Please cd to the SwampUp2022 folder and  run the following docker command:
```
source SUP016-Automate_everything_with_the_JFrog_CLI/.env

docker run --rm --name my-project -it -v /var/run/docker.sock:/var/run/docker.sock  --env  JFROG_PLATFORM="${JFROG_PLATFORM}" --env ADMIN_USER="${ADMIN_USER}" --env ADMIN_PASSWORD="${ADMIN_PASSWORD}" --env JFROG_EDGE="${JFROG_EDGE}" --env JFROG_CLI_LOG_LEVEL="${JFROG_CLI_LOG_LEVEL}" --env JFROG_CLI_TRANSITIVE_DOWNLOAD_EXPERIMENTAL="${JFROG_CLI_TRANSITIVE_DOWNLOAD_EXPERIMENTAL}" --env JFROG_CLI_TRANSITIVE_DOWNLOAD_EXPERIMENTAL="${JFROG_CLI_TRANSITIVE_DOWNLOAD_EXPERIMENTAL}" -v "$(pwd)":/usr/src/mymaven -w /usr/src/mymaven soleng.jfrog.io/swampup2022-docker-local/docker20.10.16-npm18.1-maven3.8.5-jf2.16.4:11-jdk-alpine /bin/bash
```
- Then from within the docker container run:
```
jf config add SUP016 --user "${ADMIN_USER}" --password "${ADMIN_PASSWORD}" --artifactory-url https://${JFROG_PLATFORM}/artifactory --xray-url https://${JFROG_PLATFORM}/xray/ --interactive=false

jf config add SUP016-edge --artifactory-url=https://${JFROG_EDGE}/artifactory --user "${ADMIN_USER}" --password "${ADMIN_PASSWORD}" --interactive=false

cd SUP016-Automate_everything_with_the_JFrog_CLI
```
