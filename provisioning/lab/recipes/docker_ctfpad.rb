# -*- coding: utf-8 -*-

dockerdir = "#{node['lab']['home']}/elite-stuff/dockerfiles/ctfpad"
if File.exist? "#{dockerdir}/Dockerfile"
  docker_image 'ctfpad' do
    action :build_if_missing
    repo 'ctfpad'
    tag 'latest'
    source dockerdir
    read_timeout 300
    write_timeout 300
  end

  docker_container 'ctfpad' do
    action :run_if_missing
    repo 'ctfpad'
    tag 'latest'
    port ['1234:1234', '1235:1235']
    volume ["#{node['lab']['home']}/ctfpad.sqlite:/CTFPad/ctfpad.sqlite",
            "#{dockerdir}/settings.json:/CTFPad/etherpad-lite/settings.json",
            "#{dockerdir}/config.json:/CTFPad/config.json",
           ]
  end
end
