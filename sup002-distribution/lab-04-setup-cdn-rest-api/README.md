## SUP-002 Distribution 


#### Goal 
Goal of this lab to is to enable Amazon's CloudFront CDN for the repositories and download the artifact by Trigerring the REST API via cURL and then inspect the output to see wherther the artifact is being downloaded from CDN 


#### Prerequisites 

- Make sure the cURL is installed and Auth to interact with JFrog Platofrm is set up. Refer to this link for [pre-requisites](https://github.com/Krishnaj-jfrog/SwampUp2022/tree/main/sup002-distribution#requirements)


#### Download the binary with out the CDN enabled  

Run the below cURL command and inspect the output where the "HTTP/1.1 302 Found" string will be found and the binary gets downloaded from the S3 
Replace the variables <username> , <password or API Key> and <instance name> based on your instance in the below command and execute it 

```

curl -u -v <username>:<password or API Key> --request GET 'https://<instance name>.jfrog.io/artifactory/sup002-swampup-maven-dev-local/hello-world/hello-world-api-1.0.jar'

```


#### Enable CDN 

  - Enable CDN by going to Admin->Repositories->sup002-swampup-maven-dev-local->Advanced->Enable CDN 
       
       ![](https://github.com/Krishnaj-jfrog/SwampUp2022/blob/main/sup002-distribution/.images/cdn.png)


#### Download the binary with  CDN enabled

Now run the below cURL command and inspect the output where the "HTTP/1.1 302 Found" string will be found and the binary gets downloaded from the CDN 
  
Replace the variables <username> , <password or API Key> and <instance name> based on your instance in the below command and execute it 

  
```

curl -u -v <username>:<password or API Key> --request GET 'https://<instance name>.jfrog.io/artifactory/sup002-swampup-maven-dev-local/hello-world/hello-world-api-1.0.jar'

```
  

