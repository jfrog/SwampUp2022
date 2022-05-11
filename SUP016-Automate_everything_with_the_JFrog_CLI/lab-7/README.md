# LAB 7 - Distribution

## Prerequisites
- Lab-0 - Configure JFrog CLI
- Lab-1 - Repository Provisioning
- Lab-2 - Role-Based Access Control
- Lab-3 - Build Integration and Properties
- Lab 4 - Configure Replication
- Lab 5 - Artifactory Query Language
- Lab 6 - Xray

### CREATE RELEASE BUNDLE
- Run ``jf ds rbc --spec={{file_path}} {{release_bundle_name}} {{release_bundle_version}}``  

### SIGN RELEASE BUNDLE
- Run ``jf ds rbs {{release_bundle_name}} {{release_bundle_version}}``

### DISTRIBUTE RELEASE BUNDLE
- Run ``jf ds rbd --dist-rules={{file_path}} {{release_bundle_name}} {{release_bundle_version}}``


### Challenge [Optional]
- Scan Release Bundle using Xray HINT: Need to be added to watch
- Delete older Release Bundle