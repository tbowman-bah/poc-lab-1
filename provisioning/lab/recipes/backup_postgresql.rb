# -*- coding: utf-8 -*-

include_recipe 'lab::backup'
backup_generate_model 'postgresql' do
  description 'PostgreSQL backup'
  base_dir "#{node['lab']['home']}/backup"
  backup_type 'database'
  database_type 'PostgreSQL'
  compress_with 'Gzip'
  tmp_path "#{node['lab']['home']}/backup/tmp"
  action :backup
  gem_bin_dir '/opt/chef/embedded/bin/'

  options('db.name' => ':all',
          'db.username' => '"postgres"',
          'db.password' => "\"#{node['postgresql']['password']['postgres']}\"",
          'db.host' => '"localhost"')

  store_with 'engine' => 'Local',
             'settings' => { 'local.path' => "#{node['lab']['home']}/backup",
                             'local.keep' => 10 }

  mailto 'eliot@localhost'
  cron_path '/bin:/usr/bin:/usr/local/bin'
  cron_log "#{node['lab']['home']}/backup/logs/postgresql.log"
  weekday '5'
  hour '0'
  minute '0'
end
