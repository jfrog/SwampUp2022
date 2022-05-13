# Lab3 - IDE Integration, JFrog Pipelines, REST API and JFrog CLI example

## Prerequisites
A SAAS Instance of JFrog. This will be provided as part of your enrollment to the Training class. JFrog CLI installed that you can easily download [here](https://jfrog.com/getcli/).

### Part 1 - IDE Integration

- As we discuss on our session Xray is able to find vulnerabilities that discovered in production systems at runtime also through integration to CI systems like [Jenkins CI](https://www.jfrog.com/confluence/display/JFROG/Jenkins+Artifactory+Plug-in) and [TeamCity](https://www.jfrog.com/confluence/display/JFROG/TeamCity+Artifactory+Plug-in) at build time. 

- The IDE integration completes the CI/CD process, by bringing Xray's issue discovery one step earlier, to development time (shift left approach).
- Lets download and configure JFrog plugin from Marketplace into your IDE. Current support includes:
    1. [Visual Studio Code](https://marketplace.visualstudio.com/items?itemName=JFrog.jfrog-vscode-extension) - scanning your Maven, Python, Go and npm project dependencies
    2. [IntelliJ IDEA, WebStorm and GoLand](https://www.jfrog.com/confluence/display/JFROG/JFrog+IntelliJ+IDEA+Plugin) - scanning your Maven, Gradle, Go and npm project dependencies
    3. [Eclipse](https://www.jfrog.com/confluence/display/JFROG/JFrog+Eclipse+IDE+Plugin) - scanning your Maven, Gradle and npm project dependencies
    4. [Visual Studio](https://www.jfrog.com/confluence/display/JFROG/JFrog+Visual+Studio+Extension) - scanning your NuGet project dependencies

- Please add below snippet into **npm-example/package.json** under dependencies if you are using "npm-example" project

    ```
    "mathjs": "6.6.5",
    "jquery": "2.2.4"
    ```

- Please add below snippet into **maven-example/pom.xml** under dependencies if you are using "maven-example" project

    ```
    <dependency>
        <groupId>com.fasterxml.jackson.core</groupId>
        <artifactId>jackson-databind</artifactId>
        <version>2.9.5</version>
    </dependency>
    ```

- Here is an example from Visual Studio code
    <img src="/SU-201-Intro-to-JFrog-Xray/Lab3/images/1.gif" alt="Visual Studio Code" style="height: 100px; width:100px;"/>

- Save, commit these changes and push to remote main. 


### Part 2 - JFrog Pipelines integrtaion

- Open to **SU-201-Intro-to-JFrog-Xray/pipelines.yml** in your IDE. 
- Make sure that you have updated line 8 **path: JFrog/SwampUp2021** with **path: your_git_user"/SwampUp2021**
- Save and commit this change to remote main
- If you prefer to use npm project then, update line 53 **failOnScan: false** to **failOnScan: true** 
- If you prefer to use maven project then, update line 79 **failOnScan: false** to **failOnScan: true**
- If you would like to use both then feel free to update both line 53 & line 79
- Save and commit this change to remote main

You can also use XrayScan as a seperate step in your pipeline as below,
- JFrog Pipelines provide us the avility to add a step that will triggers [JFrog Xray](https://www.jfrog.com/confluence/display/JFROG/JFrog+Xray) scan for security vulnerabilities and license compliance if there was a watch created that covers the selected build,

    <img src="/SU-201-Intro-to-JFrog-Xray/Lab3/images/2.png" alt=" JFrog Pipelines integrtaion" style="height: 100px; width:100px;"/>


*******************************************************************************************************
**NOTE: Part 3 and 4 are optional**
*******************************************************************************************************

### Part 3 - REST API

- Xray REST API endpoints can be invoked in any of the standard ways to invoke a RESTful API. In this example we will use a simple cURL command example:

- The Platform REST URL is constructed of: 

    ```
    <JFrog URL>\/\<Service Context>api/\<API-Version>
    ```

- To get tge Xray [server version](https://www.jfrog.com/confluence/display/JFROG/Xray+REST+API#XrayRESTAPI-GetVersion) use the following commnad:

    <img src="/SU-201-Intro-to-JFrog-Xray/Lab3/images/3.png" alt="Xray REST API" style="height: 100px; width:100px;"/>



### Part 4 - JFrog CLI

-  After downloading and installing the JFrog CLI you may want to run the [JFrog Platform Configuration connand](https://www.jfrog.com/confluence/display/CLI/JFrog+CLI#JFrogCLI-JFrogPlatformConfiguration)  

-  When used with JFrog Xray, JFrog CLI uses the following syntax:

    ```
    $ jfrog xr command-name arguments options
    ```

- To run the version curl via JFrog CLI we will use the following command

    ```
    $ jfrog xr curl -XGET /api/v1/system/version
    ```
