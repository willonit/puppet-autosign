source "https://rubygems.org"

group :test do
  gem "rake"
  gem "puppet", ENV['PUPPET_VERSION'] || '~> 3.7.0'
  gem "rspec", '< 3.2.0'
  gem "rspec-puppet", :git => 'https://github.com/rodjek/rspec-puppet.git'
  gem "puppetlabs_spec_helper"
  gem "metadata-json-lint"
  gem "rspec-puppet-facts"
  gem "listen", '3.0.8'
  gem "json_pure", '2.0.1'
end

group :development do
  gem "travis"
  gem "travis-lint"
  gem "vagrant-wrapper"
  gem "puppet-blacksmith"
  gem "guard-rake"
  gem 'puppet_spec_facts'
end

group :system_tests do
  gem "beaker"
  gem "beaker-rspec"
  gem 'beaker-puppet_install_helper'
end

gem 'autosign', '>= 0.0.8'
