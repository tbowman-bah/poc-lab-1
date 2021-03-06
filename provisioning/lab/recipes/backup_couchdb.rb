# -*- coding: utf-8 -*-

include_recipe 'lab::backup'
backup_generate_model 'couchdb' do
  description 'Couchdb backup'
  base_dir "#{node['lab']['home']}/backup"
  backup_type 'archive'
  tmp_path "#{node['lab']['home']}/backup/tmp"
  action :backup
  gem_bin_dir '/opt/chef/embedded/bin/'
  options 'add' => ['/usr/local/var/lib/couchdb'],
          'exclude' => [],
          'tar_options' => '-p'
  store_with 'engine' => 'Local',
             'settings' => { 'local.path' => "#{node['lab']['home']}/backup",
                             'local.keep' => 10 }

  mailto 'eliot@localhost'
  cron_path '/bin:/usr/bin:/usr/local/bin'
  cron_log "#{node['lab']['home']}/backup/logs/couchdb.log"
  weekday '5'
  hour '0'
  minute '0'

  before_hook <<-HOOK
    system "systemctl stop couchdb"
HOOK
  after_hook <<-HOOK
    system "systemctl start couchdb"
HOOK
end
