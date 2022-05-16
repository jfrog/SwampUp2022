# Lab4 - Impact Analysis, Notifications Create Reports and Debug logs 

## Prerequisites
A SAAS Instance of JFrog. This will be provided as part of your enrollment to the Training class.

### Part 1 - Impact Analysis

- Xray analyzes how an issue in one component affects all others in your company and displays the chain of impact in a component graph, allowing you to have a clear understanding of the impact one component has on another. 

- Every time new component metadata is available (vulnerabilities, licenses, etc.), Xray looks up the component in the components graph and if the update matches any watches, Xray will generate an issue and create a map of its impact to determine which artifacts are ultimately affected by it. This process is called ["Impact Analysis"](https://jfrog.com/ja/article/impact-analysis/) .

    <img src="/SU-201-Intro-to-JFrog-Xray/Lab4/images/1.png" alt="Impact Analysis" style="height: 100px; width:100px;"/>


### Part 2 - Create Reports

- JFrog Xray **Reports** provide you the ability to collect and view information on the Xray scanning of your packages and artifacts. 
- To collect a report click on the **Security & Compliance** tab and the reports tab 

    ![reports](https://user-images.githubusercontent.com/7561138/119203311-97f82b00-ba47-11eb-8ac5-2a6597dc8174.gif)
