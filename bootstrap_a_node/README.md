# `bootstrap_a_node` Cookbook

 Having issues with `knife bootstrap`? Why don't you start using [`chef-run`](https://docs.chef.io/workstation/chef_run/) to bootstrap your nodes.  		
 This cookbook provides easy and simple way of registering your nodes to Chef Infra server.

##### What it does is simply. Setup Chef Infra Client onto the target nodes and which be added to specified org and policy name/group. 
##### chef-client.service timer will be set with a specified internal. (default 5m with 3m splay)

# Usage/steps
1. Download or git clone the cookbook.
2. Modify attributes to suit your own need of Chef Infra server and Org
3. Run `chef-run` 		

  ```
  chef-run [NODE_IP] bootstrap_a_node
  ``` 	

  *Prerequisites: ssh connection to the node. Available options: `--password PASSWORD` `-identity-file PATH/TO/FILE`

4. Once `chef-run` completes. The node will show up on your Chef Automate with specified policy group and your're good to go.  

##### Lastly please remember to keep this `bootstrap_a_node` cookbook in the runlist of your Policy group as it will keep eyes on your nodes and perform any fix if unwanted changes that may make nodes unable to sync with Chef Infra server. 
		
# Attributes		
		
 ```		
 # Specify Chef Infra server FQDN & IP		
 default['bootstrap_a_node']['chef_server']['ipaddress'] = '198.18.246.201'		
 default['bootstrap_a_node']['chef_server']['fqdn'] = 'automate.cl'		

  # Specify Org name		
 default['bootstrap_a_node']['org_name'] = 'first-service'		

  # Specify Policy name & Policy group		
 default['bootstrap_a_node']['policy_name'] = 'web-server'		
 default['bootstrap_a_node']['policy_group'] = 'staging'		
 ```

# In case of failure...

`chef-run` is very poor in error loggging, No worries. [`slack_handler`](https://supermarket.chef.io/cookbooks/slack_handler) cookbook is embedded and it will tell you in case the initial chef-cliet run fails for some reasons. Once the initial CCR completes successfully, the rest will be taken care of by your Chef Automate!