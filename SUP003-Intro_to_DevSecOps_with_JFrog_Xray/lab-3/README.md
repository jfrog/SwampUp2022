# Lab3 - Shift Left Security
- Prerequisites
- IDE Plugin
- Dependencies Scan
- On-Demand Binary Scan
- Docker Desktop JFrog Extension 
- Frogbot

## Prerequisites
- A SAAS Instance of JFrog. This will be provided as part of your enrollment to the Training class.
- Locally cloned Github [Project](https://github.com/jfrog/SwampUp2022/tree/main/SUP003-Intro_to_DevSecOps_with_JFrog_Xray/lab-3) where IDE is installed.
- Preferred IDE (Integrated Development Environment) like [Intellij](https://www.jetbrains.com/idea/download/#section=mac), [VSCode](https://code.visualstudio.com/download), [Eclipse](https://www.eclipse.org/downloads/)
- JFrog CLI is installed on your machine by running `jf -v`

<br/>

## IDE PLUGIN
- The cost of remediating a vulnerability is akin to the cost of fixing a bug. The earlier you remediate a vulnerability in the release cycle, the lower the cost.
- The IDE integration completes the CI/CD process, by bringing Xray's issue discovery one step earlier, to development time.

| IDE  | Supported Packages |
| ------------- | ------------- |
| [Visual Studio Code](https://marketplace.visualstudio.com/items?itemName=JFrog.jfrog-vscode-extension) | Maven, Pypi, npm, NuGet, Go |
| [Intellij](https://www.jfrog.com/confluence/display/JFROG/JFrog+IntelliJ+IDEA+Plugin) | Maven, Pypi, npm, Gradle, Go |
| [WebStorm](https://www.jfrog.com/confluence/display/JFROG/JFrog+IntelliJ+IDEA+Plugin) | npm | 
| [PyCharm](https://www.jfrog.com/confluence/display/JFROG/JFrog+IntelliJ+IDEA+Plugin) | Pypi |
| [GoLand](https://www.jfrog.com/confluence/display/JFROG/JFrog+IntelliJ+IDEA+Plugin) | Go |
| [Android Studio](https://www.jfrog.com/confluence/display/JFROG/JFrog+IntelliJ+IDEA+Plugin) | Gradle |
| [Visual Studio](https://www.jfrog.com/confluence/display/JFROG/JFrog+Visual+Studio+Extension) | NuGet |
| [Eclipse](https://www.jfrog.com/confluence/display/JFROG/JFrog+Eclipse+IDE+Plugin) | Maven, npm, Gradle |
| [Theia](https://open-vsx.org/extension/JFrog/jfrog-vscode-extension) | Maven, Pypi, npm, NuGet, Go |

### SETUP IDE PLUGIN
- Open one of the above IDE and install plugin/extension called `JFrog`.
- Configure plugin against the JFrog Platform by providing `JFrog Platform URL`, `Username`, `Password` or `Access Token`
- Open either `npm-vulnerable-example` or `maven-vulnerable-example` project from `project-examples` 
  - Run `npm install` or `mvn clean install` (NOTE: make sure your native client is pointing to Artifactory instance to download dependencies)
- Open `JFrog` tab and review list of vulnerabilities 

<br/>
<br/>
<br/>

## DEPENDENCIES SCAN
- With this feature, before a developer even checks-in the code they can scan using JFrog CLI for security or license violations saving valuable time to address these issues.
- Navigate to either `npm-vulnerable-example` or `maven-vulnerable-example` project from `project-examples`
- Run `jf rt npmc` or `jf rt mvnc`
- Run `jf audit` or `jf aud` (NOTE: we can also pass additional command like `--dep-type`, `--watches`, `--project`, `--repo-path`, etc)
  - Supported package types: Maven, Gradle, npm, Pip, Pipenv, Go, Nuget, .NET core CLI, Yarn2
- Run the scan command with the relevant command options. You can view scan results for the following:
  - Vulnerabilities, Violations, License
- List output into table format as DEFAULT `--format=json|table`
- More Information on [Dependencies Scan](https://www.jfrog.com/confluence/display/CLI/CLI+for+JFrog+Xray#CLIforJFrogXray-ScanningProjectDependencies)

<br/>
<br/>
<br/>

## ON-DEMAND BINARY SCAN
- Xray uses the JFrog CLI to provide **on-demand binary scanning** to address:
  - Run ad-hoc scans for security purposes **without uploading to Artficatory first**.
  - Adhere to organizational standards, whereas binaries and builds need to be **approved** first before uploading to Artifactory.
  - Not all binaries are stored in Artifactory, and as a user, you want to use Xray scanning capabilities.
- Navigate to either `npm-vulnerable-example` or `maven-vulnerable-example` project from `project-examples`
- Run `jf scan` or `jf s`
  - sample (maven or npm) files are located under `../../SUP016-Automate_everything_with_the_JFrog_CLI/lab-5/sample-data/` 
- For Docker, Run `jf docker scan` (NOTE: we can also pass additional command like `--watches`, `--project`, `--repo-path`, etc)
- For scan binary locally, Run `jf s "path/to/files/"` (NOTE: we can also pass additional command like `--watches`, `--project`, `--repo-path`, etc)
- More Information on [on-demand binary scan](https://www.jfrog.com/confluence/display/CLI/CLI+for+JFrog+Xray#CLIforJFrogXray-On-DemandBinaryScan)

<br/>
<br/>
<br/>

## DOCKER DESKTOP EXTENSION [Optional]
- Download Docker Desktop application
- Install [JFrog Extension](https://hub.docker.com/extensions/jfrog/jfrog-docker-desktop-extension) 
- Configure Extension pointing to your JFrog Platform instance
- Now we can scan any of the docker image that we have locally and see Xray scan results
- More Information on [Docker Desktop Extension for JFrog Xray](https://jfrog.com/solution-sheet/docker-desktop-extension-for-jfrog-xray/)

<br/>
<br/>
<br/>

## FROGBOT
- Frogbot is a Git (GitHub, GitLab, Bitbucket) bot that **scans your pull requests** and repositories for security vulnerabilities and adds the scan results as a comment on the pull request.
  - Supported Packages : Maven, Gradle, NPM, Pip, Pipenv, NuGet, Go, .Net, Yarn2
  - [Here](https://github.com/jfrog/frogbot/tree/master/templates/github-actions/scan-pull-request) are the sample templates for scan pull request in GitHub
- Frogbot can also **open a pull requests** for upgrading vulnerable dependencies to a version with a fix. 
  - Supported Packages : Maven, NPM, Pip, Pipenv, Go, Yarn2
  - [Here](https://github.com/jfrog/frogbot/tree/master/templates/github-actions/scan-and-fix) are the sample templates to open pull request based on scan for fix 
- Install [Frogbot](https://github.com/jfrog/frogbot#%EF%B8%8F-installing-and-using-frogbot) to your repositories
- Fork github project [npm-example-swampup](https://github.com/MaharshiPatel/npm-example-swampup) and clone on your machine
  - navigate to file `.github/workflows/frogbot-scan-pr.yml`
    - We need to add repository secrets in Github (#2 in [document](https://github.com/jfrog/frogbot#%EF%B8%8F-installing-and-using-frogbot))
      - `JF_URL` (line 41)
      - `JF_USER`  (line 45)
      - `JF_PASSWORD` (line 49)
      - `NY_GITHUB_TOKEN` (line 53)
    - Check the allow GitHub Actions to create and approve pull requests check box (#3 in [document](https://github.com/jfrog/frogbot#%EF%B8%8F-installing-and-using-frogbot))
    - Create a Github Environment called `frogbot` (#4 in [document](https://github.com/jfrog/frogbot#%EF%B8%8F-installing-and-using-frogbot))

<br/>
<br/>
<br/>

## CHALLENGE [Optional]
- Change the output format of scan result into `JSON` format
- Scan one of your local docker image without upload into Artifactory
- Create a workflow for Frogbot to **open a pull requests** for upgrading vulnerable dependencies to a version with a fix. 
  - **HINT**: - [Here](https://github.com/jfrog/frogbot/tree/master/templates/github-actions/scan-and-fix) are the sample templates to open pull request based on scan for fix 
