# LAB 2 - Role-Based Access Control

### Prerequisites
- Lab-0 - Configure JFrog CLI
- Lab-1 - Repository Provisioning

### Create User (Internal)
- Please review the CSV that is part of the lab where `username`, `password`, `email` defined for few test users
- Run ``jf rt users-create --csv users.csv``

### Create Groups and add users to groups
Create Groups
- Run ``jf rt group-create developers``
- Run ``jf rt group-create ops``
- Run ``jf rt group-create secops``
Adding Users to Groups
- Developers - mike,jennifer
  - Run ``jf rt group-add-users "developers" "mike,jennifer"``
- ops - bob, rolando, jennifer, support
  - Run ``jf rt group-add-users "ops" "bob,jennifer,rolando,support"``
- secops - irene, matt, jennifer
  - Run ``jf rt group-add-users "secops" "irene,matt,jennifer"``

### Create Permission Target Template
- Run ``jf rt permission-target-template pt-template.json``
  - Insert the permission target name > `development`
  - You can type ":x" at any time to save and exit. 
  - Select the permission target section to configure (press Tab for options): `repo`
    Insert the section's repositories value.
    - You can specify the name "ANY" to apply to all repositories, "ANY REMOTE" for all remote repositories or "ANY LOCAL" for all local repositories:
    - The value should be a comma separated list > `{{list_of_repos}}`
    - Insert a value for include-patterns: ↵
    - The value should be a comma separated list (press enter for default) [**]: ↵
    - Insert value for exclude-patterns: ↵
    - The value should be a comma separated list (press enter for default) []: ↵
    - Configure actions for users? (press Tab for options): [yes]: `no`
    - Insert user name (press enter to finish) > ↵
    - Configure actions for groups? [yes]: `yes`
    - Insert group name (press enter to finish) > `developers`
    - Select permission value for developers (press tab for options or enter to finish) > `read`
    - Select permission value for developers (press tab for options or enter to finish) > ↵
    - Insert group name (press enter to finish) > `secops`
    - Select permission value for secops (press tab for options or enter to finish) > `managedXrayMeta`
    - Select permission value for secops (press tab for options or enter to finish) > ↵
    - Insert group name (press enter to finish) > `ops`
    - Select permission value for ops (press tab for options or enter to finish) > `manage`
    - Select permission value for ops (press tab for options or enter to finish) > `write`
    - Select permission value for ops (press tab for options or enter to finish) > ↵
    - Insert group name (press enter to finish) > ↵
  - Select the permission target section to configure (press Tab for options): `build`
    - Insert a value for include-patterns: ↵
    - The value should be a comma separated list (press enter for default) [**]: ↵
    - Insert value for exclude-patterns: ↵
    - The value should be a comma separated list (press enter for default) []: ↵
    - Configure actions for users? (press Tab for options): [yes]: `no`
    - Insert user name (press enter to finish) > ↵
    - Configure actions for groups? [yes]: `yes`
    - Insert group name (press enter to finish) > `ops`
    - Select permission value for ops (press tab for options or enter to finish) > `manage`
    - Select permission value for ops (press tab for options or enter to finish) > ↵
    - Insert group name (press enter to finish) > ↵
    - Select the permission target section to configure (press Tab for options): `:x`

### Create Permission Target using Template
- Run ``jf rt permission-target-create pt-template.json``

### Create JFrog Project [Optional]
--- NO NATIVE or CURL SUPPORT for now
curl -XPOST -H "Authorization: Bearer {{access_token}}"  -H 'Content-Type:application/json' https://{{host}}/access/api/v1/projects  -T ./create-project.json

### Delete User (Internal) - [POST SESSION TASK]
- Run ``jf rt users-delete "mike,bob,jennifer,rolando,irene,matt,support" --quiet``
or
- Run ``jf rt users-delete --csv users.csv``

### Delete Group - [POST SESSION TASK]
- Run ``jf rt group-delete developers``