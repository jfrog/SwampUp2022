# Lab1 - Get familiar with JFrog Platform and Xray

## Prerequisites
A SAAS Instance of JFrog. This will be provided as part of your enrollment to the Training class.

### Step1 - Add the repositories to indexing resources

- Login to your saas instance **{{instance_name}}**.jfrog.io with  your admin credentials

- Navigate to the **Administration** Module, **Xray** and click on settings then **Indexed Resources**, now add the **Repositories** that you would like to indexed.
 
  <img src="/SU-201-Intro-to-JFrog-Xray/Lab1/images/8.gif" alt="Watches & Policies tab" style="height: 100px; width:100px;"/>
 
- Add **Builds** resources to get indexed,
![1-2](https://user-images.githubusercontent.com/7561138/118909879-804e6480-b8d8-11eb-926c-aff16a71608c.gif)


### Step2 - Create a policy 

- Navigate to the **Administration** Module, expand the **Xray** menu at the bottom and click on the **Watches & Policies** menu item.
  <img src="/SU-201-Intro-to-JFrog-Xray/Lab1/images/1.png" alt="Watches & Policies tab" style="height: 100px; width:100px;"/>
  
- Click on the **Create a Policy** or **New Policy** (if you already have one) and Let's create our first **Security** policy with **"sec_policy"** name
![2-1](https://user-images.githubusercontent.com/7561138/118908191-c6ee8f80-b8d5-11eb-9a72-b35d542332dc.gif)


- Click on **New Rule** to add rule to **sec_policy**. Add one or many rules with **Criteria** and **Automatic Actions**. Click **Save** and Click **Create**. If you like, you select **Notify Deployer** option upder **Automatic Actions**. NOTE: We will enable these Automatic Actions as part of later Labs.  
![2-2](https://user-images.githubusercontent.com/7561138/118908208-cd7d0700-b8d5-11eb-8abe-f6247d0eed61.gif)


- Click on the **New Policy**. Let's create our second **License** policy with **"lic_policy"** name.
![2-3](https://user-images.githubusercontent.com/7561138/118908220-d4a41500-b8d5-11eb-808e-cd9a6599ff5f.gif)


- Click on **New Rule** to add rule to **lic_policy**. Add one or many rules with **Criteria** and **Automatic Actions**. Click **Save** and Click **Create**.
![2-4](https://user-images.githubusercontent.com/7561138/118908229-da99f600-b8d5-11eb-8865-0668317538e0.gif)

**NOTE:** You may have noticed that Fields under **Criteria** are different for **License Policy** and for **Security Policy**.  





