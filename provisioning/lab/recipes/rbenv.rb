# -*- coding: utf-8 -*-

rbenv_ruby node['lab']['rbenv']['version'] do
  global true
end

rbenv_gem 'bundler' do
  package_name 'bundler'
  ruby_version node['lab']['rbenv']['version']
end
