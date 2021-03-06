# -*- coding: utf-8 -*-

host = '127.0.0.1'
port = '5432'

if Chef::Config[:solo]
  Chef::Log.warn('This recipe uses search. Chef Solo does not support search.')
else
  begin
    search(:node, 'role:postgresql-server') do |server|
      host = server['ipaddress']
      port = server['pentester']['db']['port']
    end
  rescue StandardError
    Chef::Log.warn('No postgresql server found.')
  end
end

msf_db = node['pentester']['msf']['db'].dup
if node['pentester']['msf']['use_db']
  item = data_bag_item(node['pentester']['databag_name'],
                       node['pentester']['databag_items']['msf'])
  msf_db.merge!(item['db'])
end

node.override['faraday']['config']['plugin_settings'] = {
  MetasploitOn: {
    settings: {
      Enable: '1',
      Server: host,
      Database: msf_db['db'],
      Port: port.to_s,
      User: msf_db['user'],
      Password: msf_db['pass'],
      Wordspace: 'default',
    },
    plugin_version: '0.0.3',
    name: 'Metasploit Online Service Plugin',
    version: 'Metasploit 4.10.0',
    description: '',
  },
}.to_json
