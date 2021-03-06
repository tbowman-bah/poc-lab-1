# -*- coding: utf-8 -*-

title 'Bliss machine'

control 'Faraday Server' do
  impact 1.0
  title 'is running'
  desc 'Check the Faraday server is correctly running.'

  describe port 5985 do
    it { should be_listening }
    its('protocols') { should include 'tcp' }
    its('addresses') { should_not include '0.0.0.0' }
  end
end

control 'Gitrob' do
  impact 1.0
  title 'is running'
  desc 'Check Gitrob container is correctly running.'

  describe port 9393 do
    it { should be_listening }
  end
end

control 'CTFPad' do
  impact 1.0
  title 'is running'
  desc 'Check CTFPad container is correctly running.'

  describe port 1234 do
    it { should be_listening }
  end

  describe port 1235 do
    it { should be_listening }
  end
end
