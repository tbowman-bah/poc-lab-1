# -*- coding: utf-8 -*-

machine 'buds' do
  action [:ready, :converge]
  add_machine_options bootstrap_options:
                        { flavor_ref: 'ce71b7e1-2736-486e-899f-72f1c5ad730f' # 2_vCPU_RAM_4G_HD_100G
                        }

  files '/etc/chef/encrypted_data_bag_secret' => "#{ENV['PWD']}/.chef/encrypted_data_bag_secret"

  converge false
  complete true

  role 'base'
  role 'elite-shell'
  role 'sudo'
  role 'ssh'
  role 'ssh-server'
  role 'openvpn-client'
  role 'couchdb'
  role 'postgresql-server'
  recipe 'lab::cron_chef_client'

  attributes \
    'elite' => {
    'packages' => ['git-core', 'htop', 'nload', 'iftop', 'ruby2.1',
                   'ruby2.1-dev', 'sqlite3', 'libsqlite3-dev',
                   'libmysqlclient-dev', 'build-essential'
                  ],
  }
end
