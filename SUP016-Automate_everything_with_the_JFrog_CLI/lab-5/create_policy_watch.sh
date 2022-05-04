 -T $SCRIPT_DIR/lab-5/prod-security-policy.json
curl -u$ADMIN_USER:$ADMIN_PASSWORD -X POST -H "content-type: application/json"  https://$JFROG_PLATFORM/xray/api/v2/policies -T $SCRIPT_DIR/lab-5/dev-security-policy.json
curl -u$ADMIN_USER:$ADMIN_PASSWORD -X POST -H "content-type: application/json"  https://$JFROG_PLATFORM/xray/api/v2/policies -T $SCRIPT_DIR/lab-5/license-policy.json
curl -u$ADMIN_USER:$ADMIN_PASSWORD -X POST -H "content-type: application/json"  https://$JFROG_PLATFORM/xray/api/v2/watches -T $SCRIPT_DIR/lab-5/watch.json
curl -u$ADMIN_USER:$ADMIN_PASSWORD -X POST -H "content-type: application/json"  https://$JFROG_PLATFORM/xray/api/v1/binMgr/builds -T $SCRIPT_DIR/lab-5/index-builds.json
