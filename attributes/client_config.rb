###
# Override these attributes in the Policyfile.rb accordingly.
###

# Specify Chef Server FQDN & IP
default['bootstrap_a_node']['chef_server']['ipaddress'] = '198.18.246.201'
default['bootstrap_a_node']['chef_server']['fqdn'] = 'automate.cl'

# Specify Org name and its key file name
default['bootstrap_a_node']['org_name'] = 'first-org'
default['bootstrap_a_node']['org_validation_key_file'] = 'first-org-validator.pem'


# Specify Policy name & Policy group
default['bootstrap_a_node']['policy_name'] = 'web-server'
default['bootstrap_a_node']['policy_group'] = 'staging'

# Specify chef-client version
default['bootstrap_a_node']['chef_client']['version'] = '16'

# Specfy interval/splay for `chef-client` daemon
default['chef_client']['interval'] = 10
default['chef_client']['splay'] = 5
