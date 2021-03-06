# -*- coding: utf-8 -*-

dockerdir = "#{node['lab']['home']}/elite-stuff/dockerfiles/gitrob"
if File.exist? "#{dockerdir}/Dockerfile"
  docker_image 'gitrob' do
    action :build_if_missing
    repo 'gitrob'
    tag '1.1.0'
    source "#{dockerdir}/Dockerfile"
    read_timeout 300
    write_timeout 300
  end

  docker_container 'gitrob' do
    action :run_if_missing
    repo 'gitrob'
    tag '1.1.0'
    port '9393:9393'
    entrypoint '/usr/local/bundle/bin/gitrob'
    command 'server --bind-address 0.0.0.0'
    volumes ['/home/eliot/.gitrobrc:/root/.gitrobrc',
             '/home/eliot/.gitrobsignatures:/root/.gitrobsignatures',
            ]
  end
end
