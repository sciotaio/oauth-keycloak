#!/usr/bin/env bash
/opt/opendj/bin/start-ds
/opt/opendj/bin/export-ldif -h localhost -l /opt/opendj/bak/opendj_userRoot.ldif -n userRoot -D "$ROOT_USER_DN" -w "$ROOT_PASSWORD" --recurringTask "0 2 * * *"
while ! tail -F /opt/opendj/logs/access >& 1; do sleep 1 ; done
