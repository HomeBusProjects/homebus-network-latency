# homebus-network-latency


![rspec](https://github.com/romkey/homebus-network-latency/actions/workflows/rspec.yml/badge.svg)

Reports network latency.

## Usage

On its first run, `homebus-network-latency` needs to know how to find the Homebus provisioning server.

```
bin/homebus-network-latency -b homebus-server-IP-or-domain-name -P homebus-server-port username [password]
```

The port will usually be 80 (its default value). The server will default to homebus.io

Once it's provisioned it stores its provisioning information in `.homebus.json`. This file should be protected; the auth token in it will allow devices to join your network.

## Configuration

The `.env` file contains one line which lists the IP addresses or names of the devices to ping, separated by spaces.
```
HOSTS = host1 host2 host3
```


# LICENSE

Licensed under the [MIT License](https://mit-license.org).

