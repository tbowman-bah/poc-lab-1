# -*- coding: utf-8 -*-

title 'Seeds machine'

control 'VPN Server' do
  impact 1.0
  title 'is running'
  desc 'Check the VPN server is correctly running.'

  describe port 1194 do
    it { should be_listening }
    its('protocols') { should include 'udp' }
    its('addresses') { should include '0.0.0.0' }
  end
end
