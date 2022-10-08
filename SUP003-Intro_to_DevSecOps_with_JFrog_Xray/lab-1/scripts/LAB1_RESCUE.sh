jf c use s003

# Create all the repositories
sh create_repo_rescue.sh

# Index Resources - repositories and builds
jf xr curl -XPUT /api/v1/binMgr/1/repos -H "Content-Type: application/json" -d @index-repos.json
jf xr curl -XPUT /api/v1/binMgr/1/builds -H "Content-Type: application/json" -d @index-builds.json

# Create Policies
jf xr curl -XPOST /api/v2/policies -H 'Content-Type: application/json' -d @prod-sec-policy.json
jf xr curl -XPOST /api/v2/policies -H 'Content-Type: application/json' -d @prod-lic-policy.json
jf xr curl -XPOST /api/v2/policies -H 'Content-Type: application/json' -d @operational-risk-policy.json
