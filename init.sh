#!/bin/sh

test -z "$PUID" && PUID=50 || test "$PUID" -eq "$PUID" || exit 2
PUSER=$(getent passwd $PUID | cut -d: -f1)
if [ -z "$PUSER" ]; then
    PUSER=$(getent passwd 50 | cut -d: -f1) && usermod --uid $PUID "$PUSER" || exit 2
fi

test -z "$PGID" && PGID=$(id -g "$PUSER") || test "$PGID" -eq "$PGID" || exit 2
PGROUP=$(getent group $PGID | cut -d: -f1)
if [ -z "$PGROUP" ]; then
    PGROUP=$(id -gn "$PUSER")
    groupmod --gid $PGID "$PGROUP" || exit 2
else
    test $(id -g "$PUSER") -eq $PGID || usermod --gid $PGID "$PUSER" || exit 2
fi

chown $PUID:$PGID /var/lib/postgresql /var/run/postgresql || exit 2
chmod 0700 /var/lib/postgresql || exit 2

test -f /var/lib/postgresql/PG_VERSION || sudo -u "$PUSER" -g "$PGROUP" initdb -D/var/lib/postgresql --auth-local=trust --auth-host=md5 --no-locale --pwfile=/etc/postgresql/pwfile

trap 'killall -INT -u postgres postgres; wait $PID' INT
sudo -u "$PUSER" -g "$PGROUP" postgres -i -D/var/lib/postgresql &
PID=$!
wait $PID
