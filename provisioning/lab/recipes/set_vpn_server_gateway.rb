# -*- coding: utf-8 -*-

if Chef::Config[:solo]
  Chef::Log.warn('This recipe uses search. Chef Solo does not support search.')
else
  begin
    search(:node, 'role:openvpn-server') do |server|
      node.override['openvpn']['gateway'] = server['ipaddress']
    end
  rescue StandardError
    Chef::Log.warn('No vpn server found.')
  end
end
