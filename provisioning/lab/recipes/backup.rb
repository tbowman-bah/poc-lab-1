# -*- coding: utf-8 -*-

include_recipe 'backup'
backup_install node.name
backup_generate_config node.name do
  base_dir "#{node['lab']['home']}/backup"
  tmp_path "#{node['lab']['home']}/backup/tmp"
  data_path "#{node['lab']['home']}/backup/.data"
end
