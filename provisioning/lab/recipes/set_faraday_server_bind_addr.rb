# -*- coding: utf-8 -*-

if Chef::Config[:solo]
  Chef::Log.warn('This recipe uses search. Chef Solo does not support search.')
else
  begin
    search(:node, 'role:faraday-server') do |server|
      ip = server['ipaddress']
      # Get tun0 address if we can
      begin
        server['network']['interfaces']['tun0']['addresses'].each do |addr, _infos|
          ip = addr
          break
        end
      rescue StandardError
        Chef::Log.warn('Cannot get tun0 IP address')
      end
      node.override['faraday']['server']['config']['faraday_server']['bind_address'] = ip
    end
  rescue StandardError
    Chef::Log.warn('No faraday-server server found.')
  end
end
