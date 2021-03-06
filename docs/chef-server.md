# Chef Server

## Pentestlab organization
Create the `pentestlab` organization and `pentester` user on the chef server. Copy the generated key to `secrets/pentester.pem`
```
chef-server-ctl org-create pentestlab "Pentestlab organization"
chef-server-ctl user-create pentester Pentester
chef-server-ctl org-user-add pentestlab pentester -a
```

## Encrypted private key
This key will be used to encrypt data bags and will be deployed on all nodes.
```
openssl rand -base64 2048 > .chef/encrypted_data_bag_secret
```

## Prepare data bags
### SSH Setup
All nodes will be configured with `eliot` user with authorized keys defined in `ssh_keys` data bag.
Create a data bag `data_bags/ssh_keys/h4x0r.json` and put SSH public keys that will be allowed to connect to the lab:
```
{
    "id": "h4x0r",
    "keys": [
        {
            "id": "my-id-rsa",
            "pub": "ssh-rsa AAAA.....",
            "priv": [""]
        },
        etc..
    ]
}
```

Define SSH keys for root user `data_bags/ssh_keys/root.json` (empty):
```
{
    "id": "root",
    "keys": []
}
```

Create an encrypted data bag for our lab user `eliot` with the knife command:
```
knife data bag create ssh_keys eliot --secret-file .chef/encrypted_data_bag_secret
```
And put the public and private SSH keys (generate a key pair if needed):
```
{
  "id": "eliot",
  "keys": [
    {
      "id": "id_rsa",
      "pub": "ssh-rsa AAAA...",
      "priv": [
        "-----BEGIN RSA PRIVATE KEY-----",
        "...",
        "-----END RSA PRIVATE KEY-----"
      ]
    }
  ]
}
```

### VPN Setup
The lab will be provisioned with an openvpn server.  
To generate client keys, you need to define each user in the `users` data bag. The node that includes the `openvpn-server` role will look for all item in this data bag and generate user's key & certificate to access to the vpn.  

To add an user, create `data_bags/users/name.json`:
```
{
    "id": "name"
}
```
That's all!

### Beef setup
Beef database is managed by encrypted data bag, create it with knife:
```
knife data bag create pentester beef --secret-file .chef/encrypted_data_bag_secret
```
With content like:
```
{
  "id": "beef",
  "db": {
    "db_user": "beef",
    "db_passwd": "beefpass",
    "db_name": "beef"
  }
}
```

### Gitrob setup
Gitrob database is managed by encrypted data bag:
```
knife data bag create pentester gitrob --secret-file .chef/encrypted_data_bag_secret
```
With:
```
{
  "id": "gitrob",
  "gh_auth_token": "your_github_auth_token",
  "db": {
    "user": "gitrob",
    "pass": "gitrob",
    "db": "gitrob"
  }
}
```

### Metasploit setup
Metasploit database is managed by encrypted data bag, create it with knife:
```
knife data bag create pentester msf --secret-file .chef/encrypted_data_bag_secret
```
And configure database:
```
{
  "id": "msf",
  "db": {
    "user": "msf",
    "pass": "msf",
    "db": "msf"
  }
}
```

### Etherpad setup
Etherpad database is managed by encrypted data bag like setup above:
```
knife data bag create lab etherpad --secret-file .chef/encrypted_data_bag_secret
```
with:
```
{
  "id": "etherpad",
  "db": {
    "user": "etherpad",
    "pass": "etherpad",
    "db": "etherpad"
  }
}
```

## Defaults data bags
All defaults data bags are located in `data_bags` directory, they should be uploaded during the [provisioning](provisioning.md) step.
