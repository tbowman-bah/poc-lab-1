# -*- coding: utf-8 -*-

package 'apt-transport-https'

execute 'apt-get update' do
  action :nothing
end

apt_repository 'docker' do
  uri 'https://apt.dockerproject.org/repo'
  distribution 'debian-stretch'
  components ['main']
  deb_src false
  keyserver 'hkp://p80.pool.sks-keyservers.net:80'
  key '58118E89F3A912897C070ADBF76221572C52609D'
  notifies :run, 'execute[apt-get update]'
end

package 'apt-transport-https'

docker_installation_package 'default' do
  version '1.12.6'
  package_version '1.12.6-0~debian-stretch'
  action :create
end
