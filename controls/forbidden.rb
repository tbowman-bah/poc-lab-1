# -*- coding: utf-8 -*-

title 'Forbidden machine'

control 'HTTP Server' do
  impact 1.0
  title 'is running'
  desc 'Check the HTTP server is correctly running.'

  describe port 4242 do
    it { should be_listening }
    its('protocols') { should include 'tcp' }
  end
end

control 'Teamserver' do
  impact 1.0
  title 'is running'
  desc 'Check the Teamserver is correctly running.'

  describe port 55553 do
    it { should be_listening }
  end
end

control 'MSFRPC' do
  impact 1.0
  title 'is running'
  desc 'Check the MSFRPC proxy is correctly running.'

  describe port 55555 do
    it { should be_listening }
  end
end

control 'Post Teamserver' do
  impact 1.0
  title 'is running'
  desc 'Check the Post Teamserver container is correctly running.'

  describe port 55553 do
    it { should be_listening }
  end
end

control 'Post MSFRPC' do
  impact 1.0
  title 'is running'
  desc 'Check the Post MSFRPC container is correctly running.'

  describe port 55555 do
    it { should be_listening }
  end
end
