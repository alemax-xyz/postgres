#!/bin/sh

test -f /var/lib/postgresql/PG_VERSION || sudo -u "$PUSER" -g "$PGROUP" initdb -D/var/lib/postgresql --auth-local=trust --auth-host=md5 --no-locale --pwfile=/etc/postgresql/pwfile

sudo -u "$PUSER" -g "$PGROUP" postgres -i -D/var/lib/postgresql
