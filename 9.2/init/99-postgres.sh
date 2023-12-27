#!/bin/sh

test -f /var/lib/postgresql/PG_VERSION || \
	sudo -u "$PUSER" -g "$PGROUP" initdb \
		-D/var/lib/postgresql \
		--auth-local=trust \
		--auth-host=md5 \
		--pwfile=/etc/postgresql/pwfile

exec sudo -u "$PUSER" -g "$PGROUP" postgres \
	-h'*' \
	-N ${POSTGRES_MAX_CONNECTIONS:-128} \
	-D/var/lib/postgresql
