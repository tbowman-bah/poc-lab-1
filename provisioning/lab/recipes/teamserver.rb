# -*- coding: utf-8 -*-

service 'teamserver' do
  action [:stop, :disable]
end

directory "#{node['lab']['home']}/data" do
  owner node['lab']['user']
  group node['lab']['group']
end

cookbook_file "#{node['lab']['home']}/.msf4/startup-lab.rc" do
  owner node['lab']['user']
  group node['lab']['group']
  source 'startup-lab.rc'
end
