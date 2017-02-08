# -*- coding: utf-8 -*-

host = node['ipaddress']

if node['network']['interfaces'].key?('tun0')
  node['network']['interfaces']['tun0']['addresses'].each do |addr, _infos|
    host = addr
    break
  end
end

node.override['pentester']['teamserver']['bind_addr'] = host
