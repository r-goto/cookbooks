###
# Override these attributes in the Policyfile.rb accordingly.
###

# Specify Chef Server FQDN & IP
default['bootstrap_a_node']['chef_server']['ipaddress'] = '198.18.246.201'
default['bootstrap_a_node']['chef_server']['fqdn'] = 'automate.cl'

# Specify Org name
default['bootstrap_a_node']['org_name'] = 'first-org'

# Specify Policy name & Policy group
default['bootstrap_a_node']['policy_name'] = 'web-server'
default['bootstrap_a_node']['policy_group'] = 'staging'

# Specify chef-client version
default['bootstrap_a_node']['chef_client']['version'] = '16'
