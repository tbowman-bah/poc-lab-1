# -*- coding: utf-8 -*-

package 'postgresql-server-dev-9.6'

['do_postgres', 'dm-postgres-adapter'].each do |package|
  gem_package package
end

['echo "gem \'dm-postgres-adapter\'" >> Gemfile',
 'bundle install'].each do |command|
  execute command do
    cwd node['beef']['path']
  end
end
