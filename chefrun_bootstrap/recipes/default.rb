#
# Cookbook:: chefrun_bootstrap
# Recipe:: default
#
# Copyright:: 2021, The Authors, All Rights Reserved.

include_recipe 'chefrun_bootstrap::timezone_setup'
include_recipe 'chefrun_bootstrap::client_setup'

# CCR Start/Failure will be notified on Slack. See https://supermarket.chef.io/cookbooks/slack_handler for detail.
include_recipe 'slack_handler::default'
