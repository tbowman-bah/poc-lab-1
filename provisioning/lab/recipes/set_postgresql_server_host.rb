# -*- coding: utf-8 -*-

if Chef::Config[:solo]
  Chef::Log.warn('This recipe uses search. Chef Solo does not support search.')
else
  begin
    search(:node, 'role:postgresql-server') do |server|
      node.override['pentester']['db']['host'] = server['ipaddress']
      node.override['beef']['config']['beef']['database']['db_host'] = server['ipaddress']
    end
  rescue StandardError
    Chef::Log.warn('No vpn server found.')
  end
end
