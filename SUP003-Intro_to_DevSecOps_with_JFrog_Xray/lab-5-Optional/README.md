# Lab5 - Advanced Automation in Xray 

## CONFIGURE SETTINGS
#### CONFIGURE WORKERS COUNT FOR XRAY PROCESSES (ONLY for SELF-HOSTED)
- GET current config for workers count for each XRAY microservice
  - Run `jf xr curl -XGET api/v1/configuration/workersCount -H 'Content-Type: application/json'`
- Update current config for workers count for each XRAY microservice
  - Run `jf xr curl -XPUT api/v1/configuration/workersCount -H 'Content-Type: application/json' -d @update-worker-count.json`

<br />

#### UPDATE DAILY DB SYNC TIME
- Get DB sync Daily time
  - Run `jf xr curl -XGET api/v1/configuration/dbsync/time -H 'Content-Type: application/json'`
- Update DB sync Daily time
  - Run `jf xr curl -XPUT api/v1/configuration/dbsync/time -H 'Content-Type: application/json' -d @update-db-sync-time.json`

<br />
<br />
<br />

## SUMMARY
- Starting from Xray version 3.42.3, JFrog Security CVE Research and Enrichment data is supported. Important notes:
  - The following fields are markdown texts:
    - short_description
    - full_description
    - remediation
#### ARTIFACT
- Provides the details about any **artifact** specified by path identifiers or checksum.
  - Run `jf xr curl -XGET api/v1/summary/artifact -H 'Content-Type: application/json' -d @summary-for-artifact.json`

<br />

#### BUILD
- Provides the details about any **build** specified by build identifier (name + number)
  - Run `jf xr curl -XGET api/v1/summary/build?build_name=swampup22_s003_mvn_pipeline&build_number=1.0.0 -H 'Content-Type: application/json'`
  
<br />
<br />
<br />

## SCAN LIST
#### GET REPOSITORIES
- Get a list of repositories that contain at least one scanned artifact
  - Run `jf xr curl -XGET 'api/v1/repos?order_by=repo&direction=asc&number_of_rows=10'`
    - [More Information](https://www.jfrog.com/confluence/display/JFROG/Xray+REST+API#XrayRESTAPI-ScansList-GetRepositories)
#### GET BUILDS
- Get a list of builds scanned by Xray
  - Run `jf xr curl -XGET 'api/v1/builds?order_by=updated_at&direction=asc&number_of_rows=10'`
    - [More Information](https://www.jfrog.com/confluence/display/JFROG/Xray+REST+API#XrayRESTAPI-ScansList-GetBuilds)
#### GET BUILD VERSION
- Get a list of build versions scanned by Xray
  - Run `jf xr curl -XGET 'api/v1/builds/{buildName}/versions?order_by=version&direction=asc&number_of_rows=10'`
    - [More Information](https://www.jfrog.com/confluence/display/JFROG/Xray+REST+API#XrayRESTAPI-ScansList-GetBuildVersions)
#### GET ARTIFACTS
- Get a list of artifacts for a specific repository
  - Run `jf xr curl -XGET 'api/v1/artifacts?order_by=created&direction=asc&number_of_rows=10'`
    - [More Information](https://www.jfrog.com/confluence/display/JFROG/Xray+REST+API#XrayRESTAPI-ScansList-GetArtifacts)

<br />
<br />
<br />

## COMPONENTS 
#### GET COMPONENT LIST PER WATCH
- Gets a list of components associated with a specific watch
  - Run `jf xr curl -XGET 'api/v2/component/data/{watch_name}?limit=(?)&offset=(?)&from=(?)&to=(?)'`
    - `watch_name` - prod-watch
    - optional - `limit=(?)&offset=(?)&from=(?)&to=(?)`

<br />

#### GET COMPLETE DEPENDENCY GRAPH FOR A BUILD
- Get the complete dependency graph for a build
  - Run `jf xr curl -XPOST api/v1/dependencyGraph/build -H 'Content-Type: application/json' -d @depndency-graph-of-build.json`

<br />
<br />
<br />

## VIOLATIONS
#### LIST VIOLATIONS
- Gets the Xray violations based on a set of search criteria
  - Run `jf xr curl -XPOST api/v1/violations -H 'Content-Type: application/json' -d @get-violations-based-on-criteria.json`

<br />
<br />
<br />

## METRICS (ONLY for SELF-HOSTED)
- Get system metrics data
  -Run `jf xr curl -XGET 'api/v1/metrics'`

<br />
<br />
<br />

## JFROG CLI SECURITY PLUGINS
- JFrog CLI Plugins allow enhancing the functionality of JFrog CLI to meet the specific user and organization needs.
- Available [Security Plugins](https://github.com/jfrog/jfrog-cli-plugins-reg#security-plugins)

<br />
<br />
<br />

## CHALLENGE
- Scan List of Release Bundles and Release Bundle Versions
- Scan List of Packages and Package Versions

