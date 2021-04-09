#
# Cookbook:: bootstrap_a_node-cookbook
# Recipe:: user_setup
#
# Copyright:: 2021, The Authors, All Rights Reserved.

user 'r-goto' do
  comment 'r-goto user'
  gid 'root'
  home '/home/r-goto'
  shell '/bin/bash'
  password 'password'
end
