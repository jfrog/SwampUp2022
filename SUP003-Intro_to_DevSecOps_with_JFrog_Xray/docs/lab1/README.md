# Lab1 - Get familiar with JFrog Platform and Xray

## Prerequisites
A SAAS Instance of JFrog. This will be provided as part of your enrollment to the Training class.

### Step1 - Add the repositories to the Indexed Resources

- Login to your saas instance **{{instance_name}}**.jfrog.io with  your admin credentials

- Navigate to the **Administration** Module, **Xray** and click on Settings then **Indexed Resources**, now add the **Repositories** that you would like to index.

  ![Index Repositories](images/1-1.gif)
 
- Add **Builds** resources to get indexed
  
  ![Index Builds](images/1-2.gif)

### Step2 - Create a policy 

- Navigate to the **Administration** Module, expand the **Xray** menu at the bottom and click on the **Watches & Policies** menu item.
  ![Index Builds](images/1-3.gif)
  
- Click on the **Create a Policy** or **New Policy** (if you already have one) and Let's create our first **Security** policy with **"sec_policy"** name
  ![Index Builds](images/1-4.gif)

- Click on **New Rule** to add rule to **sec_policy**. Add one or many rules with **Criteria** and **Automatic Actions**. Click **Save** and Click **Create**. If you like, you select **Notify Deployer** option upder **Automatic Actions**. NOTE: We will enable these Automatic Actions as part of later Labs.  
  ![Index Builds](images/1-5.gif)

- Click on the **New Policy**. Let's create our second **License** policy with **"lic_policy"** name.
  ![Index Builds](images/1-6.gif)

- Click on **New Rule** to add rule to **lic_policy**. Add one or many rules with **Criteria** and **Automatic Actions**. Click **Save** and Click **Create**.
  ![Index Builds](images/1-7.gif)
  
**NOTE:** You may have noticed that Fields under **Criteria** are different for **License Policy** and for **Security Policy**.  





