[ -z "$PGDATA" ] && PGDATA="/var/lib/postgresql"

[ -e "$PGDATA" ] || suexec mkdir -p "$PGDATA" || exit $?
suexec chown -R $PUID:$PGID "$PGDATA" /var/run/postgresql && suexec chmod 0700 "$PGDATA" || exit $?

export PGDATA

su -p -s /bin/sh -c 'cat > /etc/environment.d/99-postgres.conf' <<-EOF
	PGDATA="$PGDATA"
EOF
