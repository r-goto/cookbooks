#
# Cookbook:: chefnode_setup
# Recipe:: default
#
# Copyright:: 2021, The Authors, All Rights Reserved.

include_recipe 'chefnode_setup::timezone_setup'
include_recipe 'chefnode_setup::client_setup'

# CCR Start/Failure will be notified on Slack. See https://supermarket.chef.io/cookbooks/slack_handler for detail.
include_recipe 'slack_handler::default'
# ruby_block 'fail the run' do
#   block do
#     raise 'deliberately fail the run'
#   end
# end