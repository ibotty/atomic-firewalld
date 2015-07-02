# FirewallD for (bare metal) atomic hosts

[![Docker
Status](https://dockeri.co/image/ibotty/firewalld)](https://registry.hub.docker.com/u/ibotty/firewalld/)

Atomic hosts do not support traditional installation of additional software
with e.g. rpm. That privileged docker container is meant to be run on system
startup (via a systemd unit) and support FirewallD for the docker host.

It uses FirewallD from the fedora 22 repository.


## Installation (broken, for now)

Run the following command to set up the config files and systemd unit.
Unfortunately the Systemd unit will not start the container. See below on how
to fix that.

```shell
atomic run ibotty/firewalld
```

If you don't run atomic but are certain you want to run FirewallD inside of a
container you can run the install script manually. This command is the same as
in the `LABEL INSTALL` in the Dockerfile.

```shell
docker run --rm --privileged --entrypoint /bin/sh -v /:/host \
  -e HOST=/host -e IMAGE=firewalld -e NAME=firewalld \
  ibotty/firewalld /bin/install.sh
```

## Fix broken systemd unit

Fix up the `Exec*` lines in `/etc/systemd/system/firewalld.service`.


## Configuration

The configuration is on the host of `/etc/firewalld`, but you will rarely need
to use it.

