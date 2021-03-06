# -*- coding: utf-8 -*-

docker_service 'default' do
  action [:create, :start]
  group 'docker'
end

group 'docker' do
  action [:create, :modify]
  append true
  members [node['lab']['user']]
end
