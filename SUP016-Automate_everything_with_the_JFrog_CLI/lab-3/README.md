# LAB 3 - Build Integration and Properties

## Prerequisites
- Lab-0 - Configure JFrog CLI
- Lab-1 - Repository Provisioning
- Lab-2 - Role-Based Access Control

## BUILDING AND DEPLOYING
#### MAVEN - Package Manager Integration
- To pre-configured with the Artifactory server, repositories and use for building and publishing. The configuration is stored by the command in the .jfrog directory at the root directory of the project.) 
  - Run ``jf mvnc``
    - Resolve dependencies from Artifactory? (y/n) [y]? `y`
    - Set Artifactory server ID [SUP016]: ↵   
    - Set resolution repository for release dependencies (press Tab for options): `sup016-maven-virtual`
    - Set resolution repository for snapshot dependencies (press Tab for options): `sup016-maven-virtual`
    - Deploy project artifacts to Artifactory? (y/n) [y]? `y`  
    - Set Artifactory server ID [SUP016]: ↵
    - Set repository for release artifacts deployment (press Tab for options): `sup016-maven-virtual`
    - Set repository for snapshot artifacts deployment (press Tab for options): `sup016-maven-virtual`
    - Would you like to filter out some of the deployed artifacts? (y/n) [n]? `n`
- Navigate to ``~/SwampUp2022/SUP016-Automate_everything_with_the_JFrog_CLI/example-projects/maven-example``
- Run ``jf rt mvn clean install -f pom.xml --build-name sup016-maven --build-number 1.0.0
  ``

#### NPM - Package Manager Integration
- To pre-configured with the Artifactory server, repositories and use for building and publishing. The configuration is stored by the command in the .jfrog directory at the root directory of the project.)
  - Run ``jf npmc``
  - Resolve dependencies from Artifactory? (y/n) [y]? `y`
  - Set Artifactory server ID [SUP016]: ↵
  - Set repository for dependencies resolution (press Tab for options): `sup016-npm-virtual`
  - Deploy project artifacts to Artifactory? (y/n) [y]? `y`
  - Set Artifactory server ID [SUP016]: ↵
  - Set repository for artifacts deployment (press Tab for options): `sup016-npm-virtual`
- Navigate to ``~/SwampUp2022/SUP016-Automate_everything_with_the_JFrog_CLI/example-projects/npm-example``
- Run ``jf npm install --build-name sup016-npm --build-number 1.0.0``
- Run ``jf npm publish --build-name sup016-npm --build-number 1.0.0`` - Publish build Artifact to repository

#### DOCKER - Package Manager Integration
- `cd /SwampUp2022/SUP016-Automate_everything_with_the_JFrog_CLI/example-projects/docker-example` 
- Run `docker build -t sup016-docker-virtual/docker-example-app:latest .`
- Run `docker tag sup016-docker-virtual/docker-example-app:latest soleng.jfrog.io/sup016-docker-virtual/docker-example-app:latest`
- Run `jf rt dp soleng.jfrog.io/sup016-docker-virtual/docker-example-app:latest sup016-docker-virtual --build-name=sup016-docker-app --build-number=1`


### COLLECT ENVIRONMENT VARIABLES 
#### Maven 
- Run 
  
  ``jf rt build-collect-env sup016-maven 1.0.0`` 

  or 

  ``jf rt bce sup016-maven 1.0.0``

#### NPM
- Run ``jf rt bce sup016-npm 1.0.0``

### COLLECT INFORMATION REGARDING GIT 
#### Maven
- Run 

  ``jf rt build-add-git sup016-maven 1.0.0 checkout-dir`` - (.git path[Optional] - Path to a directory containing the .git directory. If not specific, the .git directory is assumed to be in the current directory or in one of the parent directories.)

  or

  ``jf rt bag sup016-maven 1.0.0 checkout-dir``  

#### NPM
- Run ``jf rt bag sup016-npm 1.0.0``  - - (.git path[Optional] - Path to a directory containing the .git directory. If not specific, the .git directory is assumed to be in the current directory or in one of the parent directories.)


### PUBLISH BUILD-INFO
#### Maven build publish
- Run ``jf rt bp sup016-maven 1.0.0``

#### NPM build publish
- Run ``jf rt bp sup016-npm 1.0.0``


### Promoting a Build
#### Maven
- Run ``jf rt bpr sup016-maven 1.0.0 sup016-maven-qa-local --status='QA candidate' --comment='webservice is now QA candidate and hand over for regression test' --copy=true --props="maintainer=maharship;stage=qa"``

#### NPM
- Run ``jf rt bpr sup016-npm 1.0.0 sup016-npm-qa-local --status='QA candidate' --comment='webservice is now QA candidate and hand over for regression test' --copy=true --props="maintainer=maharship;stage=qa"``


### Add Files as Build Dependencies [OPTIONAL]
- Run

  ``jf rt build-add-dependencies sup016-maven 1.0.0 "path/to/build/dependencies/dir/"``

  or

  ``jf rt bad sup016-maven 1.0.0 "path/to/build/dependencies/dir/"``

### Aggregate Published Builds [OPTIONAL]
- Create and publish build 1 for multi1
  - Run ``jf rt upload "multi1/*.zip" sup016mp-maven-virtual --build-name multi1-build --build-number 1 --module multi1``
  - Run ``jf rt bp multi1-build 1``
- Create and publish build 1 for multi2 
  - Run ``jf rt upload "multi2/*.zip" sup016mp-maven-virtual --build-name multi2-build --build-number 1 --module multi2``
  - Run ``jf rt bp multi2-build 1``
- Aggregate Builds
  - Run ``jf rt build-append sup016-maven 1.0.0 multi1-build 1``
  - Run ``jf rt build-append sup016-maven 1.0.0 multi2-build 1``
- Run ``jf rt bp sup016-maven 1.0.0``


### Collect Dependencies [OPTIONAL]
- the following command downloads the ``shiro-core-1.7.1.jar`` file found in repository ``{{repository}}`` , but it also specifies this file as a dependency in build ``sup016-maven`` with build number ``1.0.0``
  - Run ``jf rt dl {{repository}}/org/apache/shiro/shiro-core/1.7.1/shiro-core-1.7.1.jar --build-name=sup016-maven --build-number=1.0.0`` - downloads the `shiro-core-1.7.1.jar` file found in repository ``{{repository}}`` , but it also specifies this file as a dependency in build






## Properties
### Set Properties 
- Run 

  ``jf rt set-props "sup016-npm-dev-local/npm-example/-/npm-example-1.1.4.tgz" "unit.test=pass;integration.test=null;"``

  or

  ``jf rt sp "sup016-npm-dev-local/npm-example/-/npm-example-1.1.4.tgz" "unit.test=pass;integration.test=null;"``



## SETTING UP A CI PIPELINE



### Challenge - Update Properties [Optional]
- Add new property to sub-folder inside the artifact - HINT: We need that property to be tagged to each and every single file of the Artifact recursively. 
- Update the ``integration.test`` to ``pass`` or ``fail`` 
- NEED to be tested - Fetch all the artifacts under repository that does not have properties `"unit.test=pass;integration.test=pass;"`

