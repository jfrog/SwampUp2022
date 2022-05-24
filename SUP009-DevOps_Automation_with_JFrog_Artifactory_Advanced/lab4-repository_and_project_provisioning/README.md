# swampup2022-SUP-009-DevOps Automation with JFrog Artifactory(Advanced) 
# Lab4 - Repository and Project Provisioning

## Overview
This example demonstrates how to create repository and project with RESTful API.

# Configure CLI in the main JPD
jf config add swampup115 --artifactory-url=https://$JFROG_PLATFORM/artifactory --dist-url=https://$JFROG_PLATFORM/distribution --user=$ADMIN_USER --password=$ADMIN_PASSWORD --interactive=false

# Configure CLI in the Artifactory Edge
# jfrog config add swampup115-edge --artifactory-url=https://$JFROG_EDGE/artifactory --user=$ADMIN_USER --password=$ADMIN_PASSWORD --interactive=false

# Check existing configuration
jf rt c show

# Make it default
jf config use swampup115

# Create all repositories in the main Artifactory JPD
```consike
> jf rt curl -XPATCH /api/system/configuration -T $SCRIPT_DIR/lab-1/repo-conf-creation-main.yaml
```

# Create all repositories in the Artifactory Edge Node
```console
> jf rt curl -XPATCH /api/system/configuration -T $SCRIPT_DIR/lab-1/repo-conf-creation-edge.yaml --server-id swampup115-edge
```

# Create two groups (dev, release managers)
```console
> jf rt curl -XPUT /api/security/groups/dev-group -T $SCRIPT_DIR/lab-1/dev-group.json
> jf rt curl -XPUT /api/security/groups/release-managers-group -T $SCRIPT_DIR/lab-1/release-managers-group.json
```

# Create permission targets Dev and Prod
```console
> jf rt ptc $SCRIPT_DIR/lab-1/dev-permission-target-template.json --vars="application=app"
> jf rt ptc $SCRIPT_DIR/lab-1/prod-permission-target-template.json --vars="application=app"
```

# How to update a permission?
```console
> jf rt ptu $SCRIPT_DIR/lab-1/dev-permission-target-template.json --vars="application=app"
```

# Create project
```console
> curl -XPOST -H "Authorization: Bearer ${token}" -H 'Content-Type:application/json' https://$JFROG_PLATFORM/access/api/v1/projects -T ./lab-1/su115-project.json
```

# Sharing repositories in a project
```console
> $SCRIPT_DIR/lab-1/sharing-repositories.sh
```

# How to define now the permission scheme within the project?
# 1) Updating global roles
# This operation is only available in the UI for now

# 2) Creating custom roles
```console
> curl -XPOST -H "Authorization: Bearer ${token}" -H 'Content-Type:application/json' https://$JFROG_PLATFORM/access/api/v1/projects/su115/roles -T ./lab-1/infosec-role-create.json
```

# 3) Tagging repositories (Dev , PROD)
```console
> jfrog rt curl -XPOST /api/repositories/app-gradle-rc-local -H "content-type: application/vnd.org.jfrog.artifactory.repositories.LocalRepositoryConfiguration+json" --data '{"environments":["DEV", "PROD"]}'
```

# Adding builds to the Xray indexing process
```console
> curl -u$ADMIN_USER:$ADMIN_PASSWORD -X POST -H "content-type: application/json"  https://$JFROG_PLATFORM/xray/api/v1/binMgr/builds -T $SCRIPT_DIR/lab-3/indexed-builds.json
```