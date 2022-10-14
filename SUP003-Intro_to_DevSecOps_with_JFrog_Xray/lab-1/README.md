# Lab1 - Indexing Resources and Create Policy
- Prerequisites
- Index Repositories
- Index Builds
- Create Security Policy
- Create License Policy 
- Setup JFrog CLI
- Challenge 

<br/>

## Prerequisites
- A SAAS Instance of JFrog Platform. This will be provided as part of your enrollment to the Training class.
- Make sure set of repositories appear in your JFrog Platform.
  - If not then please run `./scripts/CREATE_REPO_RESCUE.sh` to create those repositories created. 
  - Please let us know if you need help. 
    - We may need to install jq so run `sudo apt-get install -y jq`
- JFrog CLI is installed on your machine by running `jf -v` validate the version. 
  - We are also [setting us JFrog CLI](https://github.com/jfrog/SwampUp2022/tree/main/SUP003-Intro_to_DevSecOps_with_JFrog_Xray/lab-1#setup-jfrog-cli) against JFrog Platform to run automations. -  

<br/>

## INDEX REPOSITORIES 
### INDEX REPOSITORIES using UI

- Login to your saas instance **{{instance_name}}**.jfrog.io with  your admin credentials

- Navigate to the **Administration** Module, **Xray** and click on Settings then **Indexed Resources**

- Add the **Repositories** resources to get indexed

  ![Index Repositories](images/1-1.gif)

<br/>

### INDEX REPOSITORIES using AUTOMATION [Optional]
- Run 
```
  jf xr curl -XPUT "/api/v1/binMgr/1/repos" -H "Content-Type: application/json" -d "@index-repos.json"
  
```

<br/> 

## INDEX BUILDS 
### INDEX BUILDS using UI
- Add **Builds** resources to get indexed
  
  ![Index Builds](images/1-2.gif)

<br/>

### INDEX BUILDS using AUTOMATION [Optional]
- Run 
```
  jf xr curl -XPUT "/api/v1/binMgr/1/builds" -H "Content-Type: application/json" -d "@index-builds.json"
```

<br/>
<br/>
<br/>

## CREATE SECURITY POLICY
### CREATE A SECURITY POLICY using UI
- Navigate to the **Administration** Module, expand the **Xray** menu at the bottom and click on **Watches & Policies** menu item.
- Click on **Create a Policy** and let's create our first **Security** policy called **"prod-security-policy"**
  
  ![Security Policy](images/1-3.gif)

<br/>

- Click on **New Rule** to add rules to **prod-security-policy**. Add the following rule with **Criteria** and **Automatic Actions**. A default Automatic Action of Generate Violation is enabled for every Rule. Click **Save** and Click **Create**.
  * **Rule name**: high
  * **Criteria**: Minimum Severity: High
  * **Automatic Actions**: 
    * Notify Deployer
    * Block Download 
    * Fail Build
  
  ![Security Policy Rules](images/1-4.gif)

<br/>

### CREATE A SECURITY POLICY using AUTOMATION [Optional]
- Run
```
  jf xr curl -XPOST "/api/v2/policies" -H "Content-Type: application/json" -d "@prod-sec-policy.json"
```
  - With Severity - CRITICAL, HIGH, MEDIUM, LOW with different action items
- Confirm Security Policy named with ``prod-security-policy`` is created

<br/>

## CREATE LICENSE POLICY
### CREATE A LICENSE POLICY using UI
- Click on **New Policy**. Let's create a **License** policy with **"prod-license-policy"** name.
 
  ![License Policy](images/1-5.gif)

<br/>

- Click on **New Rule** to add rule to **prod-license-policy**. Add a Rule for banned licenses with **Criteria** and **Automatic Actions** below. Click **Save** and Click **Create**.
  * **Rule name**: banned
  * **Criteria**: Banned Licenses: "BSD 2-Clause, GPL-3.0"
  * **Automatic Actions**:
    * Notify Deployer
    * Block Download
    * Fail Build
  
  ![License Policy Rules](images/1-6.gif)
  
**NOTE:** You may have noticed that Fields under **Criteria** are different for **License Policy** and for **Security Policy**.  

<br/>

### CREATE A LICENSE POLICY using AUTOMATION [Optional]
- Run 
```
  jf xr curl -XPOST "/api/v2/policies" -H "Content-Type: application/json" -d "@prod-lic-policy.json"
```
- Confirm License Policy named with ``prod-license-policy`` is created

<br/>
<br/>
<br/>


## SETUP JFROG CLI
- Configure JFrog CLI [Lab-0](https://github.com/jfrog/SwampUp2022/tree/main/SUP003-Intro_to_DevSecOps_with_JFrog_Xray/lab-0#lab-0---configure-jfrog-cli)

<br/>
<br/>
<br/>

## CHALLENGE  [Optional]
- Create Policy `Operational Risk` type with Rules using UI
- Create Policy `Operational Risk` type with Rules using Automation



