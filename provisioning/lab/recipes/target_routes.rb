# -*- coding: utf-8 -*-

ts_addr = nil

if Chef::Config[:solo]
  Chef::Log.warn('This recipe uses search. Chef Solo does not support search.')
else
  begin
    search(:node, 'role:teamserver') do |server|
      ts_addr = server['ipaddress']
    end
  rescue StandardError
    Chef::Log.warn('No teamserver found.')
  end

  unless ts_addr.nil?
    route '192.168.42.0/24' do
      gateway ts_addr
    end

    iptables_rule 'vpn_route_target_1' do
      action :enable
      cookbook 'lab'
      source 'iptables/vpn_route_target.erb'
      variables source: "#{node['openvpn']['subnet']}/24",
                dest: '192.168.42.0/24'
    end
  end
end
