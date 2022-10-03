# SUP-002 Distribution 


## Goal 
Goal of this lab to is to create a release bundle and distribute the release bundle version 2.0 to the available edge nodes and validate using the Jfrog CLI 

### Prerequisites 

- Jfrog CLI is installed and configured . Refer to this link on how to configure [CLI](https://github.com/Krishnaj-jfrog/SwampUp2022/tree/main/sup002-distribution#set-up-jfrog-cli) 

### Distribution 

Below commands need to be run from the scripts directory . Please make sure the [git repo](https://github.com/jfrog/SwampUp2022) is downlaoded/cloned to your local workspace .  

- Create a Release bundle . 
  
  Below commands takes `rb.json` as one of the inputs which has the AQL query defined to collect all the artifacts that needs to be part of release bundle . Type `jf ds release-bundle-create` to explore the options 
 
 ```
  cd <git repo cloned>
  cd sup002-distribution/lab-01-classic-distribution-cli/scripts 
  jf ds release-bundle-create  'swampup-release-2022' '2.0' --spec=rb.json --release-notes-path release-notes.txt --target-props 'release_type=main;release_name=swampup-2022'
  ```
  
  Once the above commands are successful , You can login to the UI and see the new release bundle created under the distribution menu 

- Sign a release bundle 
  
  ```
  jf ds release-bundle-sign  'swampup-release-2022' '2.0' 
  ```

- Distribute a release bundle

  Below command takes `distribute_rules.json` as one of the inputs which has the edge nodes defined for the release bundle to be distributed . Take a look at the json file to make sure the edge nodes are matching the ones that are on your instances .
Run the `jf ds release-bundle-distribute` to explore the options


  ```
  jf ds release-bundle-distribute  'swampup-release-2022' '2.0' --dist-rules=distribute_rules.json
  
  ```
  Once the above command is successful, Status of the distribtion can be viewed on the 'Distribution Menu' on the JPD UI 

- Verify the release bundle is distributed 

   Login to the Edge nodes UI and validate whether 'swampup-release-2022' is shown on the 'Distribution' Menu 




