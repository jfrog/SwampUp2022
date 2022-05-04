# LAB 5 - Xray 

## Prerequisites
- Lab-0 - Configure JFrog CLI
- Lab-1 - Repository Provisioning
- Lab-2 - Role-Based Access Control

## Create Xray Watch and Policy
- Run ``sh create_policy_watch.sh`` 
  - it will create a security policy called `prod-security-policy`
  - it will create a security policy called `dev-security-policy`
  - it will create a license policy called `gpl-blacklisting`
  - it will create a watch called `sup016-xray-watch`

## Scan Dependencies
- Run ``jf audit`` To see Vulnerabilities in table format. For JSON, `--format=json`
  - Pass ``--dep-type devOnly`` or ``--dep-type prodOnly`` to filter dependencies type. [Default: all]
  - Pass ``--licenses`` to fetch the list of licenses

- Run ``jf audit --watches "sup016-xray-watch"`` to see Security/License Violations


- Run ``jf audit --repo-path "sup016-npm-dev-local"`` to audit the project at the current directory using the policies defined for the `sup016-npm-dev-local` path in Artifactory.


## Scan Builds 
- Run ``jf bs sup016-npm 1.0.0`` 
  - We have configured policy with fail build so its showing us
  
    `[🚨Error] One or more of the violations found are set to fail builds that include them`
  

## Scan Docker Container on the Local File System
- Run ``docker images``
- Run ``jf docker scan {{select one of the image}}``