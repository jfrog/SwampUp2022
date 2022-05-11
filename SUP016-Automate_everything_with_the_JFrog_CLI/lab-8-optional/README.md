# LAB 8 - JFROG CLI Plugin

- [JFrog CLI Plugin Registry](https://github.com/jfrog/jfrog-cli-plugins-reg)
- [JFrog CLI Plugins Developer Guide](https://github.com/jfrog/jfrog-cli/blob/v2/guides/jfrog-cli-plugins-developer-guide.md#JFrog-CLI-Plugin-Developer-Guide)

### [LIVE LOGS](https://github.com/jfrog/live-logs#readme)
The JFrog Platform includes an integrated Live Logs plugin, which allows customers to get the JFrog product logs (Artifactory, Xray, Mission Control, Distribution, and Pipelines) using the JFrog CLI Plugin. The plugin also provides the ability to `cat` and `tail -f` any log on any product node.

- Run ``jf plugin install live-logs``

- Run ``jf live-logs config rt SUP016``

- Run ``jf live-logs logs -i``
  - Select JFrog CLI product id
    - `rt`
  - Select JFrog CLI server id
    - `SUP016`
  - Select Node Id
    - `{{NODE0}}`
    - `{{NODE1}}`
  - Select log name
    - `{{SELECT LOG FILE FOR TAIL}}`

- Run ``jfrog live-logs logs rt SUP016 {{NODE}}-0 {{SELECT LOG FILE FOR TAIL}}.log``


### [scan-log4j-versions](https://github.com/jfrog/log4j-tools/tree/main/scan_log4j_versions/jfrog_cli_plugin#readme)
This plugin recursively scans the root_folder for .jar and .war files; For every file that is detected, the plugin looks for a *log4j/core/net/JndiManager.class and *log4j/core/lookup/JndiLookup.class (recursively in each .jar file). If at least one of the classes is found, the tool attempts to fingerprint its version (including some variations found in patches and backport patches) in order to report whether the code is vulnerable.

```json
- Arguments:
  - root-folder - Directory to start the recursive scan from
- Flags:
  exclude: do not scan the specified directories
```

- Run ``jf plugin install scan-log4j-versions``

- Run ``jf scan-log4j-versions run maven-example``