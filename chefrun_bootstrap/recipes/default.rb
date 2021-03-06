#
# Cookbook:: chefrun_bootstrap
# Recipe:: default
#
# Copyright:: 2021, The Authors, All Rights Reserved.

include_recipe 'chefrun_bootstrap::timezone_setup'
include_recipe 'chefrun_bootstrap::client_setup'
