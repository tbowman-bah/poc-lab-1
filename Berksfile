# -*- coding: utf-8 -*-

source 'https://supermarket.chef.io'

cookbook 'lab', path: 'provisioning/lab'
cookbook 'machines', path: 'provisioning/machines'

cookbook 'hostname'
cookbook 'openssh'
cookbook 'build-essential'
cookbook 'system'
cookbook 'sysctl'
cookbook 'glances'
cookbook 'cron'
cookbook 'sudo'
cookbook 'logrotate'
cookbook 'certificate'
cookbook 'user-ssh-keys'
cookbook 'chef-client-hardening'
cookbook 'butterfly'
cookbook 'elite'
cookbook 'openvpn',
         git: 'https://github.com/xhost-cookbooks/openvpn',
         ref: '3807d4b'
cookbook 'docker',
         git: 'https://github.com/chef-cookbooks/docker',
         ref: 'v2.9.3'
cookbook 'apt',
         git: 'https:///github.com/bramwelt/apt',
         ref: 'replace-update-notifier'
cookbook 'locales',
         git: 'https:///github.com/redguide/locales',
         ref: 'v0.4.0'
cookbook 'pyenv',
         git: 'https:///github.com/sds/chef-pyenv',
         ref: 'v0.1.0'

# Pentest
cookbook 'kali'
cookbook 'proxychains'
cookbook 'dradis'
cookbook 'beef'
cookbook 'faraday'
cookbook 'pentester'

# Backup
cookbook 'backup',
         git: 'https:///github.com/damm/backup',
         ref: '0.3.0'

# Forks
cookbook 'rbenv',
         git: 'https:///github.com/sliim-cookbooks/rbenv-cookbook',
         ref: 'user-shell'
cookbook 'couchdb',
         git: 'https:///github.com/sliim-cookbooks/couchdb-cookbook',
         ref: 'master'
cookbook 'tor-full',
         git: 'https:///github.com/sliim-cookbooks/tor-full',
         ref: 'kali-support'
