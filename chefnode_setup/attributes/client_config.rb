# Specify Chef Server FQDN & IP
default['chefnode_setup']['chef_server']['ipaddress'] = '198.18.246.201'
default['chefnode_setup']['chef_server']['fqdn'] = 'automate.cl'

# Specify Org name
default['chefnode_setup']['org_name'] = 'first-org'

# Specify Policy name & Policy group
default['chefnode_setup']['policy_name'] = 'web-server'
default['chefnode_setup']['policy_group'] = 'staging'

# Specify chef-client systemd timer duration
default['chefnode_setup']['chef_client_systemd_timer']['interval'] = '5m'
default['chefnode_setup']['chef_client_systemd_timer']['splay'] = '3m'
