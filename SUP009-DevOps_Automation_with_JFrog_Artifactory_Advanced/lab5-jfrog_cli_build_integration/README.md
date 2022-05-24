# swampup2022-SUP-009-DevOps Automation with JFrog Artifactory(Advanced) 
# LAB5 - JFROG CLI Build integration

## Overview
This example demonstrates how to build integration with JFrog CLI.

## CD into the java src code folder 
```console
cd $SCRIPT_DIR/back/src
```

## Configure cli for gradle
### Todo disable ivy descriptors
```console
jf rt gradlec --repo-resolve=app-gradle-virtual --server-id-resolve=${ARTIFACTORY_HOSTNAME} --repo-deploy=app-gradle-virtual --deploy-ivy-desc=false --deploy-maven-desc=true --server-id-deploy=${ARTIFACTORY_HOSTNAME}
```

### Local proxy for our build info extractor (for both Maven and Gradle)
```console
export JFROG_CLI_EXTRACTORS_REMOTE=${ARTIFACTORY_HOSTNAME}/extractors
```

### Gradle Build Run
```console
jf rt gradle "clean artifactoryPublish -b build.gradle --info --refresh-dependencies" --build-name=gradle-su-115 --build-number=$BUILD_NUMBER
```

### Publishing Build info
```console
jf rt bp gradle-su-115 $BUILD_NUMBER
```

### Searching build artifacts
```console
jf rt s "app-gradle-virtual/" --build=gradle-su-115/$BUILD_NUMBER
```

### Tagging the build with properties
```console
jf rt sp "app-gradle-virtual/*" "maintainer=hza;stage=dev;appnmv=$APP_ID/$APP_VERSION" --build=gradle-su-115/$BUILD_NUMBER
```

### Find the webservice.war from the latest build (using filespec)
```console
jf rt s --spec $SCRIPT_DIR/lab5-jfrog_cli_build_integration/latest-webservice.json
```

### Find the webservice.war from the latest build (using CLI search pattern)
```console
jf rt s 'app-gradle-virtual/*/webservice*.war' --props="build.name=gradle-su-115" --sort-by=created --sort-order=desc --limit=1
```

### Find the gradle build dependencies
```console
jf rt s --spec="${SCRIPT_DIR}/lab-2/filespec-aql-dependency-search-gradle.json" --spec-vars="build-name=gradle-su-115;build-number=$BUILD_NUMBER"
```

### Test run and promote
```console
jf rt bpr gradle-su-115 $BUILD_NUMBER app-gradle-rc-local --status='release candidate' --comment='webservice is now release candidate' --copy=true --props="maintainer=hza;stage=staging"
```

### Find all files from that build that were promoted to staging
```console
jf rt s "app-gradle-virtual/*" --props="stage=staging" --build=gradle-su-115/$BUILD_NUMBER
```

## Docker App Build
### Updating dockerfile with JFrog Platform URL
```console
cd $SCRIPT_DIR/back/CI/Docker
```

### Update the docker file to define the registry for the base image
```console
sed "s/registry/${ARTIFACTORY_HOSTNAME}\/app-docker-virtual/g" jfrog-Dockerfile > Dockerfile
```

### Reading the docker file and identifying the base image
```console
export BASE_IMAGE=$(cat Dockerfile | grep "^FROM" | awk '{print $2}' )
```

### Pulling fhe base image
```console
jf rt dpl $BASE_IMAGE app-docker-virtual --build-name=docker-su-115 --build-number=$BUILD_NUMBER --module=app
```

### Download war file dependency
```console
jf rt dl "app-gradle-virtual/*/webservice*.war" war/ --props="stage=staging" --build=gradle-su-115/$BUILD_NUMBER --build-name=docker-su-115 --build-number=$BUILD_NUMBER --module=java-app --flat=true
```

### Run docker build
```console
docker build . -t $ARTIFACTORY_HOSTNAME/app-docker-virtual/jfrog-docker-app:$BUILD_NUMBER  -f Dockerfile --build-arg REGISTRY=$ARTIFACTORY_HOSTNAME/app-docker-virtual --build-arg BASE_TAG=$BUILD_NUMBER
```

## Push the image
### Present a slideck during the docker push (this can take several minutes)
```console
jf rt dp $ARTIFACTORY_HOSTNAME/app-docker-virtual/jfrog-docker-app:$BUILD_NUMBER app-docker-virtual --build-name=docker-su-115 --build-number=$BUILD_NUMBER --module=app
```

### Publish the docker build
```console
jf rt bp docker-su-115 $BUILD_NUMBER
```

### Searching for the base image of my docker build
### what base image has been used
```console
jf rt s --spec="${SCRIPT_DIR}/lab5-jfrog_cli_build_integration/filespec-aql-dependency-search.json" --spec-vars="build-name=docker-su-115;build-number=$BUILD_NUMBER"
```

### Promote the docker build to release candidate
```console
jf rt bpr docker-su-115 $BUILD_NUMBER app-docker-rc-local --status="release candidate" --copy=true --props="maintainer=hza;stage=staging;appnmv=$APP_ID/$APP_VERSION"
```

## helm
### cd into helm chart repo
```console
cp -r $SCRIPT_DIR/docker-app-chart-template $SCRIPT_DIR/docker-app-chart
cd $SCRIPT_DIR/docker-app-chart

sed -ie 's/0.1.1/0.1.'"$BUILD_NUMBER"'/' ./Chart.yaml
sed -ie 's/latest/'"$BUILD_NUMBER"'/g' ./values.yaml

jf rt bce helm-su-115 $BUILD_NUMBER
```

### Reference the docker image as helm build dependency
### Important: to do > fetch from virtual, filter based on application name and version
```console
jf rt dl app-docker-virtual/jfrog-docker-app/$BUILD_NUMBER/manifest.json --build-name=helm-su-115 --build-number=$BUILD_NUMBER --module=app
```

### package the helm chart 
```console
helm package .
```

### upload the helm chart
```console
jf rt u 'docker-app-chart-*.tgz' app-helm-virtual --build-name=helm-su-115 --build-number=$BUILD_NUMBER --module=app
```

### publish the helm build
```console
jf rt bp helm-su-115 $BUILD_NUMBER
```

### promoting the helm build 
```console
jf rt bpr helm-su-115 $BUILD_NUMBER app-helm-rc-local --status="release candidate" --copy=true --props="maintainer=hza;stage=staging;appnmv=$APP_ID/$APP_VERSION"
```

### Promoting the docker build
```console
jf rt bpr docker-su-115 $BUILD_NUMBER app-docker-prod-local --status=released --comment='prod ready aplication' --copy=true --props="maintainer=hza;stage=prod;appnmv=$APP_ID/$APP_VERSION"
```

### promoting the helm build 
```console
jf rt bpr helm-su-115 $BUILD_NUMBER app-helm-prod-local --status=released --comment='prod ready aplication' --copy=true --props="maintainer=hza;stage=prod;appnmv=$APP_ID/$APP_VERSION"
```

### Promoting the gradle build
```console
jf rt bpr gradle-su-115 $BUILD_NUMBER app-gradle-prod-local --status=released --comment='prod ready aplication' --copy=true --props="maintainer=hza;stage=prod;appnmv=$APP_ID/$APP_VERSION"
```

## Security
### Trigger an Xray scan of your docker build
```console
jf rt bs docker-su-115 $BUILD_NUMBER
```