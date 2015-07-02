FROM fedora:22
MAINTAINER Tobias Florek tob@butter.sh

VOLUME ["/lib/modules:ro", "/etc/firewalld"]

RUN dnf --setopt=tsflags=nodocs -y install firewalld \
 && dnf clean all 

#ENTRYPOINT ["/sbin/firewalld", "--nofork", "--nopid"]
ENTRYPOINT ["/bin/firewall-cmd"]
CMD []

ADD install.sh uninstall.sh /bin/

LABEL INSTALL="docker run --rm --privileged --entrypoint /bin/sh -v /:/host -e HOST=/host -e LOGDIR=\${LOGDIR} -e CONFDIR=\${CONFDIR} -e DATADIR=\${DATADIR} -e IMAGE=IMAGE -e NAME=NAME IMAGE /bin/install.sh"

LABEL UNINSTALL="docker run --rm --privileged --entrypoint /bin/sh -v /:/host -e HOST=/host -e IMAGE=IMAGE -e NAME=NAME IMAGE /bin/uninstall.sh"

LABEL RUN="docker exec -n NAME"
