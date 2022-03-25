###############################################
#           Swampup 2021 - SU 115
###############################################


###############################################
#Prepare your local environment
###############################################

# Update /usr/local/.env

# Load environment variables
source .env

################################################################################################################
## LAB 1 - Repository and project provisioning
################################################################################################################

# Configure CLI in the main JPD
jfrog config add swampup115 --artifactory-url=https://$JFROG_PLATFORM/artifactory --dist-url=https://$JFROG_PLATFORM/distribution --user=$ADMIN_USER --password=$ADMIN_PASSWORD --interactive=false

# Configure CLI in the Artifactory Edge
jfrog config add swampup115-edge --artifactory-url=https://$JFROG_EDGE/artifactory --user=$ADMIN_USER --password=$ADMIN_PASSWORD --interactive=false

# Check existing configuration
jfrog rt c show

# Make it default
jfrog config use swampup115

# Create all repositories in the main Artifactory JPD
jfrog rt curl -XPATCH /api/system/configuration -T $SCRIPT_DIR/lab-1/repo-conf-creation-main.yaml

# Create all repositories in the Artifactory Edge Node
jfrog rt curl -XPATCH /api/system/configuration -T $SCRIPT_DIR/lab-1/repo-conf-creation-edge.yaml --server-id swampup115-edge

# Create two groups (dev, release managers)
jfrog rt curl -XPUT /api/security/groups/dev-group -T $SCRIPT_DIR/lab-1/dev-group.json
jfrog rt curl -XPUT /api/security/groups/release-managers-group -T $SCRIPT_DIR/lab-1/release-managers-group.json

# Create permission targets Dev and Prod
jfrog rt ptc $SCRIPT_DIR/lab-1/dev-permission-target-template.json --vars="application=app"
jfrog rt ptc $SCRIPT_DIR/lab-1/prod-permission-target-template.json --vars="application=app"

# How to update a permission?
jfrog rt ptu $SCRIPT_DIR/lab-1/dev-permission-target-template.json --vars="application=app"

# Create project
curl -XPOST -H "Authorization: Bearer ${token}" -H 'Content-Type:application/json' https://$JFROG_PLATFORM/access/api/v1/projects -T ./lab-1/su115-project.json

# Sharing repositories in a project
$SCRIPT_DIR/lab-1/sharing-repositories.sh

# How to define now the permission scheme within the project?
# 1) Updating global roles
# This operation is only available in the UI for now

# 2) Creating custom roles
curl -XPOST -H "Authorization: Bearer ${token}" -H 'Content-Type:application/json' https://$JFROG_PLATFORM/access/api/v1/projects/su115/roles -T ./lab-1/infosec-role-create.json

# 3) Tagging repositories (Dev , PROD)
jfrog rt curl -XPOST /api/repositories/app-gradle-rc-local -H "content-type: application/vnd.org.jfrog.artifactory.repositories.LocalRepositoryConfiguration+json" --data '{"environments":["DEV", "PROD"]}'

# Adding builds to the Xray indexing process
curl -u$ADMIN_USER:$ADMIN_PASSWORD -X POST -H "content-type: application/json"  https://$JFROG_PLATFORM/xray/api/v1/binMgr/builds -T $SCRIPT_DIR/lab-3/indexed-builds.json

################################################################################################################
## LAB 2 - JFROG CLI Build integration
################################################################################################################

# CD into the java src code folder 
cd $SCRIPT_DIR/back/src

# Configure cli for gradle
# Todo disable ivy descriptors
jfrog rt gradlec --repo-resolve=app-gradle-virtual --server-id-resolve=swampup115 --repo-deploy=app-gradle-virtual --deploy-ivy-desc=false --deploy-maven-desc=true --server-id-deploy=swampup115

# Local proxy for our build info extractor (for both Maven and Gradle)
export JFROG_CLI_EXTRACTORS_REMOTE=swampup115/extractors

# Gradle Build Run
jfrog rt gradle "clean artifactoryPublish -b build.gradle --info --refresh-dependencies" --build-name=gradle-su-115 --build-number=$BUILD_NUMBER

