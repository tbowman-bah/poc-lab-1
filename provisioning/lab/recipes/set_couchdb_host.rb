# -*- coding: utf-8 -*-

if Chef::Config[:solo]
  Chef::Log.warn('This recipe uses search. Chef Solo does not support search.')
else
  begin
    search(:node, 'role:couchdb') do |server|
      node.override['faraday']['server']['config']['couchdb']['host'] = server['ipaddress']
    end
  rescue StandardError
    Chef::Log.warn('No couchdb server found.')
  end

  begin
    search(:node, 'role:faraday-server') do |server|
      host = server['ipaddress']
      # Get tun0 address if we can
      begin
        server['network']['interfaces']['tun0']['addresses'].each do |addr, _infos|
          host = addr
          break
        end
      rescue StandardError
        Chef::Log.warn('Cannot get tun0 IP address')
      end
      port = server['faraday']['server']['config']['faraday_server']['port']
      node.override['faraday']['config']['couch_uri'] = "http://#{host}:#{port}"
    end
  rescue StandardError
    Chef::Log.warn('No faraday-server server found.')
  end
end
