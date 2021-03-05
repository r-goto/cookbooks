# Specify Chef Server FQDN & IP
default['chefrun_bootstrap']['chef_server']['ipaddress'] = '198.18.246.201'
default['chefrun_bootstrap']['chef_server']['fqdn'] = 'automate.cl'

# Specify Org name
default['chefrun_bootstrap']['org_name'] = 'first-org'

# Specify Policy name & Policy group
default['chefrun_bootstrap']['policy_name'] = 'web-server'
default['chefrun_bootstrap']['policy_group'] = 'staging'

# Specify chef-client systemd timer duration
default['chefrun_bootstrap']['chef_client_systemd_timer']['interval'] = '5m'
default['chefrun_bootstrap']['chef_client_systemd_timer']['splay'] = '3m'
