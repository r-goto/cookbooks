#
# Cookbook:: bootstrap_a_node
# Recipe:: timezone_setup.rb
#
# Copyright:: 2021, The Authors, All Rights Reserved.

timezone "Set TZ to #{node['bootstrap_a_node']['timezone']}" do
  timezone "#{node['bootstrap_a_node']['timezone']}"
end
