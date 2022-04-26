# LAB 1

### Prerequisites
- Lab-0 - Configure JFrog CLI 

### Create Repository Template
- Local
  - run ``jf rt repo-template template-local.json``
    - Select the template type (press Tab for options): `create`
    - Insert the repository key > `sup016{{initial}}-npm-dev-local`
    - Select the repository class (press Tab for options): `local`
    - Select the repository's package type (press Tab for options): `npm`
    - You can type ":x" at any time to save and exit.
    - Select the next configuration key (press Tab for options): `repoLayoutRef`
    - Insert the value for repoLayoutRef (press Tab for options): > `npm-default`
    - Select the next configuration key (press Tab for options): `xrayIndex`
    - Insert the value for xrayIndex (press Tab for options): > `true`
    - Select the next configuration key (press Tab for options): `:x`
    - Validate template `template-local.json` is created successfully. - ``ls -la``
    - View template
      ```json
      {
        "key":"${repo-name}",
        "packageType":"${package-type}",
        "rclass":"${repo-type}",
        "repoLayoutRef":"${repo-layout}",
        "xrayIndex":"${xray-enable}"
      }
      ```
- Remote
  - run ``jf rt repo-template template-remote.json``
      - Select the template type (press Tab for options): `create`
      - Insert the repository key > `npm-remote`
      - Select the repository class (press Tab for options): `remote`
      - Insert the remote repository URL > `https://registry.npmjs.org`
      - Select the repository's package type (press Tab for options): `npm`
      - You can type ":x" at any time to save and exit. 
      - Select the next configuration key (press Tab for options): `repoLayoutRef`
      - Insert the value for repoLayoutRef (press Tab for options): > `npm-default`
      - Select the next configuration key (press Tab for options): `xrayIndex`
      - Insert the value for xrayIndex (press Tab for options): > `true`
      - Select the next configuration key (press Tab for options): `:x`
      - Validate template `template-remote.json` is created successfully. ``ls -la``
      - View template
        ```json
        {
          "key":"${repo-name}",
          "packageType":"${package-type}",
          "rclass":"${repo-type}",
          "url":"${url}",
          "repoLayoutRef":"${repo-layout}",
          "xrayIndex":"${xray-enable}"
        }
        ```
- Virtual
    TO-DO
