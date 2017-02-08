# -*- coding: utf-8 -*-

item = data_bag_item(node['pentester']['databag_name'], 'beef')
beef_db = item['db']

node.override['beef']['config']['beef']['database']['db_name'] = beef_db['db_name']
node.override['beef']['config']['beef']['database']['db_user'] = beef_db['db_user']
node.override['beef']['config']['beef']['database']['db_passwd'] = beef_db['db_passwd']

link '/usr/bin/gem' do
  link_type :symbolic
  to '/usr/bin/gem2.1'
  not_if { File.exist? '/usr/bin/gem' }
end
