# -*- coding: utf-8 -*-

machine 'bliss' do
  action [:ready, :converge]
  add_machine_options bootstrap_options:
                        { flavor_ref: 'ce71b7e1-2736-486e-899f-72f1c5ad730f' # 2_vCPU_RAM_4G_HD_100G
                        }

  files '/etc/chef/encrypted_data_bag_secret' => "#{ENV['PWD']}/.chef/encrypted_data_bag_secret"

  converge false
  complete true

  role 'base'
  recipe 'build-essential'
  role 'elite-shell'
  role 'ssh'
  role 'ssh-server'
  role 'openvpn-client'
  role 'kali'
  role 'sudo'
  recipe 'lab::cron_chef_client'
  role 'docker'
  role 'elite-stuff'

  role 'faraday-server'
  role 'gitrob'

  recipe 'lab::docker_ctfpad'
end
