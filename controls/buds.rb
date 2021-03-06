# -*- coding: utf-8 -*-

title 'Buds machine'

control 'Postgresql Server' do
  impact 1.0
  title 'is running'
  desc 'Check the Postgresql server is correctly running.'

  describe port 5432 do
    it { should be_listening }
    its('protocols') { should include 'tcp' }
    its('addresses') { should include '0.0.0.0' }
  end
end

control 'CouchDB Server' do
  impact 1.0
  title 'is running'
  desc 'Check the CouchDB server is correctly running.'

  describe port 5984 do
    it { should be_listening }
    its('protocols') { should include 'tcp' }
    its('addresses') { should include '0.0.0.0' }
  end
end
