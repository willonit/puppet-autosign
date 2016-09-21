require 'beaker-rspec/spec_helper'
require 'beaker-rspec/helpers/serverspec'

unless ENV['BEAKER_provision'] == 'no'
  hosts.each do |host|
    # Install Puppet
    on host, 'curl https://raw.githubusercontent.com/danieldreier/puppet-installer/master/install_puppet.sh | bash'
  end
end

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
      on host, puppet('module', 'install', 'puppetlabs-pupppetserver_gem'), { :acceptable_exit_codes => [0,1] }
    end
  end
end


