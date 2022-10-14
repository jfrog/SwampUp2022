# LAB 0 - Configure JFrog CLI

### Prerequisites
- JFrog CLI is installed on your machine by running `jf -v`
  - if not installed then Download [JFrog CLI](https://jfrog.com/getcli/) based on our machine.
  

## Option 1 - SETUP JFROG CLI WITH MAIN JPD
- Checkout all ``jf`` configs ``jf config show``


- Configure CLI that point to JFrog Instance ``jf config add --interactive`` or ``jf c add --interactive``
    - Choose a server ID: ```${{unique name}}``` e.g. `s003`
    - JFrog platform URL: ```https://{{host}}.jfrog.io```
    - JFrog access token (Leave blank for username and password/API key): ```${{access_token}}```
        - Create access token from UI ``Administration`` -> ``Identity and Access`` -> ``Access Tokens``
    - Is the Artifactory reverse proxy configured to accept a client certificate (y/n) [n]?: ``n``


- Use newly created config ``jf config use SUP016``


- Healthcheck ``jf rt ping``

![lab0_cli_config](https://user-images.githubusercontent.com/7561138/164789237-bcfd7067-19f6-491f-aae5-e903ad691714.gif)



## Option 2 - SETUP JFROG CLI WITH MAIN JPD without ``--interactive``
- ``jf config add s003 --artifactory-url=https://$JFROG_PLATFORM/artifactory --user=$ADMIN_USER --password=$ADMIN_PASSWORD --interactive=false``


## CHALLENGE  [Optional]
- Export JFrog CLI config ``jf c export s003``
  - it generates the `TOKEN`
- Import on other system ``jf c import $TOKEN``
