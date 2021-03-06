# -*- coding: utf-8 -*-

directory "#{node['lab']['home']}/cscans" do
  owner node['lab']['user']
  group node['lab']['group']
  mode '0775'
  recursive true
end

cscan = node['lab']['cscan']
faraday_cscan 'lab' do
  action [:install, :configure]
  path "#{node['lab']['home']}/cscans"
  ips cscan['ips']
  websites cscan['websites']
  user node['lab']['user']
  group node['lab']['group']
  git_repository 'https://github.com/Sliim/cscan.git'
  git_reference 'master'
  config CS_CATEGORIES: cscan['categories'],
         CS_SCRIPTS: cscan['scripts'],
         CS_NMAP: 'sudo nmap',
         CS_NMAP_ARGS: '-p- -O -sT -T5 -Pn --script=default,safe,discovery,version',
         CS_NIKTO: 'nikto',
         CS_NIKTO_ARGS: '-C all',
         CS_OPENVAS_USER: 'admin',
         CS_OPENVAS_PASSWORD: '4d5ae556-4355-4b08-aabe-435088d413c2',
         CS_OPENVAS_SCAN_CONFIG: 'Full and fast',
         CS_OPENVAS_ALIVE_TEST: 'ICMP, TCP-ACK Service &amp; ARP Ping',
         CS_OPENVAS: 'omp',
         CS_MSF_TMP_WS: 'disabled',
         CS_MSF_EXPORT: 'disabled'
end
