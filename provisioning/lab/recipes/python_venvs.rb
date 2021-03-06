# -*- coding: utf-8 -*-

python_runtime_options '3' do
  package_name 'python3'
  dev_package 'python3-dev'
end

%w(2 3).each do |py|
  python_runtime py.to_s do
    provider :system
  end

  python_virtualenv "#{node['lab']['home']}/venv#{py}" do
    user node['lab']['user']
    group node['lab']['group']
    python py.to_s
  end
end
