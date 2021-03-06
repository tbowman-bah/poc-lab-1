# Services

There is several services configured on the lab:

## Gitrob
[Gitrob](https://github.com/michenriksen/gitrob) needs a github personal access token, create on on https://github.com and edit `gitrob` item of `pentester` data bag:
```
knife data bag edit pentester gitrob --secret-file .chef/encrypted_data_bag_secret
```
and update the `gh_auth_token` value.  

Gitrob is installed on [bliss](../provisioning/machines/recipes/bliss.rb). Get it's ip address (`tun0`) and access to the web interface through url `http://10.13.37.x:9393`.  
You should be able to create new assessments.

The `gitrob` service is managed by docker. If the service is not running, check the `gitrob` container is started:
```
docker ps
```
If not started, check if container exists and remove it, then rerun `chef-client`:
```
docker ps -a
docker rm CONTAINERID
sudo chef-client
```
Access to service's logs with:
```
docker logs CONTAINERID
```

Run Gitrob command with:
```
docker exec -it CONTAINERID gitrob help
docker exec -it CONTAINERID gitrob analyze --no-server <username>
```

## Faraday server
A [Faraday](https://github.com/infobyte/faraday) server is available on [bliss](../provisioning/machines/recipes/bliss.rb)  
It's ready to use, access to the web interface via url `http://10.13.37.x:5985/_ui`.

## CTFPad
A [CTFPad](https://github.com/StratumAuhuur/CTFPad) is also configured on [bliss](../provisioning/machines/recipes/bliss.rb), the service is managed with docker.  

Access to CTFPad: https://10.13.37.x:1234  
Access to Etherpad: https://10.13.37.x:1235  

## Teamservers
Teamservers are configured on the [forbidden](../provisioning/machines/recipes/forbidden.rb) machine.  
See doc file [Teamserver](teamserver.md) for detailed infos.

## BeEF Server
A [BeEF](https://github.com/beefproject/beef) server is up and running on the [forbidden](../provisioning/machines/recipes/forbidden.rb) machine.  

Access to the web panel: http://10.13.37.x:3000/ui/panel  
Hool URL: http://192.168.42.x:3000/hook.js

#### Known issue:
`bundle install` failed for `rainbow` gem - https://github.com/sickill/rainbow/issues/40  
Adding `gem 'rainbow', '= 2.1.0'` in the `Gemfile` can solve this issue.
