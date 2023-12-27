#!/bin/sh

chown -R $PUID:$PGID /var/lib/postgresql /var/run/postgresql || exit 2
chmod 0700 /var/lib/postgresql || exit 2
