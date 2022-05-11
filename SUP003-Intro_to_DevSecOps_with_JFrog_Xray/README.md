# SU-201 Intro to DevSecOps with JFrog Xray

### Prerequisites 

- Fork [jfrog/SwampUp2021](https://github.com/jfrog/SwampUp2021) github repository. All content related to "SU-201-Introduction to DevSecOps with JFrog Xray" is under "**SU-201-Intro-to-JFrog-Xray/**".
- Generate a Github personnal [access token](https://docs.github.com/en/github/authenticating-to-github/keeping-your-account-and-data-secure/creating-a-personal-access-token) with the following [permissions](https://www.jfrog.com/confluence/display/JFROG/GitHub+Integration) <br/>
**NOTE**: if you already have GitHub access token then skip this step else create GitHub account first and then follow above steps.
- git clone the forked repo on your workstation
- Please complete **Step 3** and **Step 5** from below.
- We will be using IDE as part of our labs so please download and install one of the IDE if you do not have one install on your workstation,
  - [Visual Studio Code](https://marketplace.visualstudio.com/items?itemName=JFrog.jfrog-vscode-extension) or 
  - [IntelliJ IDEA, WebStorm and GoLand](https://www.jetbrains.com/idea/download/#section=mac) or 
  - [Eclipse](https://www.eclipse.org/downloads/) or 
  - [Visual Studio](https://visualstudio.microsoft.com/)


*******************************************************************************************************************
**NOTE: Step 1, 2 and 4 have been configured in some of your environment already. So please skip those steps if its configured.**
**NOTE: If you donot see those steps configured then please go through all steps. or you can use SU-201-Intro-to-JFrog-Xray/scripts/setup.sh to populate repositories using JFROG CLI and skip Step 1 and 2.**
*******************************************************************************************************************


### Step 1 - Create Repositories in JFrog Artifactory

- Login to your saas instance **{{instance_name}}**.jfrog.io with  your admin credentials
- Nevigate to Welcome, **{{user}}** from top right
- Click on dropdown and select **Quick Setup**
- Select Package Type **NPM** or **MAVEN** and click **Next**
- Enter repository name **su201** and click **Create**

![create_repos](https://user-images.githubusercontent.com/7561138/117177841-4f254e80-ad86-11eb-8184-20ffbe5c7af9.gif)

**NOTE: Please use the same name as above to be consistent throughout the training class.** <br/> 
It will create local, remote and virtual repositories.<br/> 
e.g. <br/> 
**NPM** - su201-npm-local , su201-npm-remote, su201-npm <br/> 
**MAVEN** - su201-libs-release-local, su201-libs-snapshot-local, su201-maven-jcenter, su201-libs-release, su201-libs-snapshot<br/> 


### Step 2 - Configure Virtual Repository

- In the left sidebar, **Adminitration** > **Repositories** > **Repositories**
- Click on **Virtual** and select virtual repository that created as part of Step 1 (**su201-npm** or **su201-libs-release** or **su201-libs-snapshot**)
- Scroll down and locate **Default Deployment Repository**
- From dropdown, select local repository that created in Step 1. (Artifacts create by CI will be store under this local repository)

![set_deployment_repo](https://user-images.githubusercontent.com/7561138/117177860-53516c00-ad86-11eb-905f-31128c8e164d.gif)


### Step 3 - Create GitHub integration with JFrog Pipeline

- In the left sidebar, click **Administration** > **Pipelines** > **Integration**
- Click **Add an Integration** from top right corner
- Add integration Name "**GitHub**" (Please use **GitHub (Same name)** as it is being used in pipelines.yml file)
- Select **GitHub** from **Integration Type** dropdown
- Enter GitHub API Token in **Access Token** (Use Github personnal access token that we created in Prerequisites)
- Click **Test Connection** to make sure connection has been established successfully. 
- Click **Create**

![github_pipeline](https://user-images.githubusercontent.com/7561138/117182982-dd500380-ad8b-11eb-919d-9b051158bd1a.gif)

### Step 4 - Create Artifactory integration with JFrog Pipeline

- In the left sidebar, click **Administration** > **Pipelines** > **Integration**
- Click **Add an Integration** from top right corner
- Add integration Name "**Artifactory**" (Please use **Artifactory (Same name)** as it is being used in pipelines.yml file)
- Select **Artifactory** from **Integration Type** dropdown
- **Artifactory URL** will be autofill with your SaaS instance (No need to change)
- **User** will be autofill with your SaaS instance user (No need to change)
- Click on **Get API Key** which will fill **API Key** 
- Click **Test Connection** 
- Click **Create**

![artifactory_pipeline](https://user-images.githubusercontent.com/7561138/117183054-f658b480-ad8b-11eb-9e9a-c07e3a415cbd.gif)

### Step 5 - Add Pipeline Source

- In your workstation, open **SwampUp2021/SU-201-Intro-to-JFrog-Xray/pipelines.yml** in your IDE/Text Editor
- Change line 8, **path: jfrog/SwampUp2021** to **path: {{your_git_user}}/SwampUp2021** save and commit your changes to remote "main" branch
  - git add SU-201-Intro-to-JFrog-Xray/pipelines.yml
  - git commit -m "rename path value in pipeline.yml"
  - git push -u origin main
- In the left sidebar, click **Administration** > **Pipelines** > **Pipeline Sources**
- Click **Add Pipeline Source** from top right corner
- Select **From YAML** 
- For **SCM Provider Integration**, Select **GitHub** from drop down  (based on Step 3 github integration name will appear here)
- For **Repository Full Name**, Select **{{your_git_user}}/SwampUp2021** 
- For **Branch**, Select **main**  
- For **Pipeline Config File Filter**, update default value with **SU-201-Intro-to-JFrog-Xray/pipelines.yml**
- Click **Create Source**
- Latest Status will be **Syncying** and later it will change to **Success | Error**  

![add_pipeline_source](https://user-images.githubusercontent.com/7561138/117591177-094eea00-b0e8-11eb-9c50-7b3266dc30c6.gif)
