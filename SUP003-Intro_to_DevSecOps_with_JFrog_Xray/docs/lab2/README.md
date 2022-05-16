# Lab2 - Create Watch and show violation

## Prerequisites
A SAAS Instance of JFrog. This will be provided as part of your enrollment to the Training class.

### Step 1 - Create a Watch

-  Click om the Watch tab and create a new watch name “swampup-watch”  
   <img src="/SU-201-Intro-to-JFrog-Xray/Lab2/images/1.png" alt="Create a watch" style="height: 100px; width:100px;"/>
   
-  Add the repositories to by clicking on the **Add Repositories** plus button and add the policy that we just created by clicking on the **Manage Policies** button 
   <img src="/SU-201-Intro-to-JFrog-Xray/Lab2/images/2.png" alt="mame the repo" style="height: 100px; width:100px;"/>

- Click **Save**.

### Step 2 - Show violations

- Navigate to **Application** > **Security & Compliance** > **Watch Violations**
- You will be able to see the watch that we have created in Step 1.
  ![Screen Shot 2021-05-21 at 11 31 12 AM](https://user-images.githubusercontent.com/7561138/119182671-1349e480-ba28-11eb-80a0-d0aa8d6f48d3.png)
 
- The Violations tab in a Watch is the central location for viewing the detected violations based on the policies and rules you have predefined on the Watch. You can view the list of the violations, search for violations according to filters, set ignore rules and edit the Watch in the Settings tab.
- In the Application module, under Security & Compliance, click Watch Violations then select the watch Swampup-watch and click the Violations tab to view the violations.
   <img src="/SU-201-Intro-to-JFrog-Xray/Lab2/images/3.gif" alt="mame the repo" style="height: 100px; width:100px;"/>
- Click on a specific watch from the main Watch module page to examine all of its defined violations. You can filter the watch violations using the search mechanism, according to text, created date, type, severity and CVE ID. To examine the details of a violation, click the violation from the list to display the Violation Details popup. 

  <img src="/SU-201-Intro-to-JFrog-Xray/Lab2/images/4.gif" alt="New rule" style="height: 100px; width:100px;"/>

- For **Ignore Violation**, Navigate to **Application** > **Security & Compliance** > **Watch Violation**. Open watch **"swampup-watch"** that we created in STEP 1. 

   ![Screen Shot 2021-05-23 at 9 53 07 AM](https://user-images.githubusercontent.com/7561138/119269499-d0654980-bbac-11eb-98a3-a1fb112aa417.png)
