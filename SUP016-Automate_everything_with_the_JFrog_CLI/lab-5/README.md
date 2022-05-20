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


#### CONSTRUCT SEARCH CRITERIA
```textmate 
{
    "<field>" : {
        "<comparison operator>" : "<value>"
    }
}
```

<br/>

## SEARCH FOR ARTIFACT MATCHING NAME PATTERN - AQL USING FILESPEC
- Run `jf rt s --spec=find-artifacts-match-naming-pattern-filespec.json`
  - Reference to [Filespec schema](https://www.jfrog.com/confluence/display/CLI/CLI+for+JFrog+Artifactory#CLIforJFrogArtifactory-FileSpecSchemas)

<br/>

## SEARCH FOR ARTIFACT MATCHING NAME PATTERN - AQL USING CURL
- Run 
  ```text
  jf rt curl -XPOST /api/search/aql -H 'Content-Type: text/plain' -d @find-artifacts-match-naming-pattern-curl.json
  ```

<br/>

### SEARCH
- ``jf rt search [COMMAND OPTION]`` or ``jf rt s [COMMAND OPTION]``

  | Command Option  | Description |
  | ------------- | ------------- |
  | --spec  |  Path to a file spec. For more details, please refer to Using File Specs. |
  | --props  |  A list of Artifactory properties specified as "key=value" pairs separated by a semi-colon (for example, "key1=value1;key2=value2;key3=value3"). Only artifacts with all of the specified properties names and values will be downloaded. |
  | --exclude-props  |  A list of Artifactory properties specified as "key=value" pairs separated by a semi-colon (for example, "key1=value1;key2=value2;key3=value3"). Only artifacts without all of the specified properties names and values will be downloaded |
  | --count  |  Set to true to display only the total of files or folders found. |
  | More  | [here](https://www.jfrog.com/confluence/display/CLI/CLI+for+JFrog+Artifactory#CLIforJFrogArtifactory-SearchingFiles) |

<br/>

### DOWNLOAD / UPLOAD / COPY / MOVE / DELETE
- For Download ``jf rt download [COMMAND OPTION]`` or ``jf rt dl [COMMAND OPTION]``
- For Upload ``jf rt upload [COMMAND OPTION]`` or ``jf rt u [COMMAND OPTION]``
- For Copy ``jf rt copy [COMMAND OPTION]`` or ``jf rt cp [COMMAND OPTION]``
- For Move ``jf rt move [COMMAND OPTION]`` or ``jf rt mv [COMMAND OPTION]``
- For Delete ``jf rt delete [COMMAND OPTION]`` or ``jf rt del [COMMAND OPTION]``

  NOTE: [DOWNLOAD](https://www.jfrog.com/confluence/display/CLI/CLI+for+JFrog+Artifactory#CLIforJFrogArtifactory-DownloadingFiles) / [UPLOAD](https://www.jfrog.com/confluence/display/CLI/CLI+for+JFrog+Artifactory#CLIforJFrogArtifactory-UploadingFiles) / [COPY](https://www.jfrog.com/confluence/display/CLI/CLI+for+JFrog+Artifactory#CLIforJFrogArtifactory-CopyingFiles) / [MOVE](https://www.jfrog.com/confluence/display/CLI/CLI+for+JFrog+Artifactory#CLIforJFrogArtifactory-MovingFiles) / [DELETE](https://www.jfrog.com/confluence/display/CLI/CLI+for+JFrog+Artifactory#CLIforJFrogArtifactory-DeletingFiles) has mostly similar command options.

  | Command Option  | Description |
  | ------------- | ------------- |
  | --spec  |  Path to a file spec. For more details, please refer to Using File Specs. |
  | --props  |  A list of Artifactory properties specified as "key=value" pairs separated by a semi-colon (for example, "key1=value1;key2=value2;key3=value3"). Only artifacts with all of the specified properties names and values will be downloaded. |
  | --exclude-props  |  A list of Artifactory properties specified as "key=value" pairs separated by a semi-colon (for example, "key1=value1;key2=value2;key3=value3"). Only artifacts without all of the specified properties names and values will be downloaded |
  | --threads  |  [Default: 3] The number of parallel threads that should be used to download where each thread downloads a single artifact at a time. |
  | --split-count  |  [Default: 3] The number of segments into which each file should be split for download (provided the artifact is over --min-split in size). To download each file in a single thread, set to 0. |
  | --min-split  |  [Default: 5120] The minimum size permitted for splitting. Files larger than the specified number will be split into equally sized --split-count segments. Any files smaller than the specified number will be downloaded in a single thread. If set to -1, files are not split. |
  | --retries  |  [Default: 3] Number of download retries. |
  | --retry-wait-time  |  [Default: 0s] Number of seconds or milliseconds to wait between retries. The numeric value should either end with s for seconds or ms for milliseconds. |
  | --sort-by  |  A list of semicolon-separated fields to sort by. The fields must be part of the 'items' AQL domain. For more information read the AQL documentation. |
  | --sort-order  |  The order by which fields in the 'sort-by' option should be sorted. Accepts 'asc' or 'desc'. |
  | --flat  |  [Default: false]  If true, artifacts are downloaded to the exact target path specified and their hierarchy in the source repository is ignored. |
  | More  | [here](https://www.jfrog.com/confluence/display/CLI/CLI+for+JFrog+Artifactory#CLIforJFrogArtifactory-DownloadingFiles) |


#### SEARCH FOR ARTIFACTS BELONGS TO A BUILD
- Run ``jf rt s --spec=find-artifacts-match-naming-pattern-filespec.json --build=sup016-maven``

#### DOWNLOAD ALL ARTIFACTS FROM REPOSITORY 
- Run ``jf rt dl --spec=new-download-all-files-from-repo.json``
  - Pass option to increase thread count to 10. `--threads=10`

#### DOWNLOAD ALL ARTIFACTS FROM REPOSITORY WITH MATCHING PROPERTY
- Using spec with pattern
  - Run ``jf rt dl --spec=new-download-all-files-from-repo-match-property.json``
- Using spec with aql
  - Run ``jf rt dl --spec=new-download-all-files-from-repo-match-property-aql.json``

#### DOWNLOAD ALL ARTIFACTS FROM REPOSITORY WITH MATCHING PROPERTY
- Run ``jf rt dl --spec=new-download-all-files-from-repo-for-build.json``
    - In spec file, if we pass `"build": "sup016-npm"` then it will download the artifact produce by latest build

### COPY/MOVE ARTIFACTS THAT HAS PROPERTY
- Run ``jf rt cp --spec=new-copy-all-files-from-repo-match-property-aql.json``

### FIND ARTIFACTS WHICH ARE LARGER THAN 100MB
- Run ``jf rt s --spec=new-find-artifacts-larger-then-100MB.json``

### FIND ARTIFACTS WHICH ARE IN PROD REPOSITORY AND HAS 1 DOWNLOAD
- Run ``jf rt s --spec=new-find-artifacts-has-1-downloads.json``

### FIND ARTIFACTS WHICH ARE IN PROD REPOSITORY BUT HAS 0 DOWNLOAD IN LAST 1 YEAR
- Run ``jf rt s --spec=new-find-artifacts-has-0-downloads-year.json``

### PROMOTE ARTIFACTS THAT HAS PROPERTY  


### CLEAN UP ARTIFACTS
- Run for search `` jf rt s --spec=new-find-artifacts-has-0-downloads.json``
- Run for delete ``jf rt del --spec=new-find-artifacts-has-0-downloads.json --dry-run``

### PROMOTION EXAMPLE 

### RELEASE DOMAIN EXAMPLE
- Run ``jf rt curl -XPOST /api/search/aql -H 'Content-Type: text/plain' -d @new-release-domain-example.json``

### DEPENDENCY EXAMPLE
- Run ``jf rt curl -XPOST /api/search/aql -H 'Content-Type: text/plain' -d @new-dependency-example.json``

### RELEASE ARTIFACT EXAMPLE [Optional]
- Run ``jf rt curl -XPOST /api/search/aql -H 'Content-Type: text/plain' -d @new-release-artifact-example.json``

### FIND ARTIFACTS WITH GPL LICENSE
- Run ``jf rt curl -XPOST /api/search/aql -H 'Content-Type: text/plain' -d @new-find-artifact-with-GPL-license.json``

### FIND ARTIFACTS WITH DEPTH FILTER like level
- Run ``jf rt s --spec=new-find-artifacts-with-depth-filter.json``

### FIND ARTIFACTS USING MULTIPLE FIELDS LIKE REPOSITORY WITH CERTAIN PROPERTY, BUILD
- Run ``jf rt curl -XPOST /api/search/aql -H 'Content-Type: text/plain' -d @new-find-artifacts-from-repo-build-matching-prop.json``

### FIND ALL THE BUILDS WITH NAME
- Run ``jf rt curl -XPOST /api/search/aql -H 'Content-Type: text/plain' -d @new-find-builds-matching-name.json``
- Run ``jf rt curl -XPOST /api/search/aql -H 'Content-Type: text/plain' -d @new-find-builds-matching-name-most-recent-limit5.json``


## CHALLENGE - AQL [Optional]
- 