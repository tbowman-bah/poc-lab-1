# -*- coding: utf-8 -*-

sudo 'su' do
  user node['lab']['user']
  runas 'root'
  commands ['/bin/su']
  nopasswd true
end
