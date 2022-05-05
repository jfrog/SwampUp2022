# Create Users
jf rt users-create --csv users.csv

# Create Groups and add users to groups
jf rt group-create developers
jf rt group-create ops
jf rt group-create secops

jf rt group-add-users developers "mike,jennifer"
jf rt group-add-users ops "bob,jennifer,rolando,support"
jf rt group-add-users ops "irene,matt,jennifer"