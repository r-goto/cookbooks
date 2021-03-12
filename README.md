# `bootstrap_a_node` Cookbook

 Having issues with `knife bootstrap`? Why don't you start using [`chef-run`](https://docs.chef.io/workstation/chef_run/) to bootstrap your nodes.  		
 This cookbook provides easy and simple way of registering your nodes to Chef Infra server.

##### What it does is simply. Setup Chef Infra Client onto the target nodes and which be added to specified org and policy name/group. 
##### chef-client.service will be set with a specified internal. (default 10s with 0s splay) Adjust the interval in your policyfile to suit your own need. 

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
###
# Override these attributes in the Policyfile.rb accordingly.
###
# Specify Policy name & Policy group
default['bootstrap_a_node']['policy_name'] = 'web-server'
default['bootstrap_a_node']['policy_group'] = 'staging'
# Specify chef-client attributes
default['bootstrap_a_node']['chef_client']['version'] = '16'
default['chef_client_updater']['post_action'] = 'kill'
default['chef_client']['interval'] = 600
default['chef_client']['splay'] = 120


## Customizations for Slack WebHook config
## See https://api.slack.com/incoming-webhooks#customizations_for_custom_integrations
# Add `webhook1` URL
# default['chef_client']['handler']['slack']['webhooks']['name'].push('webhook1')
default['chef_client']['handler']['slack']['webhooks']['webhook1']['url'] = 'https://hooks.slack.com/services/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'
# The username of the Slack message, defaults to Slack WebHook config (i.e. nil)
default['chef_client']['handler']['slack']['username'] = 'CCR Notifications'
# Icon URL, defaults to Slack WebHook config (i.e. nil)
default['chef_client']['handler']['slack']['icon_url'] = 'https://avatars1.githubusercontent.com/u/29740'
# Emoji for the Slack call, defaults to Slack WebHook config (i.e. nil)
default['chef_client']['handler']['slack']['icon_emoji'] = ':fork_and_knife:'
# Only report when runs fail as opposed to every single occurrence, defaults to false
default['chef_client']['handler']['slack']['fail_only'] = true
# Send a message when the run starts, defaults to false
default['chef_client']['handler']['slack']['send_start_message'] = false
# The level of detail in the message. Valid options are 'basic', 'elapsed' and 'resources', defaults to 'basic'
default['chef_client']['handler']['slack']['message_detail_level'] = 'elapsed'
# The level of detail about the cookbook used in the message. Valid options are 'off' and 'all', defaults to 'off'
default['chef_client']['handler']['slack']['cookbook_detail_level'] = 'off'
# Send the organization from /etc/chef/client.rb, defaults to false
default['chef_client']['handler']['slack']['send_organization'] = true

# Specify node Time Zone
default['bootstrap_a_node']['timezone'] = 'Asia/Tokyo'		
 ```

# In case of failure...

`chef-run` is very poor in error loggging, No worries. [`slack_handler`](https://supermarket.chef.io/cookbooks/slack_handler) cookbook is embedded and it will tell you in case the initial chef-cliet run fails for some reasons. Once the initial CCR completes successfully, the rest will be taken care of by your Chef Automate!