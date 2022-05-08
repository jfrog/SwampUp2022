# Index builds
jf xr curl -XPOST /api/v1/binMgr/builds -H 'Content-Type: application/json' -d @index-builds.json

# Create Security Policy
jf xr curl -XPOST /api/v2/policies -H 'Content-Type: application/json' -d @prod-security-policy.json
jf xr curl -XPOST /api/v2/policies -H 'Content-Type: application/json' -d @dev-security-policy.json

# Create License Policy
jf xr curl -XPOST /api/v2/policies -H 'Content-Type: application/json' -d @license-policy.json

# Create a Watch
jf xr curl -XPOST /api/v2/watches -H 'Content-Type: application/json' -H 'Consumes: application/json' -H 'Produces: application/json' -d @watch.json