# Publishing Build info
jfrog rt bp gradle-su-115 $BUILD_NUMBER

# Searching build artifacts
jfrog rt s "app-gradle-virtual/" --build=gradle-su-115/$BUILD_NUMBER

# Tagging the build with properties
jfrog rt sp "app-gradle-virtual/*" "maintainer=hza;stage=dev;appnmv=$APP_ID/$APP_VERSION" --build=gradle-su-115/$BUILD_NUMBER

# Find the webservice.war from the latest build (using filespec)
jfrog rt s --spec $SCRIPT_DIR/lab-2/latest-webservice.json

# Find the webservice.war from the latest build (using CLI search pattern)
jfrog rt s 'app-gradle-virtual/*/webservice*.war' --props="build.name=gradle-su-115" --sort-by=created --sort-order=desc --limit=1

# Find the gradle build dependencies
jfrog rt s --spec="${SCRIPT_DIR}/lab-2/filespec-aql-dependency-search-gradle.json" --spec-vars="build-name=gradle-su-115;build-number=$BUILD_NUMBER"

#Test run and promote ?
jfrog rt bpr gradle-su-115 $BUILD_NUMBER app-gradle-rc-local --status='release candidate' --comment='webservice is now release candidate' --copy=true --props="maintainer=hza;stage=staging"

# Find all files from that build that were promoted to staging
jfrog rt s "app-gradle-virtual/*" --props="stage=staging" --build=gradle-su-115/$BUILD_NUMBER

# Docker App Build
# Updating dockerfile with JFrog Platform URL
cd $SCRIPT_DIR/back/CI/Docker

# Update the docker file to define the registry for the base image
sed "s/registry/${JFROG_PLATFORM}\/app-docker-virtual/g" jfrog-Dockerfile > Dockerfile

# Reading the docker file and identifying the base image
export BASE_IMAGE=$(cat Dockerfile | grep "^FROM" | awk '{print $2}' )

# Pulling fhe base image
jfrog rt dpl $BASE_IMAGE app-docker-virtual --build-name=docker-su-115 --build-number=$BUILD_NUMBER --module=app

# Download war file dependency
jfrog rt dl "app-gradle-virtual/*/webservice*.war" war/ --props="stage=staging" --build=gradle-su-115/$BUILD_NUMBER --build-name=docker-su-115 --build-number=$BUILD_NUMBER --module=java-app --flat=true

# Run docker build
docker build . -t $JFROG_PLATFORM/app-docker-virtual/jfrog-docker-app:$BUILD_NUMBER  -f Dockerfile --build-arg REGISTRY=$JFROG_PLATFORM/app-docker-virtual --build-arg BASE_TAG=$BUILD_NUMBER

# Push the image
# Present a slideck during the docker push (this can take several minutes)
jfrog rt dp $JFROG_PLATFORM/app-docker-virtual/jfrog-docker-app:$BUILD_NUMBER app-docker-virtual --build-name=docker-su-115 --build-number=$BUILD_NUMBER --module=app

# Publish the docker build
jfrog rt bp docker-su-115 $BUILD_NUMBER

#Searching for the base image of my docker build
## what base image has been used
jfrog rt s --spec="${SCRIPT_DIR}/lab-2/filespec-aql-dependency-search.json" --spec-vars="build-name=docker-su-115;build-number=$BUILD_NUMBER"

#Promote the docker build to release candidate
jfrog rt bpr docker-su-115 $BUILD_NUMBER app-docker-rc-local --status="release candidate" --copy=true --props="maintainer=hza;stage=staging;appnmv=$APP_ID/$APP_VERSION"

#helm
# cd into helm chart repo
cp -r $SCRIPT_DIR/docker-app-chart-template $SCRIPT_DIR/docker-app-chart
cd $SCRIPT_DIR/docker-app-chart

sed -ie 's/0.1.1/0.1.'"$BUILD_NUMBER"'/' ./Chart.yaml
sed -ie 's/latest/'"$BUILD_NUMBER"'/g' ./values.yaml

jfrog rt bce helm-su-115 $BUILD_NUMBER

