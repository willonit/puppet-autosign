require 'beaker-rspec/spec_helper'
require 'beaker-rspec/helpers/serverspec'
require 'beaker/puppet_install_helper'


run_puppet_install_helper


RSpec.configure do |c|
  # Project root
  proj_root = File.expand_path(File.join(File.dirname(__FILE__), '..'))

  # Readable test descriptions
  c.formatter = :documentation

  # Configure all nodes in nodeset
  c.before :suite do
    # set necessary basic settings
    puppet_module_install(:source => proj_root, :module_name => 'autosign', :target_module_path => '/etc/puppet/modules')
    hosts.each do |host|
      on host, 'puppet config set parser future'
      on host, 'puppet apply -e "host {$::hostname: ip => $::ipaddress}"'
      on host, 'puppet apply -e "host {$::fqdn: ip => $::ipaddress}"'
    # Install module and dependencies
      on host, puppet('module', 'install', 'puppetlabs-stdlib'), { :acceptable_exit_codes => [0,1] }
    end
  end
end


