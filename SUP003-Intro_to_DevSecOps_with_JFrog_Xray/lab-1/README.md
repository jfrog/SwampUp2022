# Lab1 - Xray Basics

## Prerequisites

- A SAAS Instance of JFrog Platform. This will be provided as part of your enrollment to the Training class.
- JFrog CLI is installed on your machine by running `jf -v` validate the version. 
  - We are also [setting us JFrog CLI](https://github.com/jfrog/SwampUp2022/tree/main/SUP003-Intro_to_DevSecOps_with_JFrog_Xray/lab-1#setup-jfrog-cli) against JFrog Platform to run automations. -  

## Exercises

1. Index your repositories/builds
  ![Index Repositories](images/1-1.gif)
2. Create your vulnerability policy
  ![Security Policy](images/1-3.gif)
  ![Security Policy Rules](images/1-4.gif)
3. Create your watches
   ![New Watch](images/2-1.gif)
4. Ignore violations at the build level
5. [OPTIONAL] Create a license and an operational policies

## Good to know : Automation via APIs

```bash
  # index repositories
  jf xr curl -XPUT "/api/v1/binMgr/1/repos" -H "Content-Type: application/json" -d "@index-repos.json"  

  # index builds
  jf xr curl -XPUT "/api/v1/binMgr/1/builds" -H "Content-Type: application/json" -d "@index-builds.json"

  # vulnerability policy
  jf xr curl -XPOST "/api/v2/policies" -H "Content-Type: application/json" -d "@prod-sec-policy.json"

  # license policy
  jf xr curl -XPOST "/api/v2/policies" -H "Content-Type: application/json" -d "@prod-lic-policy.json"

  # watch
  jf xr curl -XPOST "/api/v2/watches" -H "Content-Type: application/json" -d "@prod-watch.json"
```
