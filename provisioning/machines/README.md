# Pentestlab machines

This cookbook define Chef machines to build your lab.
It is intended to provision only databases, teamservers, and other tools for your pentesting tasks.

## Seeds
[seeds](recipes/seeds.rb) is the workstation, it is used for [provisioning](../../docs/provisioning.md) step.  
It also serve a VPN server with openvpn, all others nodes are configured as vpn clients.

## Buds
[buds](recipes/buds.rb) is the database, it contains actually a postgresql & couchdb servers.

## Bliss
[bliss](recipes/bliss.rb) contains some tools for collaboration tasks such as a `faraday-server`, `gitrob`.

## Forbidden
[forbidden](recipes/forbidden.rb) is the `teamserver`, it is connected to the target network and contains some services for offensive tasks like the msfrpc, armitage teamserver, BeEF server etc..  
See [targets doc](../../docs/target.md) to deploy targets.

## Kanga
[kanga](recipes/kanga.rb) is a Kali linux pre-confiured with the `teamserver`.

