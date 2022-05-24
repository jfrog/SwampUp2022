# SUP003 - Intro to DevSecOps with JFrog Xray

- Set the following Environment variables
  
  ```
  
  export ARTIFACTORY_HOSTNAME=$INSTANCE_NAME
  export ARTIFACTORY_LOGIN=$USERNAME
  export ARTIFACTORY_API_KEY=$API_KEY

   ```


- Pull the lab-runner docker image from JFrog by running **pull-docker.sh**. This exeecutes the command below.
  
  ```
  
  docker pull soleng.jfrog.io/sup003-docker-virtual/lab-runner-init
  
  ```

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
