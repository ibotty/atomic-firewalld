#!/bin/sh
chroot "${HOST}" /usr/bin/systemctl disable /etc/systemd/system/firewalld.service
rm -f ${HOST}/etc/systemd/system/firewalld.service
