# -*- coding: utf-8 -*-

include_recipe 'openvpn::client'

r = resources(openvpn_conf: 'client')
r.cookbook 'lab'
