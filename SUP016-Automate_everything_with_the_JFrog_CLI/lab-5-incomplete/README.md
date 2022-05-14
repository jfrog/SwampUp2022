# LAB 5 - Artifactory Query Language

## Prerequisites
- Lab-0 - Configure JFrog CLI
- Lab-1 - Repository Provisioning
- Lab-2 - Role-Based Access Control
- Lab-3 - Build Integration and Properties

## Artifactory Query Language 
**Artifactory Query Language** (AQL) is specially designed to let you **uncover any data** related to the artifacts and builds stored within Artifactory. Its syntax offers a simple way to formulate complex queries that specify any number of search criteria, filters, sorting options, and output parameters. AQL is exposed as a RESTful API which uses data streaming to provide output data resulting in **extremely fast response times and low memory consumption**. AQL can only extract data that resides in your instance of Artifactory, so it runs on **Local Repositories, Remote Repositories** and **Virtual Repositories**.


- [Entities and Fields](https://www.jfrog.com/confluence/display/JFROG/Artifactory+Query+Language#ArtifactoryQueryLanguage-EntitiesandFields) 
  - You may issue a find request according to the syntax below, and configure your request to display fields from any of the domains.
- Syntax 
    ```json
    <domain_query>
            .find(<criteria>)
            .include(<fields>)
            .sort(<order_and_fields>)
            .offset(<offset_records>)
            .limit(<num_records>)
  ```

<br/>
<br/>

| Terminology  | Description |
| ------------- | ------------- |
| domain_query  | The query corresponding to the primary [domain](https://www.jfrog.com/confluence/display/JFROG/Artifactory+Query+Language#ArtifactoryQueryLanguage-EntitiesandFields). Must be one of items, builds or entries.  |
| criteria  | The search [criteria](https://www.jfrog.com/confluence/display/JFROG/Artifactory+Query+Language#ArtifactoryQueryLanguage-ConstructingSearchCriteria) in valid JSON format  |
| fields  | (Optional) There is a default set of fields for query output. This parameter lets you [specify a different set of fields](https://www.jfrog.com/confluence/display/JFROG/Artifactory+Query+Language#ArtifactoryQueryLanguage-SpecifyingOutputFields) that should be included in the output.  |
| order_and_fields  | (Optional) The fields on which the output should be [sorted](https://www.jfrog.com/confluence/display/JFROG/Artifactory+Query+Language#ArtifactoryQueryLanguage-Sorting), and the sort order. A default set of fields and sort order is defined for each domain.  |
| num_records  | (Optional) The maximum [number of records](https://www.jfrog.com/confluence/display/JFROG/Artifactory+Query+Language#ArtifactoryQueryLanguage-limitDisplayLimitsandPagination) that should be extracted. If omitted, all records answering the query criteria will be extracted.  |
| offset  | (Optional) The offset from the first record from which to display results (i.e. how many results should be skipped for display)  |

<br/>

- [Comparison Operators](https://www.jfrog.com/confluence/display/JFROG/Artifactory+Query+Language#ArtifactoryQueryLanguage-ComparisonOperators)
  - [Relative Time Operator](https://www.jfrog.com/confluence/display/JFROG/Artifactory+Query+Language#ArtifactoryQueryLanguage-RelativeTimeOperators)


### CONSTRUCT SEARCH CRITERIA
```textmate 
{
    "<field>" : {
        "<comparison operator>" : "<value>"
    }
}
```

<br/>

## AQL USING FILE SPEC
- Run `jf rt s --spec=find-artifacts-match-naming-pattern.json`

<br/>

## AQL USING CURL
- Run 
  ```textmate
  jf rt curl 
        -XPOST /api/search/aql 
        -H 'Content-Type: text/plain' 
        -d @find-artifacts-match-naming-pattern-curl.json
  ```

<br/>


### DOWNLOAD ARTIFACTS THAT HAS PROPERTY 
  - apply multiple options 

### DOWNLOAD ARTIFACTS THAT HAS PROPERTY
- apply multiple options

### COPY/MOVE ARTIFACTS THAT HAS PROPERTY
- apply multiple options



### PROMOTE ARTIFACTS THAT HAS PROPERTY  

### CLEAN OLD ARTIFACTS

### PROMOTION EXAMPLE 

### RELEASE DOMAIN EXAMPLE

### ENTRY EXAMPLE

### DEPENDENCY EXAMPLE

### STATISTIC EXAMPLE

### ARCHIVE EXAMPLE

### RELEASE ARTIFACT EXAMPLE

### 4-5 COMPLEX EXAMPLE 



### Item - Find all the artifacts with matching artifact name
- JSON file for AQL
  `{
  "items.find": {
  "name": {
  "$match": "*example*"
  }
  }
  }`
- Run `jf rt s --spec=find-artifacts-match-naming-pattern.json`

### Item - Find all the artifacts with matching artifact and repository name
- JSON file for AQL
  `{
  "files": [
  {
  "aql": {
  "items.find": {
  "$and": [
  { "name": { "$match": "frogsui*" } },
  { "repo": { "$match": "*prod*" }  }
  ]
  }
  }
  }]
  }`
- Run `jf rt s --spec=find-artifacts-match-naming-pattern-and-path.json`


### Builds - Find all Builds that have a dependency with a license that is not Apache
jf rt curl -XPOST /api/search/aql -H 'Content-Type: text/plain' -d 'builds.find({"name":{"$eq":"sup016-npm"}})'



## CHALLENGE - AQL [Optional]