# InSpec test for recipe bootstrap_a_node::client_setup.rb

# The InSpec reference, with examples and extensive documentation, can be
# found at https://docs.chef.io/inspec/resources/

describe user('r-goto') do
  it { should exist }
end
