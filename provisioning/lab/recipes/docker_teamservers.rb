# -*- coding: utf-8 -*-

msf_db = node['pentester']['msf']['db'].dup
if node['pentester']['msf']['use_db']
  item = data_bag_item(node['pentester']['databag_name'],
                       node['pentester']['databag_items']['msf'])
  msf_db.merge!(item['db'])
end

dockerdir = "#{node['lab']['home']}/elite-stuff/dockerfiles"
msfrpcdir = 'msfrpc_git'
teamserverdir = 'teamserver_custom'

host = node['ipaddress']

if node['network']['interfaces'].key?('tun0')
  node['network']['interfaces']['tun0']['addresses'].each do |addr, _infos|
    host = addr
    break
  end
end

if Dir.exist? dockerdir
  docker_image msfrpcdir do
    action :build_if_missing
    repo msfrpcdir
    tag 'latest'
    source "#{dockerdir}/#{msfrpcdir}"
    read_timeout 300
    write_timeout 300
  end

  docker_image teamserverdir do
    action :build_if_missing
    repo teamserverdir
    tag 'latest'
    source "#{dockerdir}/#{teamserverdir}"
    read_timeout 300
    write_timeout 300
  end

  node['lab']['teamserver_list'].each do |ts, opt|
    %w(msf4 armitage).each do |d|
      directory "#{node['lab']['home']}/teamservers/#{ts}/#{d}" do
        action :create
        recursive true
      end
    end

    template "#{node['lab']['home']}/teamservers/#{ts}/database.yml" do
      cookbook 'pentester'
      source 'msf/database.yml.erb'
      variables msf: { 'user' => msf_db['user'],
                       'pass' => msf_db['pass'],
                       'db' => "teamserver_#{ts}",
                     }
    end

    docker_container "msfrpc_#{ts}" do
      action :run_if_missing
      repo msfrpcdir
      tag 'latest'
      port ["#{opt['handlers_ports']}:#{opt['handlers_ports']}", # Handlers
            "#{opt['rpc_port']}:#{opt['rpc_port']}", # RPC
           ]
      volume ["#{node['lab']['home']}/teamservers/#{ts}/msf4:/root/.msf4",
              "#{node['lab']['home']}/teamservers/#{ts}/database.yml:/msf/config/database.yml",
             ]
      env ['MSFRPC_USER=msf',
           "MSFRPC_PASS=pentestlab-#{ts}",
           'MSFRPC_HOST=0.0.0.0',
           "MSFRPC_PORT=#{opt['rpc_port']}",
          ]
    end

    docker_container "teamserver_#{ts}" do
      action :run_if_missing
      repo teamserverdir
      tag 'latest'
      port ["#{opt['ts_port']}:#{opt['ts_port']}"]
      volume ["#{node['lab']['home']}/teamservers/#{ts}/armitage:/root/.armitage",
              "#{node['lab']['home']}/teamservers/#{ts}/database.yml:/armitage/database.yml",
             ]
      env ['MSF_DATABASE_CONFIG=/armitage/database.yml']
      command "#{host} #{opt['rpc_port']} msf pentestlab-#{ts} #{opt['ts_port']} #{host}"
    end
  end
else
  Chef::Log.warn('Deploying teamservers requires the 1337 stuff!!')
end
