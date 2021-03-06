# -*- coding: utf-8 -*-

$debug = false

def bundle_exec(command)
  sh "bundle exec #{command}"
end

def knife_ssh_sudo(query, command)
  sh "knife ssh '#{query}' 'sudo #{command}' -x debian -i secrets/pentester -a ipaddress"
  # sh "knife ssh '#{query}' '#{command}' -x debian -i secrets/pentester -a cloud.public_ipv4 'role:base'"
end

def chef_client_command
  str = 'chef-client'
  str << ' --log_level debug' if $debug
  str << ' -c .chef/knife.rb'
  str << ' -r recipe[lab]'
  str
end

task :clean do
  rm_rf 'nodes/'
  rm_rf 'cache/'
  rm_rf 'cookbooks'
end

task :vendor do
  Rake::Task['clean'].invoke
  bundle_exec 'berks vendor cookbooks'
end

task :package do
  package_name = 'pentestlab.tar.gz'
  sh "test -f #{package_name} && rm #{package_name} || echo no package found"
  sh "tar cvfz #{package_name} --exclude=cache --exclude=syntaxcache roles cookbooks Berksfile* Gemfile* .chef Rakefile openstack controls inspec.yml"
end

task :provision, [:node] do |_t, args|
  bundle_exec "#{chef_client_command},recipe[machines::#{args[:node]}]"
end

namespace :lab do
  desc 'Chef client on all nodes on the lab'
  task :chef_client do
    knife_ssh_sudo 'role:base', 'chef-client'
  end
  desc 'Setup VPN clients'
  task :vpn_setup do
    knife_ssh_sudo 'role:openvpn-client', 'mkdir -p /etc/openvpn/tmp; sudo tar xvfz /home/eliot/vpn.tar.gz -C /etc/openvpn/tmp;' \
                                          'sudo mv /etc/openvpn/tmp/ca.crt /etc/openvpn/ca.crt;sudo mv /etc/openvpn/tmp/*.crt /etc/openvpn/client.crt;' \
                                          'sudo mv /etc/openvpn/tmp/*.key /etc/openvpn/client.key;'
    knife_ssh_sudo 'role:openvpn-client', 'systemctl restart openvpn'
  end
  desc 'Open tmux session'
  task :tmux do
    sh 'knife ssh "role:base" tmux --tmux-split -a ipaddress'
  end
  task :gitrob do
    sh 'knife ssh "role:gitrob"  "gitrob server --bind-address=10.13.37.18" -a ipaddress -x eliot'
  end
  namespace :dradis do
    dpath = '/opt/dradis-ce'
    task :setup do
      knife_ssh 'role:dradis', "sudo sed -i \"s/\\.\\.\\/dradis/plugins\\/dradis/g\" #{dpath}/Gemfile"
      knife_ssh 'role:dradis', "cd #{dpath}; sudo bundle install; sudo rake db:setup"
    end
    task :run do
      knife_ssh 'role:dradis', "cd #{dpath}; sudo bundle exec rails server --bind 0.0.0.0"
    end
  end

  task :inspec do
    %w(seeds buds bliss forbidden).each do |m|
      bundle_exec "inspec exec ./controls/#{m}.rb -b ssh -t ssh://debian@$(knife node show #{m} -a ipaddress|grep ipaddress|cut -d' ' -f4) -i secrets/pentester --sudo"
    end
  end
end

namespace :server do
  namespace :upload do
    desc 'Upload artifacts on Chef server'
    task :all do
      Rake::Task['server:upload:cookbooks'].invoke
      Rake::Task['server:upload:roles'].invoke
      Rake::Task['server:upload:databags'].invoke
    end

    task :cookbooks do
      bundle_exec 'knife cookbook upload --all'
    end

    task :roles do
      bundle_exec 'knife role from file roles/*.json'
    end

    task :databags do
      %w(ssh_keys users).each do |db|
        bundle_exec "knife data bag create #{db}"
        bundle_exec "knife data bag from file #{db} data_bags/#{db}"
      end
    end
  end

  namespace :clean do
    desc 'Delete artifacts on Chef server'
    task :all do
      Rake::Task['server:clean:cookbooks'].invoke
      Rake::Task['server:clean:roles'].invoke
      Rake::Task['server:clean:nodes'].invoke
    end

    task :cookbooks do
      sh 'knife cookbook bulk delete ".*" -py'
    end

    task :roles do
      sh 'knife role bulk delete ".*" -py'
    end

    task :nodes do
      sh 'knife node bulk delete ".*" -py'
    end

    task :databags do
      sh 'for db in `knife data bag list`; do knife data bag delete "$db" -y; done;'
    end
  end
end

namespace :test do
  task :jsonlint do
    bundle_exec 'jsonlint data_bags/**/*.json'
    bundle_exec 'jsonlint roles/*'
  end

  task :yamllint do
    # TODO: test yaml
  end

  task :cookstyle do
    bundle_exec 'cookstyle --except "Style/IndentHash" provisioning/'
  end
end

task default: ['test:jsonlint', 'test:cookstyle']
