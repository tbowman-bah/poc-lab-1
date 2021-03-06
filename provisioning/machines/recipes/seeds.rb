# -*- coding: utf-8 -*-

machine 'seeds' do
  action [:ready, :converge]
  add_machine_options bootstrap_options:
                        { flavor_ref: 'ff2053d0-47b4-40f2-9551-273d61f79fa2', # 2_vCPU_RAM_8G_HD_100G
                          floating_ip_pool: 'PublicNetwork-02',
                        },
                      transport_address_location: :public_ip

  files '/etc/chef/encrypted_data_bag_secret' => "#{ENV['PWD']}/.chef/encrypted_data_bag_secret"

  converge false
  complete true

  role 'base'
  role 'elite-shell'
  role 'sudo'
  role 'ssh'
  role 'ssh-server'
  role 'openvpn-server'
  role 'rbenv'
  role 'emacs'
  role 'butterfly'
  recipe 'lab::backup_syncer'
  recipe 'lab::sudo_tcpdump'
  recipe 'lab::cron_chef_client'

  attributes \
    'elite' => {
    'packages' => ['git-core', 'htop', 'nload', 'iftop',
                   'python-virtualenv', 'python-dev', 'tcpdump'
                  ],
  }
end
