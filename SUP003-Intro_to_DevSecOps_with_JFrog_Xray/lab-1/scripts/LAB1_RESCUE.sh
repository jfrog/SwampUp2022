# Create all the repositories
sh create_repo_rescue.sh

# Create Policies
jf xr curl -XPOST /api/v2/policies -H 'Content-Type: application/json' -d @/scripts/prod-sec-policy.json
jf xr curl -XPOST /api/v2/policies -H 'Content-Type: application/json' -d @/scripts/prod-lic-policy.json
jf xr curl -XPOST /api/v2/policies -H 'Content-Type: application/json' -d @/scripts/operational-risk-policy.json
