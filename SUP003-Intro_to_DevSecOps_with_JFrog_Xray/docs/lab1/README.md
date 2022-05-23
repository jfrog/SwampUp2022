# Lab1 - Get familiar with JFrog Platform and Xray

## Prerequisites
A SAAS Instance of JFrog. This will be provided as part of your enrollment to the Training class.

### Step1 - Add the Repositories and Builds to the Indexed Resources

- Login to your saas instance **{{instance_name}}**.jfrog.io with  your admin credentials

- Navigate to the **Administration** Module, **Xray** and click on Settings then **Indexed Resources**, now add the **Repositories** that you would like to index.

  ![Index Repositories](images/1-1.gif)
 
- Add **Builds** resources to get indexed
  
  ![Index Builds](images/1-2.gif)

### Step2 - Create a policy 

- Navigate to the **Administration** Module, expand the **Xray** menu at the bottom and click on **Watches & Policies** menu item. Click on **Create a Policy** and let's create our first **Security** policy called **"Prod-Security-Policy"**
  
  ![Security Policy](images/1-3.gif)

- Click on **New Rule** to add rules to **Prod-Security-Policy**. Add the following rule with **Criteria** and **Automatic Actions**. A default Automatic Action of Generate Violation is enabled for every Rule. Click **Save** and Click **Create**.
  * **Rule name**: high
  * **Criteria**: Minimum Severity: High
  * **Automatic Actions**: 
    * Notify Deployer
    * Block Download 
    * Fail Build
  
  ![Security Policy Rules](images/1-4.gif)

- Click on **New Policy**. Let's create a **License** policy with **"Prod-License-Policy"** name.
 
  ![License Policy](images/1-5.gif)

- Click on **New Rule** to add rule to **Prod-License-Policy**. Add a Rule for banned licenses with **Criteria** and **Automatic Actions** below. Click **Save** and Click **Create**.
  * **Rule name**: banned
  * **Criteria**: Banned Licenses: "BSD 2-Clause", GPL-3.0"
  * **Automatic Actions**:
    * Notify Deployer
    * Block Download
    * Fail Build
  
  ![License Policy Rules](images/1-6.gif)
  
**NOTE:** You may have noticed that Fields under **Criteria** are different for **License Policy** and for **Security Policy**.  





