# -*- coding: utf-8 -*-

teamserver = nil
if Chef::Config[:solo]
  Chef::Log.warn('This recipe uses search. Chef Solo does not support search.')
else
  begin
    search(:node, 'role:teamserver') do |server|
      teamserver = server
    end
  rescue StandardError
    Chef::Log.warn('No teamserver found.')
  end
end

unless teamserver.nil?
  msf_db = node['pentester']['msf']['db'].dup
  if node['pentester']['msf']['use_db']
    item = data_bag_item(node['pentester']['databag_name'],
                         node['pentester']['databag_items']['msf'])
    msf_db.merge!(item['db'])
  end

  teamserver['lab']['teamserver_list'].each do |ts, _config|
    postgresql_database "teamserver_#{ts}" do
      connection host: node['pentester']['db']['host'],
                 port: node['pentester']['db']['port'],
                 username: node['pentester']['db']['username'],
                 password: node['pentester']['db']['password']
      owner msf_db['user']
      action :create
    end
  end
end
