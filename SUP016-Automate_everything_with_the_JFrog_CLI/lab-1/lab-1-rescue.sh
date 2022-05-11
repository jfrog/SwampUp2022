jf c use SUP016

sh create_local_repos.sh
sh create_remote_repos.sh
sh create_virtual_repos.sh


# switch to SUP016-edge config
jf c use SUP016-edge

# creating repos on edge nodes
sh create_local_repos_for_edge.sh
sh create_virtual_repos_for_edge.sh

# switch back to MAIN JPD
jf c use SUP016