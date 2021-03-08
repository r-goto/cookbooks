#
# Cookbook:: chefnode_setup
# Recipe:: client_setup.rb
#
# Copyright:: 2021, The Authors, All Rights Reserved.

###########
# Setup client.rb with Chef Server access credentials
###########

chef_client_config 'client.rb' do
  chef_server_url "https://#{node['chefnode_setup']['chef_server']['fqdn']}/organizations/#{node['chefnode_setup']['org_name']}"
  chef_license 'accept'
  log_location 'STDOUT'
  policy_name "#{node['chefnode_setup']['policy_name']}"
  policy_group "#{node['chefnode_setup']['policy_group']}"
  additional_config "validation_key \"/etc/chef/#{node['chefnode_setup']['org_name']}-validator.pem\"\ntrusted_certs_dir \"/etc/chef/trusted_certs\""
end

directory '/etc/chef/trusted_certs' do
  mode '755'
end

cookbook_file 'Place SSL certificate to /etc/chef/trusted_certs' do
  source "#{node['chefnode_setup']['chef_server']['fqdn']}.crt"
  mode '644'
  owner 'root'
  path "/etc/chef/trusted_certs/#{node['chefnode_setup']['chef_server']['fqdn']}.crt"
end

###########
# Create client.pem and delete org-validator after first CCR
###########

ruby_block 'edit etc hosts' do
  block do
    rc = Chef::Util::FileEdit.new('/etc/hosts')
    rc.insert_line_if_no_match(/#{node['chefnode_setup']['chef_server']['fqdn']}/, "#{node['chefnode_setup']['chef_server']['ipaddress']} #{node['chefnode_setup']['chef_server']['fqdn']}")
    rc.write_file
  end
end

cookbook_file "Place validator key for Org:#{node['chefnode_setup']['org_name']}" do
  not_if { ::File.exist?('/etc/chef/client.pem') }
  source "#{node['chefnode_setup']['org_name']}-validator-key" # Watch out for the file name
  mode '0755'
  owner 'root'
  path "/etc/chef/#{node['chefnode_setup']['org_name']}-validator.pem" # Watch out for the file name
end

file 'Delete org validator key' do
  only_if { ::File.exist?('/etc/chef/client.pem') }
  path "/etc/chef/#{node['chefnode_setup']['org_name']}-validator.pem"
  action :delete
end

###########
# Setup systemd timer to run chef-client periodically.
###########

chef_client_systemd_timer 'Run Chef Infra Client every x minutes' do
  interval "#{node['chefnode_setup']['chef_client_systemd_timer']['interval']}"
  splay "#{node['chefnode_setup']['chef_client_systemd_timer']['splay']}"
end
