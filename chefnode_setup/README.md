# chefnode_setup Cookbooks

 Having issues with `knife bootstrap`? Why don't you start using `chef-run` to bootstrap your nodes.  		
 This cookbook provides easy and simple way of registering your nodes to Chef Server.

##### What it does is simply. Setup Chef Infra Client onto the target nodes and which be added to specified org and policy name/group. 
##### chef-client.service timer will be set with a specified internal. (default 5m with 3m splay)

# Usage		

  ```chef-run [NODE_IP] chefnode_setup``` 	

  * Prerequisites: ssh connection to the node. Available options: `--password PASSWORD` `-identity-file PATH/TO/FILE`
		
# Attributes		
		
 ```		
 # Specify Chef Server FQDN & IP		
 default['chefnode_setup']['chef_server']['ipaddress'] = '198.18.246.201'		
 default['chefnode_setup']['chef_server']['fqdn'] = 'automate.cl'		

  # Specify Org name		
 default['chefnode_setup']['org_name'] = 'first-service'		

  # Specify Policy name & Policy group		
 default['chefnode_setup']['policy_name'] = 'web-server'		
 default['chefnode_setup']['policy_group'] = 'staging'		

  # Specify chef-client systemd timer duration		
 default['chefnode_setup']['chef_client_systemd_timer']['interval'] = '5m'		
 default['chefnode_setup']['chef_client_systemd_timer']['splay'] = '3m'		
 ```