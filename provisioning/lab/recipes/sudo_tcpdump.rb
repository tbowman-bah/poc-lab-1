# -*- coding: utf-8 -*-

sudo 'tcpdump' do
  user node['lab']['user']
  runas 'root'
  commands ['/usr/sbin/tcpdump']
  nopasswd true
end
