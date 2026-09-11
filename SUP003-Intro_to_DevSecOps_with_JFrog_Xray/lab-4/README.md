# Lab4 - Reporting

## Prerequisites

- A SAAS Instance of JFrog Platform. This will be provided as part of your enrollment to the Training class.
- JFrog CLI is installed on your machine by running `jf -v`

## GENERATE VIOLATIONS REPORT

### using UI

- Navigate to the **Application** > **Security & Compliance** > **Reports**
- Enter `violations report for repositories` from **Name**
- Select `Violations` from  **Report Type**
- Select `Repositories` from **Scope**
- Click on `Select Repositories`
- Select &#10004; that is next to Name and Click on a button `>>` to move them to the right
- Click **Save**
  - Review all the options under **Advanced Filters**

### using API

- Run ``jf xr curl -XPOST /api/v1/reports/violations -H 'Content-Type: application/json' -d @create-violations-report-on-repositories.json``

## GENERATE SBOM REPORT IN SPDX OR CYCLONEDX

> Only at artifact and build info level

### using UI

- Navigate to the **Application** > **Artifactory** > **Artifacts**
- Select a **local** or **remote-cache** repsository
- Select an artifact (for a **docker image**, select the **manifest.json**)
- Select **Xray tab** and click on the **Actions** button

### using API

- Update the SHA256 value in ``create-SBOM-spdx-report.json``
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
