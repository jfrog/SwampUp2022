# LAB 5 - Xray 

## Prerequisites
- Lab-0 - Configure JFrog CLI
- Lab-1 - Repository Provisioning
- Lab-2 - Role-Based Access Control


# Index builds
- Run ``jf xr curl -XPOST /api/v1/binMgr/builds -H 'Content-Type: application/json' -d @index-builds.json``


# Create Security Policy
- Run ``jf xr curl -XPOST /api/v2/policies -H 'Content-Type: application/json' -d @prod-security-policy.json``
- Run ``jf xr curl -XPOST /api/v2/policies -H 'Content-Type: application/json' -d @dev-security-policy.json``
- Confirm Security Policy named with ``prod-security-policy`` and ``dev-security-policy`` are created


# Create License Policy
- Run ``jf xr curl -XPOST /api/v2/policies -H 'Content-Type: application/json' -d @license-policy.json``
- Confirm License Policy named with ``gpl-blacklisting`` is created


# Create a Watch
- Run ``jf xr curl -XPOST /api/v2/watches -H 'Content-Type: application/json' -d @watch.json``
- Confirm Watch named with ``sup016-xray-watch`` is created


## Scan Dependencies
- Run ``jf audit`` To see Vulnerabilities in table format. For JSON, `--format=json`
  - Pass ``--dep-type devOnly`` or ``--dep-type prodOnly`` to filter dependencies type. [Default: all]
  - Pass ``--licenses`` to fetch the list of licenses

- Run ``jf audit --watches "sup016-xray-watch"`` to see Security/License Violations

- Run ``jf audit --repo-path "sup016-npm-dev-local"`` to audit the project at the current directory using the policies defined for the `sup016-npm-dev-local` path in Artifactory.


## Scan Builds 
- Run ``jf bs sup016-npm 1.0.0`` 
  - We have configured policy with fail build so its showing us
  
    `[🚨 Error] One or more of the violations found are set to fail builds that include them`
  

## Scan Docker Container on the Local File System
- Run ``docker images``
- Run ``jf docker scan {{select one of the image}}``



## Generate Vulnerabilities Report
### Report on Repositories
- Run ``jf xr curl -XPOST /api/v1/reports/vulnerabilities -H 'Content-Type: application/json' -d @create-vuln-report-on-repositories.json``
  - we will get a response ``{"**report_id**":91,"status":"pending"}``

### Report on Builds
- Run ``jf xr curl -XPOST /api/v1/reports/vulnerabilities -H 'Content-Type: application/json' -d @create-vuln-report-on-builds.json``
  - we will get a response ``{"**report_id**":92,"status":"pending"}``

### Get Vulnerabilities Report Content
- Get the ``{{**report_id**}}`` number from above and replace 
  - Run ``jf xr curl -XPOST '/api/v1/reports/vulnerabilities/{{**report_id**}}?direction=asc&page_num=1&num_of_rows=10&order_by=summary'``



## Generate License Due Diligence Report
- Run ``jf xr curl -XPOST /api/v1/reports/licenses -H 'Content-Type: application/json' -d @create-license-report-on-repositories.json``

### Get Vulnerabilities Report Content
- Get the ``{{**report_id**}}`` number from above and replace
  - Run ``jf xr curl -XPOST '/api/v1/reports/licenses/97?direction=asc&page_num=1&num_of_rows=10&order_by=component'``


## Generate Violations Report
- Run ``jf xr curl -XPOST /api/v1/reports/violations -H 'Content-Type: application/json' -d @create-violations-report-on-repositories.json``



## Build Summary [need to fix]
Run ``jf xr curl -XGET '/summary/build?build_name=sup016-npm&build_number=2.0.0'``