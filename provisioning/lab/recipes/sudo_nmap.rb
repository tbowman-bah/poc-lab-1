# -*- coding: utf-8 -*-

sudo 'nmap' do
  user node['lab']['user']
  runas 'root'
  commands ['/usr/bin/nmap']
  nopasswd true
end
