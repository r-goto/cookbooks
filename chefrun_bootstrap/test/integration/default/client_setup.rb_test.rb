# InSpec test for recipe chefrun_bootstrap::client_setup.rb

# The InSpec reference, with examples and extensive documentation, can be
# found at https://docs.chef.io/inspec/resources/

describe file('/etc/chef/client.rb') do
  its('content') { should match /chef_license "accept"/ }
  its('content') { should match %r{chef_server_url "https://automate.cl/organizations/first-org"} }
  its('content') { should match /policy_group "staging"/ }
  its('content') { should match /policy_name "web-server"/ }
  its('content') { should match /log_location STDOUT/ }
  its('content') { should match %r{validation_key "/etc/chef/first-org-validator.pem"} }
  its('content') { should match %r{trusted_certs_dir "/etc/chef/trusted_certs"} }
end

describe file('/etc/chef/first-org-validator.pem') do
  it { should exist }
  its('mode') { should cmp '0755' }
  its('owner') { should eq 'root' }
  its('content') { should match /-----BEGIN RSA PRIVATE KEY-----/ }
  its('content') { should match /-----END RSA PRIVATE KEY-----/ }
end

describe file('/etc/hosts') do
  its('content') { should match /198.18.246.201 automate.cl/ }
end

describe file('/etc/chef/trusted_certs/automate.cl.crt') do
  it { should exist }
  its('mode') { should cmp '0644' }
  its('owner') { should eq 'root' }
  its('content') { should match /-----BEGIN CERTIFICATE-----/ }
  its('content') { should match /-----END CERTIFICATE-----/ }
end

describe systemd_service('chef-client.timer') do
  it { should be_running }
  it { should be_enabled }
end