# Reference the docker image as helm build dependency
# Important: to do > fetch from virtual, filter based on application name and version
jfrog rt dl app-docker-virtual/jfrog-docker-app/$BUILD_NUMBER/manifest.json --build-name=helm-su-115 --build-number=$BUILD_NUMBER --module=app

# package the helm chart 
helm package .

# upload the helm chart
jfrog rt u 'docker-app-chart-*.tgz' app-helm-virtual --build-name=helm-su-115 --build-number=$BUILD_NUMBER --module=app

# publish the helm build
jfrog rt bp helm-su-115 $BUILD_NUMBER

# promoting the helm build 
jfrog rt bpr helm-su-115 $BUILD_NUMBER app-helm-rc-local --status="release candidate" --copy=true --props="maintainer=hza;stage=staging;appnmv=$APP_ID/$APP_VERSION"

## Promoting the docker build
jfrog rt bpr docker-su-115 $BUILD_NUMBER app-docker-prod-local --status=released --comment='prod ready aplication' --copy=true --props="maintainer=hza;stage=prod;appnmv=$APP_ID/$APP_VERSION"

# promoting the helm build 
jfrog rt bpr helm-su-115 $BUILD_NUMBER app-helm-prod-local --status=released --comment='prod ready aplication' --copy=true --props="maintainer=hza;stage=prod;appnmv=$APP_ID/$APP_VERSION"

# Promoting the gradle build
jfrog rt bpr gradle-su-115 $BUILD_NUMBER app-gradle-prod-local --status=released --comment='prod ready aplication' --copy=true --props="maintainer=hza;stage=prod;appnmv=$APP_ID/$APP_VERSION"

#Security
# Trigger an Xray scan of your docker build
jfrog rt bs docker-su-115 $BUILD_NUMBER


################################################################################################################
## LAB 3 - Xray DevSecOps
################################################################################################################

# it's the right time to create your security policies and watches
curl -u$ADMIN_USER:$ADMIN_PASSWORD -X POST -H "content-type: application/json"  https://$JFROG_PLATFORM/xray/api/v1/policies -T $SCRIPT_DIR/lab-3/security-policy.json
curl -u$ADMIN_USER:$ADMIN_PASSWORD -X POST -H "content-type: application/json"  https://$JFROG_PLATFORM/xray/api/v1/policies -T $SCRIPT_DIR/lab-3/license-policy.json
curl -u$ADMIN_USER:$ADMIN_PASSWORD -X POST -H "content-type: application/json"  https://$JFROG_PLATFORM/xray/api/v2/watches -T $SCRIPT_DIR/lab-3/watch.json

# Let's run the build scan again
jfrog rt bs docker-su-115 $BUILD_NUMBER

# Let's run it once again without enforcement
jfrog rt bs docker-su-115 $BUILD_NUMBER --fail=false

################################################################################################################
## LAB 4 - Software Distribution
################################################################################################################

# Before creating the release bundle, ask the attendees to think about the appropriate AQL query
# test the AQL
jfrog rt s --spec=$SCRIPT_DIR/lab-4/rb-spec-prop-prom-based.json --spec-vars="app-id=$APP_ID;app-version=$APP_VERSION"

# Release bundle creation
jfrog rt rbc $APP_ID $APP_VERSION --spec=$SCRIPT_DIR/lab-4/rb-spec-prop-prom-based.json --spec-vars="app-id=$APP_ID;app-version=$APP_VERSION"

# Release bundle signing 
jfrog rt rbs $APP_ID $APP_VERSION

# Add release bundle to Xray indexing (via UI)

# Add release bundle to Project (via UI)

# Release bundle Distribution
jfrog rt rbd $APP_ID $APP_VERSION --dist-rules=$SCRIPT_DIR/lab-4/dist-rules.json

# Release bundle Distribution relying on a site pattern
jfrog rt rbd $APP_ID $APP_VERSION --site="*edge*"

# How can we track the progress?
curl -u$ADMIN_USER:$ADMIN_PASSWORD -X GET https://$JFROG_PLATFORM/distribution/api/v1/release_bundle/$APP_ID/$APP_VERSION/distribution | jq
