# -*- coding: utf-8 -*-

item = data_bag_item(node['pentester']['databag_name'], 'beef')
beef_db = item['db']

include_recipe 'database::postgresql'

postgresql_connection_info = {
  host: node['pentester']['db']['host'],
  port: node['pentester']['db']['port'],
  username: node['pentester']['db']['username'],
  password: node['pentester']['db']['password'],
}

postgresql_database_user beef_db['db_user'] do
  connection postgresql_connection_info
  password beef_db['db_passwd']
  action :create
end

postgresql_database beef_db['db_name'] do
  connection postgresql_connection_info
  owner beef_db['db_user']
  action :create
end
