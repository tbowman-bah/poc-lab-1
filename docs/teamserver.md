# Teamserver

[Forbidden](../provisioning/machines/recipes/forbidden.rb) is the teamserver of the lab.  
It contains two type of `teamserver`:

- The teamserver installed on the virtual machine itself, managed with `tmux`
- Teamservers manager with `docker` containers.

It is connected to the target network, and deploy arsenals to perform attacks on this network collaboratively

## Tmux script
To start the teamserver, execute the `ts` script at the `eliot`'s home directory:
```
ssh eliot@forbidden
./ts
```

It will start several services ready to use:

#### Msfrpc
Start Metasploit with msgrpc plugin.  

Port listening: `55554`  
Username: `msf`  
Password: `pentestlab`  

#### Armitage Teamserver
The `armitage` teamserver is started and connected to the `msfrpc` service.  

Port listening: `55553`  
Username: `msf`  
Password: `pentestlab`  

#### Mitmproxy
A reverse proxy is started for the metasploit rpc server, use it for your scripts.  

Port listening: `55554`  

#### SimpleHTTPServer
The `SimpleHttpServer` serve `~/.msf4/loot/` directory through vpn tunnel.  

Port listening: `4242`

## Docker teamservers

Teamservers can be added as docker services, See the [forbidden](../provisioning/machines/recipes/forbidden.rb) machine for examples.  
Each docker teamserver will deploy two containers: the `msfrpc` and the armitage `teamserver`.

#### Post teamserver

Msfrpc port: `51111`  
Teamserver port: `61111`  
Listener ports: `[9000-9009]`  

