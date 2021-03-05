#
# Cookbook:: chefrun_bootstrap
# Recipe:: client_setup.rb
#
# Copyright:: 2021, The Authors, All Rights Reserved.

###########
# Setup client.rb with Chef Server access credentials
###########

chef_client_config 'client.rb' do
  chef_server_url "https://#{node['chefrun_bootstrap']['chef_server']['fqdn']}/organizations/#{node['chefrun_bootstrap']['org_name']}"
  chef_license 'accept'
  log_location 'STDOUT'
  policy_name "#{node['chefrun_bootstrap']['policy_name']}"
  policy_group "#{node['chefrun_bootstrap']['policy_group']}"
  additional_config "validation_key \"/etc/chef/#{node['chefrun_bootstrap']['org_name']}-validator.pem\"\ntrusted_certs_dir \"/etc/chef/trusted_certs\""
end

cookbook_file "Place validator key for Org:#{node['chefrun_bootstrap']['org_name']}" do
  source "#{node['chefrun_bootstrap']['org_name']}-validator-key" # Watch out for the file name
  mode '0755'
  owner 'root'
  path "/etc/chef/#{node['chefrun_bootstrap']['org_name']}-validator.pem" # Watch out for the file name
end

ruby_block 'edit etc hosts' do
  block do
    rc = Chef::Util::FileEdit.new('/etc/hosts')
    rc.insert_line_if_no_match(/#{node['chefrun_bootstrap']['chef_server']['fqdn']}/, "#{node['chefrun_bootstrap']['chef_server']['ipaddress']} #{node['chefrun_bootstrap']['chef_server']['fqdn']}")
    rc.write_file
  end
end

directory '/etc/chef/trusted_certs' do
  mode '755'
end

cookbook_file 'Place SSL certificate to /etc/chef/trusted_certs' do
  source "#{node['chefrun_bootstrap']['chef_server']['fqdn']}.crt"
  mode '644'
  owner 'root'
  path "/etc/chef/trusted_certs/#{node['chefrun_bootstrap']['chef_server']['fqdn']}.crt"
end

###########
# Setup systemd timer to run chef-client periodically.
###########

chef_client_systemd_timer 'Run Chef Infra Client every x minutes' do
  interval "#{node['chefrun_bootstrap']['chef_client_systemd_timer']['interval']}"
  splay "#{node['chefrun_bootstrap']['chef_client_systemd_timer']['splay']}"
end

timezone 'Set TZ to Asia/Tokyo' do
  timezone 'Asia/Tokyo'
end

package 'chrony'
service 'Start/Enable Chrony' do
  action :start, :enable
end
