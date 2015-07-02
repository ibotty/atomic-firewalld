#!/bin/sh

if [ ! -d ${HOST}/etc/firewalld ] ; then
  mkdir ${HOST}/etc/firewalld
  cp -a /etc/firewalld ${HOST}/etc/firewalld
  chroot ${HOST} restorecon -R /etc/firewalld
fi

cat <<EOF > ${HOST}/etc/systemd/system/firewalld.service
[Unit]
Description=FirewallD running in ${NAME}
After=docker.service

[Service]
ExecStart=/usr/bin/docker run -d --rm --privileged --net=host -v /lib/modules:/lib/modules:ro -v /etc/firewalld:/etc/firewalld --name ${NAME} --entrypoint /sbin/firewalld --no-fork
ExecReload=/usr/bin/docker exec -t ${NAME} /bin/sh -c '/bin/kill -HUP \$(cat /run/firewalld.pid)'

[Install]
WantedBy=multi-user.target
EOF
