# -*- coding: utf-8 -*-

buds_ip = ''

if Chef::Config[:solo]
  Chef::Log.warn('This recipe uses search. Chef Solo does not support search.')
else
  begin
    search(:node, 'name:buds') do |server|
      buds_ip = server['ipaddress']
      # Get tun0 address if we can
      begin
        server['network']['interfaces']['tun0']['addresses'].each do |addr, _infos|
          buds_ip = addr
          break
        end
      rescue StandardError
        Chef::Log.warn('Cannot get tun0 IP address for buds')
      end
    end
  rescue StandardError
    Chef::Log.warn('buds server found.')
  end
end

unless buds_ip.empty?
  include_recipe 'lab::backup'

  backups_list = { buds: ['/home/eliot/backup/couchdb',
                          '/home/eliot/backup/postgresql'] }
  server_ips = { buds: buds_ip }

  backups_list.keys.each do |server|
    backup_generate_model server do
      description "#{server.capitalize} backup"
      base_dir "#{node['lab']['home']}/backup"
      action :backup
      backup_type 'syncer'
      gem_bin_dir '/usr/local/rbenv/versions/2.3.0/bin'
      options 'add' => backups_list[server],
              'exclude' => ['tmp', '.gnupg']
      sync_with 'syncer' => 'RSync::Pull',
                'settings' => { 'syncer.path' => "#{node['lab']['home']}/backup/#{server}",
                                'syncer.mode' => :ssh,
                                'syncer.host' => server_ips[server],
                                'syncer.additional_ssh_options' => "-i #{node['lab']['home']}/.ssh/id_rsa",
                                'syncer.ssh_user' => node['lab']['user'] }

      mailto 'eliot@localhost'
      cron_path '/bin:/usr/bin:/usr/local/bin'
      cron_log "#{node['lab']['home']}/backup/logs/#{server}.log"
      weekday '6'
      hour '0'
      minute '0'
    end
  end
end
