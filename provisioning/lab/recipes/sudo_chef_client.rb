# -*- coding: utf-8 -*-

sudo 'chef-client' do
  user node['lab']['user']
  runas 'root'
  commands ['/usr/bin/chef-client']
  nopasswd true
end
