# Lab3 - Run a maven vulnerable build first causing the build to fail due to security and license violations raised by Xray. Follow that up by running a vuln free and license compliant maven build that should succeed.

### Part 1 - Configure and run a maven vulnerable build using lab3_maven_vuln_build.sh. Xray scan and security violations that it generates should cause this build to fail. The sequence of steps in this script are outlined below.

-  Generate maven build configuration using **jf mvn-config**. This configures the Resolution repository for snapshot and release dependencies and Deployment repository for snapshot and release artifacts.

    ```
    jf mvnc --repo-resolve-snapshots s003-libs-snapshot --repo-resolve-releases s003-libs-release --repo-deploy-snapshots s003-libs-snapshot --repo-deploy-releases s003-libs-release

    ```

-  Run Maven Build using **jf mvn clean install** 

    ```
    jf mvn clean install -Dmaven.test.skip=true -Dartifactory.publish.artifacts=true --build-name=swampup22_s003_mvn_pipeline --build-number=$BUILD_NUMBER

    ```

- Collect Environment Variables using **jf rt build-collect-env**. Environment variables can be excluded using the build-publish command.

    ```
    jf rt bce swampup22_s003_mvn_pipeline $BUILD_NUMBER

    ```

- Publish Build Info using **jf rt build-publish**
    
  ```
  
  jf rt bp --build-url JFrog-CLI swampup22_s003_mvn_pipeline $BUILD_NUMBER
  
  ```
  
- Scan a published build-info with Xray using **jf build-scan**

  ```

  jf bs swampup22_s003_mvn_pipeline $BUILD_NUMBER
  
  ```
  
- Xray should fail the build with the following raised security violations
  ┌──────────┬─────────────────────┬──────────┬───────┬──────────┬─────────────────────┬───────────┬────────────────┐
  │ SEVERITY │ IMPACTED            │ IMPACTED │ TYPE  │ FIXED    │ COMPONENT           │ COMPONENT │ CVE            │
  │          │ PACKAGE             │ PACKAGE  │       │ VERSIONS │                     │ VERSION   │                │
  │          │                     │ VERSION  │       │          │                     │           │                │
  ├──────────┼─────────────────────┼──────────┼───────┼──────────┼─────────────────────┼───────────┼────────────────┤
  │ 🔥High   │ org.apache.logging. │ 2.14.1   │ Maven │ [2.12.2] │ org.apache.logging. │ 2.14.1    │ CVE-2021-44228 │
  │          │ log4j:log4j-core    │          │       │ [2.15.0] │ log4j:log4j-core    │           │                │
  │          │                     │          │       │ [2.3.1]  │                     │           │                │
  ├──────────┼─────────────────────┼──────────┼───────┼──────────┼─────────────────────┼───────────┼────────────────┤
  │ 🎃Medium │ org.apache.logging. │ 2.14.1   │ Maven │ [2.12.2] │ org.apache.logging. │ 2.14.1    │ CVE-2021-45046 │
  │          │ log4j:log4j-core    │          │       │ [2.16.0] │ log4j:log4j-core    │           │                │
  │          │                     │          │       │ [2.3.1]  │                     │           │                │
  └──────────┴─────────────────────┴──────────┴───────┴──────────┴─────────────────────┴───────────┴────────────────┘
  ┌─────────────────────────────────────────────┐
  │ No license compliance violations were found │
  └─────────────────────────────────────────────┘

- See violations in the Artifactory UI. Navigate to **Application** > **Security & Compliance** > **Watch Violations**. You will be able to see the watches that we have created in Step 1. Click on the swampup22_dev_watch watch. The Violations tab in a Watch is the central location for viewing the detected violations based on the policies and rules you have predefined on the Watch. You can view the list of the violations, search for violations according to filters, set ignore rules and edit the Watch in the Settings tab.

  ![New Watch](images/3-1.gif)

- **Ignore Violation** by navigating to **Application** > **Security & Compliance** > **Watch Violation**. Open watch **"swampup2022_dev_watch"** that we created in STEP 1 and hover your mouse over the right side of a violation.

  ![New Watch](images/3-2.gif)

### Part 2 - Configure and run the same maven build but this time with an update version of the dependency that doesn't have the vulnerability and you should see a successful build.

- Follow the same sequence of steps as above to run a successful build this time.

- This time the build should succeed with the following message

┌───────────────────────────────────┐
│ No security violations were found │
└───────────────────────────────────┘
┌─────────────────────────────────────────────┐
│ No license compliance violations were found │
└─────────────────────────────────────────────┘