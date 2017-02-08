# -*- coding: utf-8 -*-

default['lab']['user'] = 'eliot'
default['lab']['group'] = 'eliot'
default['lab']['home'] = '/home/eliot'

default['lab']['rbenv']['versions'] = []

default['lab']['cscan']['ips'] = []
default['lab']['cscan']['websites'] = []
default['lab']['cscan']['categories'] = 'network,web,extra'
default['lab']['cscan']['scripts'] = 'msf-basic-discovery-nmap.sh,msf-autoscan.sh,nikto.sh,msf-autosploit.sh'

default['lab']['teamserver_list'] = {}
