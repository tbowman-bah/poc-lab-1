# -*- coding: utf-8 -*-

iptables_rule 'target-network-1' do
  lines "*nat\r\n-A POSTROUTING -d 192.168.42.0/24 -j MASQUERADE"
end
