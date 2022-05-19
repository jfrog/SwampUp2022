# From Git to Kubernetes: Cloud Native DevOps (Advanced) 

![Screen Shot 2022-05-16 at 9 31 16 PM](https://user-images.githubusercontent.com/2287053/168729373-27add5ef-c6ae-48b4-bccf-f215286c0bc9.png)


### In this training session, you’ll learn best-practices when using the JFrog Platform to store and manage your Docker images and Kubernetes deployments from beginning to end, while also setting up a continuous build, test and deploy pipeline. We’ll cover best practices for managing and creating Docker registries and Helm repositories, testing and promotion of Docker containers, and taking your containers all the way to production using the JFrog Platform and Kubernetes together. While the use cases discussed will cover and utilize the entire JFrog Platform, the majority of the hands-on training will focus on JFrog Artifactory and CI tools working together.


#### <ins>Who should attend:</ins> Developers, Development Managers, and DevOps Engineers who are currently using JFrog Artifactory and Docker, Current Docker users who are considering using JFrog Artifactory. A good understanding of Docker containers and CI servers for cloud-native pipelines is required. 

#### <ins>Prerequisites</ins>: Knowledgeable with Git and Docker (git and docker clients installed including having a GitHub account). Basic understanding of DevOps concepts (familiarity with JFrog Artifactory).

### <ins>Lab #1 - Onboarding to Labs Environment</ins>

- Login to your SaaS Enterprise+ environment and make sure you are able to connect with your credentials.
- Fork this ([https://github.com/jfrog/SwampUp2022](https://github.com/jfrog/SwampUp2022)) repository to your GitHub Account (Top right - Click on "Fork"):

![Screen Shot 2022-05-16 at 9 33 21 PM](https://user-images.githubusercontent.com/2287053/168729604-840784e4-9248-4055-bb23-ca91bc7eb18d.png)


- Run ```git clone https://github.com/<YOUR_GITHUB_USERNAME>/SwampUp2022.git``` against your forked repository.
- Run ```cd SwampUp2022/SUP008-From-Git-to-Kubernetes``` which is our class's folder with all the relevant code.
- Open the file "back/pipelines.resources.yaml" and change the configuration.path in the following snippet based on your github username:</br>
![alt text](https://i.ibb.co/88FVvL5/Update-Git.jpg)</br>
- Commit the changes to your forked repository:
 ```
git add .
git commit -m "updated my repo path in the source code resource"
git push
```
- Create the following Integrations (Administration Panel -> Pipelines -> Integrations -> Add an Integration), while using your SaaS instance values:
    - "github" integration (type: "GitHub") with [personal access token](https://docs.github.com/en/github/authenticating-to-github/creating-a-personal-access-token) from your github account:</br>
    <img src="https://i.ibb.co/qkGd65z/Screen-Shot-2021-05-01-at-13-55-15.png" width="50%" height="50%"></br>
    - "artifactory" integration (type: "Artifactory"):</br>
    <img src="https://i.ibb.co/jVMQ3Ky/arti-integration.jpg" width="60%" height="50%"></br>
    - "docker integration" (type: "Docker", used for accessing Artifactory as a Docker Registry):</br>
    <img src="https://i.ibb.co/WzMhTDC/docker-integration.jpg" width="60%" height="50%"></br>
    - "generic integration" (type: "Generic"), where the value equals to your SaaS server name (for example, for sup008epsu01.jfrog.io the server name is sup008epsu01): </br>
    <img src="https://i.ibb.co/CzmrF3n/Screen-Shot-2021-05-01-at-13-55-26.png" width="50%" height="50%"></br>
- Create a Pipeline Source based on the forked repository and choose "From yaml", with the following Pipeline Config File Filter: ```SUP008-From-Git-To-Kubernetes/(.*)pipelines(.*).yaml``` and branch ```main```:</br>
- <img src="https://i.ibb.co/3mDKtnJ/pipeline-source-1.jpg" width="60%" height="60%"></br>
- <img src="https://i.ibb.co/XCv4gJp/pipeline-source.jpg" width="40%" height="40%"></br>
- Make sure all pipelines were loaded under "My Pipelines":</br> 
![alt text](https://i.ibb.co/6FR9BSd/Loaded-new-pipelines.jpg)</br>
- Run the "sup_008_on_boarding_environment" to populate all repositories for our demo.</br>
<img src="https://i.ibb.co/NjcnqKf/onboarding-pipeline.jpg" width="50%" height="50%"></br>
The following repositories should be created (Go to "Artifactory" -> "Artifacts"):</br>
<img src="https://i.ibb.co/kKnCmQT/Created-repos.jpg" width="25%" height="25%"></br>
<b>* For any issues, please request assistance from the instructor and T.A's!</b>

### <ins>Lab #2 - Understanding the Environment</ins>

Complete/answer the following tasks/questions:
- Run all pipelines until your environment is GREEN:</br>
<img src="https://i.ibb.co/bP4tRcY/Screen-Shot-2021-05-11-at-14-34-34.png" width="55%" height="55%"></br>
- Understand the relationship between the different pipelines - in what ways a pipeline can be triggered?
- How many repositories were created for the backend application?
- How many repositories were created for the frontend application?

### <ins>Lab #3 - Adding Security</ins>

- Index all builds from Xray's Administration Panel (Xray -> Settings -> Builds):</br>
<img src="https://i.ibb.co/G5PSk9Y/Loaded-pipelines.jpg" width="55%" height="55%"></br>
- View the security issues and license discovered by Xray for every individual build.
- Add one Security and one License Policies: [Creating a Policy](https://www.jfrog.com/confluence/display/JFROG/Creating+Xray+Policies+and+Rules#CreatingXrayPoliciesandRules-CreatingaPolicy).
- Add a watch per application (one watch for the backend; one watch for the frontend) and assign the policies you have created to these watches: [Configure Xray Watches](https://www.jfrog.com/confluence/display/JFROG/Configuring+Xray+Watches).
- Explore the violations that were NOW created.

### <ins>Extras - Do it yourself!</ins>

##### <ins>1 Bonus - Creating a Release Bundle & Distributing to Edge</ins></br>
- From Distribution UI, [Creating a Release Bundle](https://www.jfrog.com/confluence/display/JFROG/Distributing+Release+Bundles#DistributingReleaseBundles-CreatingaNewReleaseBundle) that contains:
    - The promoted docker images for the backend and front end applications.
    - The helm charts for both applications.
- Sign the release bundle.
- [Distribute the Release Bundle](https://www.jfrog.com/confluence/display/JFROG/Distributing+Release+Bundles#DistributingReleaseBundles-DistributingaReleaseBundle) to the edge.
- Login to your edge node, and view the release bundle that was just distributed.
- Download the release bundle from the edge.
- This application is now ready to be deployed to any k8s cluster of your choice :-)</br>
##### <ins>2 Bonus:</ins> [Index your Release Bundle with Xray](https://www.jfrog.com/confluence/display/JFROG/Distributing+Release+Bundles#DistributingReleaseBundles-XrayScanningofReleaseBundlesxraydata), and view the results under 'Xray' tab in Distribution.</br>
##### <ins>3 Bonus:</ins> Implement helm chart promotion: extend the pipelines with adding a quality gate after publishing the helm chart - what types of quality gate can you use?</br>
