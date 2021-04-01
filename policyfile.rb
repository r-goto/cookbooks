# Policyfile.rb - Describe how you want Chef Infra Client to build your system.
#
# For more information on the Policyfile feature, visit
# https://docs.chef.io/policyfile/

name 'bootstrap_a_node'

default_source :supermarket

run_list 'bootstrap_a_node::default'

cookbook 'bootstrap_a_node', path: '.'
cookbook 'slack_handler', '~> 1.0.0', :supermarket
cookbook 'chef_client_updater', '~> 3.11.1', :supermarket
cookbook 'chef-client', '~> 12.3.3', :supermarket
