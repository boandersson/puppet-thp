source 'https://rubygems.org'

puppetversion = ENV.key?('PUPPET_VERSION') ? "= #{ENV['PUPPET_VERSION']}" : ['>= 3.3']
gem 'puppet', puppetversion
gem 'puppetlabs_spec_helper', '>= 0.1.0'
gem 'puppet-lint', '>= 1.0.0'
gem 'facter', '>= 1.7.0', '< 1.8.0'
gem 'rspec-puppet'
gem 'rubocop' if RUBY_VERSION >= '1.9.3'

# rspec must be v2 for ruby 1.8.7
gem 'rspec', '~> 2.0' if RUBY_VERSION >= '1.8.7' && RUBY_VERSION < '1.9'
