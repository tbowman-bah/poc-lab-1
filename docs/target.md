# Pentestlab targets

## Prerequisites:
- neutron client (pip install python-neutronclient)
- nova client (pip install python-novaclient)
- heat client (pip install python-heatclient)

Get the router id from your Openstack provider and create a env file:

```yaml
parameter_defaults:
  router: <router_id>
```

## Create targets stack
Deploy the heat stack from template:
```
heat stack-create targets -e openstack/env.yml -f openstack/targets.hot
```

or with new cli:
```
openstack --os-cloud pentestlab stack create -e openstack/env.yml -t openstack/targets.hot targets
```

## Connect your kali to the target network:
Create a port on targeted network:
```
neutron port-create $(neutron net-list | grep "net-target " | cut -d" " -f2)
```

Get created port ID
Get server ID you want to attach (`nova list`)

Attach server:
```
nova interface-attach SERVERID --port-id PORTID
```

*Warn*: After created new ports on targets network, you will need to remove manually these ports if you want to destroy the stack.lab
```
nova interface-detach SERVERID PORTID
neutron port-delete PORTID
```
## Openstack images

TODO: Upload Openstack images
