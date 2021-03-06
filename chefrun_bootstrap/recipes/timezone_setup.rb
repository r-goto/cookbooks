#
# Cookbook:: chefrun_bootstrap
# Recipe:: timezone_setup.rb
#
# Copyright:: 2021, The Authors, All Rights Reserved.

case node[:platform] 
when 'ubuntu' || 'debian'
  apt_update
when 'centos' || 'redhat'
  execute 'yum -y update'
end

timezone "Set TZ to #{node['chefrun_bootstrap']['timezone']}" do
  timezone "#{node['chefrun_bootstrap']['timezone']}"
end

package 'chrony'

service 'chronyd' do
  action :start
end
service 'chronyd' do
  action :enable
end
