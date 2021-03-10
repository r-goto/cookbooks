#
# Cookbook:: bootstrap_a_node
# Recipe:: client_setup.rb
#
# Copyright:: 2021, The Authors, All Rights Reserved.

###########
# Setup client.rb with Chef Server access credentials
###########

chef_client_config 'client.rb' do
  chef_server_url "https://#{node['bootstrap_a_node']['chef_server']['fqdn']}/organizations/#{node['bootstrap_a_node']['org_name']}"
  chef_license 'accept'
  log_location 'STDOUT'
  policy_name "#{node['bootstrap_a_node']['policy_name']}"
  policy_group "#{node['bootstrap_a_node']['policy_group']}"
  additional_config "validation_key \"/etc/chef/#{node['bootstrap_a_node']['org_name']}-validator.pem\"\ntrusted_certs_dir \"/etc/chef/trusted_certs\""
end

directory '/etc/chef/trusted_certs' do
  mode '755'
end

cookbook_file 'Place SSL certificate to /etc/chef/trusted_certs' do
  source "#{node['bootstrap_a_node']['chef_server']['fqdn']}.crt"
  mode '644'
  owner 'root'
  path "/etc/chef/trusted_certs/#{node['bootstrap_a_node']['chef_server']['fqdn']}.crt"
end

###########
# Create client.pem and delete org-validator after first CCR
###########

ruby_block 'edit etc hosts' do
  block do
    rc = Chef::Util::FileEdit.new('/etc/hosts')
    rc.insert_line_if_no_match(/#{node['bootstrap_a_node']['chef_server']['fqdn']}/, "#{node['bootstrap_a_node']['chef_server']['ipaddress']} #{node['bootstrap_a_node']['chef_server']['fqdn']}")
    rc.write_file
  end
end

cookbook_file "Place validator key for Org:#{node['bootstrap_a_node']['org_name']}" do
  not_if { ::File.exist?('/etc/chef/client.pem') }
  source "#{node['bootstrap_a_node']['org_name']}-validator-key" # Watch out for the file name
  mode '0755'
  owner 'root'
  path "/etc/chef/#{node['bootstrap_a_node']['org_name']}-validator.pem" # Watch out for the file name
end

file 'Delete org validator key' do
  only_if { ::File.exist?('/etc/chef/client.pem') }
  path "/etc/chef/#{node['bootstrap_a_node']['org_name']}-validator.pem"
  action :delete
end

###########
# Control chef-client version with `chef_client_updater` cookbook 'https://github.com/chef-cookbooks/chef_client_updater'
###########

chef_client_updater "up or down grade Chef Infra version to #{node['bootstrap_a_node']['chef_client']['version']}" do
  version "#{node['bootstrap_a_node']['chef_client']['version']}"
end

###########
# Run the initial Chef Client check-in to generate `client.pem`. If `client.pem` already exists, no CCR wil be executed.
###########

ruby_block 'Run chef-client' do
  action :nothing
  block do
    system '/usr/bin/chef-client'
  end
end

###########
# Notify if `chef-client` fails to generate '/etc/chefclient.pem'.
###########

ruby_block 'Checking if initial CCR succesfully completed...' do
  not_if { ::File.exist?('/etc/chef/client.pem') }
  notifies :run, 'ruby_block[Run chef-client]', :before
  block do
    raise 'clinet.pem not found. Perhaps the initial CCR check-in failed or client.pem vanished. Check the node status.'
  end
end
