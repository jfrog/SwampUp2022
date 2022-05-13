# LAB 4 - Configure Replication

## Prerequisites
- Lab-0 - Configure JFrog CLI
- Lab-1 - Repository Provisioning
- Lab-2 - Role-Based Access Control
- Lab-3 - Build Integration and Properties

### CREATE REPLICATION TEMPLATE
- Run 

    ``jf rt replication-template template-pull.json``

     or

    ``jf rt rplt template-pull.json``

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

### CREATE REPLICATION USING TEMPLATE
- Run 

    ``jf rt replication-create template-pull.json``

    or

    ``jf rt rplc template-pull.json``

## CHALLENGE - Replications [Optional]
- Setup Push based replication between two instances. 
  - NOTE: target serverId requires JFrog CLI config with username/password  - In lab-0, we used access token. Instead of that we need to use username/password.
