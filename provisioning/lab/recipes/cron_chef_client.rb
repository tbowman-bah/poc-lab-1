# -*- coding: utf-8 -*-

include_recipe 'cron'

cron_d 'chef-client' do
  minute 0
  hour 7
  command 'chef-client'
  user 'root'
end
