#!/bin/sh
usermod -u ${PUID} grafana
groupmod -g ${PGID} grafana
su -s /bin/bash -c '/usr/sbin/grafana-server -config /etc/grafana/grafana.ini' grafana