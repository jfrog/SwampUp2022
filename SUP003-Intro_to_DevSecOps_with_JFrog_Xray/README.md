# SUP003 - Intro to DevSecOps with JFrog Xray

## Agenda
- Lab 0 - Configure JFrog CLI
- LAB 1 - Indexing Resources and Create Policy
- LAB 2 - Create Watch and check for violation
- LAB 3 - Shift Left Security
- LAB 4 - Xray at CI/CD and Create Reports
- Lab 5 - Advanced Automation in Xray

<br/>

## Prerequisites

- Generate a Github personnal [access token](https://docs.github.com/en/github/authenticating-to-github/keeping-your-account-and-data-secure/creating-a-personal-access-token). <br/>
  - **NOTE**: if you already have GitHub access token then skip this step else create GitHub account first and then follow above steps.
- Confirm `git` [client](https://git-scm.com/book/en/v2/Getting-Started-First-Time-Git-Setup) has been configured with your user
  - verify with ``git config --list``
- Fork [jfrog/SwampUp2022](https://github.com/jfrog/SwampUp2022) github repository.
  - Reference document to [fork repository](https://docs.github.com/en/get-started/quickstart/fork-a-repo#forking-a-repository).
- `git clone` the forked repo on your workstation
  - Reference document to [clone repository](https://docs.github.com/en/get-started/quickstart/fork-a-repo#cloning-your-forked-repository).
- All content related today's training is under "**SUP003-Intro_to_DevSecOps_with_JFrog_Xray/**".


<br/>

## .env config [Must]
- Our directory `SwampUp2022/SUP003-Intro_to_DevSecOps_with_JFrog_Xray` has `.env` or `env.bat` file where we need define environment variables.
  - Mandatory - JFROG_PLATFORM, ADMIN_USER, ADMIN_PASSWORD, JFROG_EDGE
  - Optional - ACCESS_TOKEN
- For linux machine - `source .env` or for windows - `call env.bat`

<br/>


## Run Labs
### Option 1
- We will be using IDE (any with terminal) or terminal/CMD as part of our labs so please download and install one if you do not have one on your workstation.
- Download [JFrog CLI](https://jfrog.com/getcli/) based on our machine.
- Setup MAVEN or NPM and Docker Client.
  - so we can run commands like `mvn install`, `npm install` or `docker pull image:tag`

### Option 2
**Using Docker image** :
- Run the docker image using **run-docker.sh**. This executes the command below and opens an interactive terminal into the container. 

  ```
  
  docker run --name sup003 --rm --env JFROG_PLATFORM="${JFROG_PLATFORM}" --env ADMIN_USER="${ADMIN_USER}" --env ADMIN_PASSWORD="${ADMIN_PASSWORD}" -it -v "/var/run/docker.sock:/var/run/docker.sock" soleng.jfrog.io/sup003-docker-virtual/lab-runner-init /bin/bash

  ```
  
