# swampup2022-SUP-009-DevOps Automation with JFrog Artifactory(Advanced) 
# Lab4 - Repository and Project Provisioning

## Overview
This example demonstrates how to create repository and project with RESTful API.

### Configure CLI in the main JPD
```console
jf config add ${ARTIFACTORY_HOSTNAME} --artifactory-url=https://$ARTIFACTORY_HOSTNAME/artifactory --user=$ARTIFACTORY_LOGIN --password=$ARTIFACTORY_PASSWORD --interactive=false
```

### Check existing configuration
```console
jf rt c show
```

### Make it default
```console
jf config use ${ARTIFACTORY_HOSTNAME}
```

### Create all repositories in the main Artifactory JPD
```console
jf rt curl -XPATCH /api/system/configuration -T $SCRIPT_DIR/lab4-repository_and_project_provisioning/repo-conf-creation-main.yaml
```

### Create two groups (dev, release managers)
```console
jf rt curl -XPUT /api/security/groups/dev-group -T $SCRIPT_DIR/lab4-repository_and_project_provisioning/dev-group.json
jf rt curl -XPUT /api/security/groups/release-managers-group -T $SCRIPT_DIR/lab4-repository_and_project_provisioning/release-managers-group.json
```

### Create permission targets Dev and Prod
```console
jf rt ptc $SCRIPT_DIR/lab4-repository_and_project_provisioning/dev-permission-target-template.json --vars="application=app"
jf rt ptc $SCRIPT_DIR/lab4-repository_and_project_provisioning/prod-permission-target-template.json --vars="application=app"
```

### How to update a permission?
```console
jf rt ptu $SCRIPT_DIR/lab4-repository_and_project_provisioning/dev-permission-target-template.json --vars="application=app"
```

### Create project
```console
curl -XPOST -H "Authorization: Bearer ${ARTIFACTORY_ACCESS_TOKEN}" -H 'Content-Type:application/json' https://$ARTIFACTORY_HOSTNAME/access/api/v1/projects -T  $SCRIPT_DIR/lab4-repository_and_project_provisioning/su115-project.json
```

### Sharing repositories in a project
```console
$SCRIPT_DIR/lab4-repository_and_project_provisioning/sharing-repositories.sh
```

## How to define now the permission scheme within the project?
### 1) Updating global roles
### This operation is only available in the UI for now

### 2) Creating custom roles
```console
curl -XPOST -H "Authorization: Bearer ${ARTIFACTORY_ACCESS_TOKEN}" -H 'Content-Type:application/json' https://$ARTIFACTORY_HOSTNAME/access/api/v1/projects/su115/roles -T ./lab4-repository_and_project_provisioning/infosec-role-create.json
```

### 3) Tagging repositories (Dev , PROD)
```console
jf rt curl -XPOST /api/repositories/app-gradle-rc-local -H "content-type: application/vnd.org.jfrog.artifactory.repositories.LocalRepositoryConfiguration+json" --data '{"environments":["DEV", "PROD"]}'
```

### Adding builds to the Xray indexing process
```console
curl -u$ARTIFACTORY_LOGIN:$ARTIFACTORY_PASSWORD -X POST -H "content-type: application/json"  https://$ARTIFACTORY_HOSTNAME/xray/api/v1/binMgr/builds -T $SCRIPT_DIR/lab6-xray_devsecops/indexed-builds.json
```
