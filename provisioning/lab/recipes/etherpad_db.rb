# -*- coding: utf-8 -*-

item = data_bag_item('lab', 'etherpad')
db = item['db']

include_recipe 'database::postgresql'

postgresql_connection_info = {
  host: node['pentester']['db']['host'],
  port: node['pentester']['db']['port'],
  username: node['pentester']['db']['username'],
  password: node['pentester']['db']['password'],
}

postgresql_database_user db['user'] do
  connection postgresql_connection_info
  password db['pass']
  action :create
end

postgresql_database db['db'] do
  connection postgresql_connection_info
  owner db['user']
  action :create
end
