# SUP003 - Intro to DevSecOps with JFrog Xray

- Set the following Environment variables

  On Linux/Mac OS, please use

  ```
  export ARTIFACTORY_HOSTNAME="my-instance"
  export ARTIFACTORY_LOGIN="foo@bar.com"
  export ARTIFACTORY_API_KEY="MY_API_KEY"
 
  ```

  On Windows OS, please use

  ```
  set ARTIFACTORY_HOSTNAME="my-instance"
  set ARTIFACTORY_LOGIN="foo@bar.com"
  set ARTIFACTORY_API_KEY="MY_API_KEY"
  
  ```

- Get the Docker daemon + client for your OS (https://docs.docker.com/get-docker/)


- Run the docker image using **run-docker.sh**. This executes the command below and opens an interactive terminal into the container. 

  ```
  
  docker run --name sup003 --rm --env ARTIFACTORY_HOSTNAME="${ARTIFACTORY_HOSTNAME}" --env ARTIFACTORY_LOGIN="${ARTIFACTORY_LOGIN}" --env ARTIFACTORY_API_KEY="${ARTIFACTORY_API_KEY}" -it -v "/var/run/docker.sock:/var/run/docker.sock" soleng.jfrog.io/sup003-docker-virtual/lab-runner-init /bin/bash

  ```
  
- Execute the following commands inside the docker container

  - setupCLI.sh. This script configures the JFrog instance for your use using the Environment variables specified above
  
    ```
    
    export CLI_INSTANCE_ID="my-instance"

    jf config add "${CLI_INSTANCE_ID}" --user "${ARTIFACTORY_LOGIN}" --password "${ARTIFACTORY_API_KEY}" --artifactory-url https://${ARTIFACTORY_HOSTNAME}.jfrog.io/artifactory --xray-url https://${ARTIFACTORY_HOSTNAME}.jfrog.io/xray/ --interactive=false

    jf config use "${CLI_INSTANCE_ID}"

    ```
    
  - init.sh. This script creates the local, remote and virtual repositories in your Artifactory instance.
