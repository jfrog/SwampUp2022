# Create Users
jf rt users-create --csv users.csv

# Create Groups
jf rt group-create developers
jf rt group-create ops
jf rt group-create secops

# Add users to the groups
jf rt group-add-users developers "mike,jennifer"
jf rt group-add-users ops "bob,jennifer,rolando,support"
jf rt group-add-users secops "irene,matt,jennifer"

# Create Permission Target
jf rt permission-target-create dev-permission-target-template.json
jf rt permission-target-create prod-permission-target-template.json