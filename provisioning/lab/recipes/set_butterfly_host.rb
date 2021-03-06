# -*- coding: utf-8 -*-

host = node['ipaddress']
begin
  node['network']['interfaces']['tun0']['addresses'].each do |addr, _infos|
    host = addr
    break
  end
rescue
  Chef::Log.warn('Cannot retrieve tun0 address, use `ipaddress` instead.')
end

node.override['butterfly']['config']['host'] = "\"#{host}\""
