## SUP-002 Distribution 


#### Goal 
Goal of this lab to is to Create, sign, and distribute an ad-hoc Release Bundle to distribution nodes. We will be using cURL to trigger the dynamic REST API  

#### Prerequisites 

- Make sure the cURL is installed and Auth to interact with JFrog Platofrm is set up. Refer to this link for [pre-requisites](https://github.com/Krishnaj-jfrog/SwampUp2022/tree/main/sup002-distribution#requirements)

#### Trigger the REST API 

Below commands need to be run from the scripts directory . Please make sure the [git repo](https://github.com/jfrog/SwampUp2022) is cloned to your local workspace .  

Replace the variables <username> , <password or API Key> and <instance name> based on your instance in the below command 

```
cd <git repo cloned>

curl -u <username>:<password or API Key> --request POST 'https://<instance name>/distribution/api/v1/dynamic/distribute' \
--header 'Content-Type: application/json' \
--header 'Accept: application/json' \
-T dynamic-distribution.json

```
  

###### Sample Request :
  
```
curl -u user1@jfrog.com:abcdedvehediepe --request POST 'https://user1.jfrog.io/distribution/api/v1/dynamic/distribute' \
--header "Accept: application/json" \
--header "Content-Type: application/json" \
-T dynamic-distribution.json 
```
  
###### Sample Response :
  
```
{"name":"RB-5-18-22","version":"1652897721998","id":579371468080205824,"sites
[{"name":"edge01","service_id":"jfrt@01g2ms6bk13gs41e9trqqp0egd","type":"artifactory,
{"name":"edge02","service_id":"jfrt@01g2ms5p7qps9v0f4tqs7v17mq","type":"artifactory"}]}
  
```
  
#### Validation 
Once the above cURL command is successful , You can login to your edge node and view the release bundle under distribution menu . The name of the release bundle will be printed in the response of the curl command ( for example : "name":"RB-5-18-22","version":"1652897721998" )
