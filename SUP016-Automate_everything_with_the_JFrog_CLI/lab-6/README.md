# LAB 5 - Xray 

## Prerequisites
- Lab-0 - Configure JFrog CLI
- Lab-1 - Repository Provisioning
- Lab-2 - Role-Based Access Control
- Lab-3 - Build Integration and Properties
- Lab 4 - Configure Replication
- Lab 5 - Artifactory Query Language


## INDEX BUILDS
- Run ``jf xr curl -XPOST /api/v1/binMgr/builds -H 'Content-Type: application/json' -d @index-builds.json``


## CREATE SECURITY POLICY
- Run ``jf xr curl -XPOST /api/v2/policies -H 'Content-Type: application/json' -d @prod-security-policy.json``
- Run ``jf xr curl -XPOST /api/v2/policies -H 'Content-Type: application/json' -d @dev-security-policy.json``
- Confirm Security Policy named with ``prod-security-policy`` and ``dev-security-policy`` are created


## CREATE LICENSE POLICY
- Run ``jf xr curl -XPOST /api/v2/policies -H 'Content-Type: application/json' -d @license-policy.json``
- Confirm License Policy named with ``gpl-blacklisting`` is created


## CREATE WATCH
- Run ``jf xr curl -XPOST /api/v2/watches -H 'Content-Type: application/json' -d @watch.json``
- Confirm Watch named with ``sup016-xray-watch`` is created


## SCAN DEPENDENCIES 
- Run ``jf audit`` To see Vulnerabilities in table format. For JSON, `--format=json`
  - Pass ``--dep-type devOnly`` or ``--dep-type prodOnly`` to filter dependencies type. [Default: all]
  - Pass ``--licenses`` to fetch the list of licenses

- Run ``jf audit --watches "sup016-xray-watch"`` to see Security/License Violations

- Run ``jf audit --repo-path "sup016-npm-dev-local"`` to audit the project at the current directory using the policies defined for the `sup016-npm-dev-local` path in Artifactory.


## SCAN BUILDS 
- Run ``jf bs sup016-npm 1.0.0`` 
  - We have configured policy with fail build so its showing us
  
    `[🚨 Error] One or more of the violations found are set to fail builds that include them`
  

## ON-DEMAND SCAN
### SCAN FILE ON LOCAL FILE SYSTEM
- Run ``jf s "/{{file_path}}/*.tgz" --watches "sup016-xray-watch"``
- View Scan in UI - Application > Security & Compliance > On-D

### SCAN DOCKER CONTAINER ON THE LOCAL FILE SYSTEM
- Run ``docker images``
- Run ``jf docker scan {{select one of the image}}``



## GENERATE VULNERABILITIES REPORT
### REPORT ON REPOSITORIES
- Run ``jf xr curl -XPOST /api/v1/reports/vulnerabilities -H 'Content-Type: application/json' -d @create-vuln-report-on-repositories.json``
  - we will get a response ``{"**report_id**":91,"status":"pending"}``

### REPORT ON BUILDS
- Run ``jf xr curl -XPOST /api/v1/reports/vulnerabilities -H 'Content-Type: application/json' -d @create-vuln-report-on-builds.json``
  - we will get a response ``{"**report_id**":92,"status":"pending"}``

### GET VULNERABILITIES REPORT CONTENT
- Get the ``{{**report_id**}}`` number from above and replace 
  - Run ``jf xr curl -XPOST '/api/v1/reports/vulnerabilities/{{**report_id**}}?direction=asc&page_num=1&num_of_rows=10&order_by=summary'``



## GENERATE LICENSE DUE DILIGENCE REPORT 
- Run ``jf xr curl -XPOST /api/v1/reports/licenses -H 'Content-Type: application/json' -d @create-license-report-on-repositories.json``

### GET VULNERABILITIES REPORT CONTENT
- Get the ``{{**report_id**}}`` number from above and replace
  - Run ``jf xr curl -XPOST '/api/v1/reports/licenses/97?direction=asc&page_num=1&num_of_rows=10&order_by=component'``


## GENERATE VIOLATIONS REPORT
- Run ``jf xr curl -XPOST /api/v1/reports/violations -H 'Content-Type: application/json' -d @create-violations-report-on-repositories.json``


## GENERATE SBOM REPORT IN SPDX OR CYCLONEDX
- Run ``jf xr curl -XPOST /api/v1/component/exportDetails -H 'Content-Type: application/json' -d @create-SBOM-spdx-report.json >> report.zip``
  - Run ``ls -la`` and unzip ``report.zip``
  - open `*.json` file
  ```json
  {
    "component_name": "",
    "package_type": "npm",
    "sha_256" : "98467fa038d58d65780938a2e2c73904302300b4e96d3209f2a6b397ec3889ec",
  
    # For SPDX report
    "spdx": true,
    "spdx_format": "json"     # json | tag:value | xlsx,
    
    # For CYCLONEDX report
    "cyclonedx": true,
    "cyclonedx_format": "json"      # json | xml
  }
  ```


### Challenge [Optional]
- Find Component by CVE       HINT: [searchByCves](https://www.jfrog.com/confluence/display/JFROG/Xray+REST+API#XrayRESTAPI-FindComponentbyCVE)
  - Log4J - [CVE-2021-44228](https://jfrog.com/blog/your-log4shell-remediation-cookbook-using-the-jfrog-platform/)
  - Spring4Shell - [CVE-2022-22965](https://jfrog.com/blog/springshell-zero-day-vulnerability-all-you-need-to-know/)
  - xmlhttprequest-ssl - CVE-2020-28502
- Generate `cyclonedx` SBOM report in `JSON` format



## Build Summary [need to fix]
Run ``jf xr curl -XGET '/summary/build?build_name=sup016-npm&build_number=2.0.0'``