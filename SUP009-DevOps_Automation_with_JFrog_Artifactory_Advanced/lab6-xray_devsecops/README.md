# swampup2022-SUP-009-DevOps Automation with JFrog Artifactory(Advanced) 
# Lab6 - Xray DevSecOps

## Overview
This example demonstrates the ability to integrate xray with CI/CD pipelines.

### it's the right time to create your security policies and watches
```console
curl -u$ADMIN_USER:$ADMIN_PASSWORD -X POST -H "content-type: application/json"  https://$ARTIFACTORY_HOSTNAME/xray/api/v1/policies -T $SCRIPT_DIR/lab-3/security-policy.json
curl -u$ADMIN_USER:$ADMIN_PASSWORD -X POST -H "content-type: application/json"  https://$ARTIFACTORY_HOSTNAME/xray/api/v1/policies -T $SCRIPT_DIR/lab-3/license-policy.json
curl -u$ADMIN_USER:$ADMIN_PASSWORD -X POST -H "content-type: application/json"  https://$ARTIFACTORY_HOSTNAME/xray/api/v2/watches -T $SCRIPT_DIR/lab-3/watch.json
```

### Let's run the build scan again
```console
jfrog rt bs docker-su-115 $BUILD_NUMBER
```

### Let's run it once again without enforcement
```console
jfrog rt bs docker-su-115 $BUILD_NUMBER --fail=false
```