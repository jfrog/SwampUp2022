# LAB 4 - Configure Replication

## Prerequisites
- Lab-0 - Configure JFrog CLI
- Lab-1 - Repository Provisioning
- Lab-2 - Role-Based Access Control
- Lab-3 - Build Integration and Properties

<br />

## CREATE REPLICATION TEMPLATE
- Run 

    ``jf rt replication-template template-pull.json``

     or

    ``jf rt rplt template-pull.json``

  - Select replication job type (press Tab for options): `pull`
  - Enter source repo key > `swampup2022-docker-main`
  - Enter cron expression for frequency (for example, 0 0 12 * * ? will replicate daily) > `*/10 * * * * ?`
  - You can type ":x" at any time to save and exit.
  - Select the next property > `enabled`
  - Insert the value for enabled (press Tab for options): > `true` 
  - Select the next property > `enableEventReplication` 
  - Insert the value for enableEventReplication (press Tab for options): > `true` 
  - Select the next property > `syncDeletes` 
  - Insert the value for syncDeletes (press Tab for options): > `true` 
  - Select the next property > `syncProperties` 
  - Insert the value for syncProperties (press Tab for options): > `true` 
  - Select the next property > `syncStatistics` 
  - Insert the value for syncStatistics (press Tab for options): > `true` 
  - Select the next property > `:x`

- Validate template template-pull.json is created successfully. `- ls -la`
- View template

      ```json
      {
        "cronExp": "*/10 * * * * ?",
        "enableEventReplication": "true",
        "enabled": "true",
        "repoKey": "swampup2022-docker-main",
        "syncDeletes": "true",
        "syncProperties": "true",
        "syncStatistics": "true"
      }
      ```

<br />

## CREATE REPLICATION USING TEMPLATE
- Run 

    ``jf rt replication-create template-pull.json --vars "url=https://soleng.jfrog.io/artifactory/swampup2022-docker-local"``

    or

    ``jf rt rplc template-pull.json --vars "url=https://soleng.jfrog.io/artifactory/swampup2022-docker-local"``

<br />


## RUN SCRIPT [Mandatory]
- Run ``sh lab_4_rescue.sh``

## CHALLENGE - Replications [Optional]
- Setup Push based replication between two instances. 
  - NOTE: target serverId requires JFrog CLI config with username/password  - In lab-0, we used access token. Instead of that we need to use username/password.


**Blog**
[Replication: Using Artifactory to Manage Binaries Across Multi-Site Topologies](https://jfrog.com/whitepaper/replication-using-artifactory-to-manage-binaries-across-multi-site-topologies/) 