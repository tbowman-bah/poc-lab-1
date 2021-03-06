# -*- coding: utf-8 -*-

machine 'kanga' do
  action [:ready, :converge]
  add_machine_options bootstrap_options:
                        { flavor_ref: 'd0b4c03d-c70c-45d8-81e8-daf7471166a3' # 4_vCPU_RAM_8G_HD_100G
                        }

  files '/etc/chef/encrypted_data_bag_secret' => "#{ENV['PWD']}/.chef/encrypted_data_bag_secret"

  converge false
  complete true

  recipe 'lab::set_msfconsole.rc'
  recipe 'lab::faraday_metasploiteon_plugin'

  role 'base'
  recipe 'build-essential'
  role 'elite-shell'
  role 'sudo'
  role 'emacs'
  role 'ssh'
  role 'ssh-server'
  role 'openvpn-client'
  role 'kali'
  recipe 'pentester::msf_pkg'
  role 'metasploit'
  recipe 'kali::pwtools'
  recipe 'kali::web'
  recipe 'kali::top10'
  role 'faraday'
  role 'docker'
  recipe 'lab::sudo_nmap'
  recipe 'lab::sudo_tcpdump'
  recipe 'lab::cscan'
  recipe 'lab::python_venvs'
  recipe 'lab::cron_chef_client'

  attributes 'pentester' => {
               'w3af' => {
                 'profiles' => {},
               },
             },
             'lab' => {
               'cscan' => {
                 'ips' => ['192.168.42.0/24'],
               },
             }
end
