# -*- coding: utf-8 -*-

machine 'forbidden' do
  action [:ready, :converge]
  add_machine_options bootstrap_options:
                        { flavor_ref: 'c12b959c-2188-4711-984d-84f439d24d8c' # 4_vCPU_RAM_16G_HD_100G
                        }

  files '/etc/chef/encrypted_data_bag_secret' => "#{ENV['PWD']}/.chef/encrypted_data_bag_secret"

  converge false
  complete true

  recipe 'lab::teamserver_tmux_script'
  role 'base'
  recipe 'build-essential'
  role 'elite-shell'
  role 'ssh'
  role 'ssh-server'
  role 'openvpn-client'
  role 'kali'
  role 'sudo'
  recipe 'lab::sudo_nmap'
  recipe 'lab::sudo_tcpdump'
  recipe 'lab::cron_chef_client'
  recipe 'lab::libcurl'
  recipe 'glances'

  recipe 'pentester::mitmproxy'
  recipe 'pentester::msf_pkg'
  role 'metasploit'
  role 'teamserver'
  role 'faraday'

  role 'docker'
  recipe 'lab::docker_teamservers'
  role 'beef-server'

  recipe 'lab::python_venvs'

  recipe 'lab::iptables_teamserver'
  role 'ip-forward'

  recipe 'kali::pwtools'

  attributes 'pentester' => {
               'msf' => {
                 'msfconsole.rc' => ['workspace default'],
               },
             },
             'lab' => {
               'teamserver_list' => {
                 'post' => {
                   'handlers_ports' => '9000-9009',
                   'rpc_port' => '51111',
                   'ts_port' => '61111',
                 },
               },
             },
             'openvpn' => {
               'config' => {
                 'extras' => [
                   'route-nopull',
                   'route 10.13.37.0 255.255.255.0',
                 ],
               },
             }
end
