[ -f "$PGDATA/PG_VERSION" ] || {
	set -- initdb
	[ -n "$POSTGRES_INITDB_AUTH" ] && set -- "$@" --auth="$POSTGRES_INITDB_AUTH"
	[ -n "$POSTGRES_INITDB_AUTH_HOST" ] && set -- "$@" --auth-host="$POSTGRES_INITDB_AUTH_HOST"
	[ -n "$POSTGRES_INITDB_AUTH_LOCAL" ] && set -- "$@" --auth-local="$POSTGRES_INITDB_AUTH_LOCAL"
	[ -n "$POSTGRES_INITDB_ENCODING" ] && set -- "$@" --encoding="$POSTGRES_INITDB_ENCODING"
	[ "$POSTGRES_INITDB_ALLOW_GROUP_ACCESS" = 1 ] && set -- "$@" --allow-group-access
	[ -n "$POSTGRES_INITDB_ICU_LOCALE" ] && set -- "$@" --icu-locale="$POSTGRES_INITDB_ICU_LOCALE"
	[ -n "$POSTGRES_INITDB_ICU_RULES" ] && set -- "$@" --icu-rules="$POSTGRES_INITDB_ICU_RULES"
	[ -n "$POSTGRES_INITDB_LOCALE" ] && set -- "$@" --locale="$POSTGRES_INITDB_LOCALE"
	[ -n "$POSTGRES_INITDB_LC_COLLATE" ] && set -- "$@" --lc-collate="$POSTGRES_INITDB_LC_COLLATE"
	[ -n "$POSTGRES_INITDB_LC_CTYPE" ] && set -- "$@" --lc-ctype="$POSTGRES_INITDB_LC_CTYPE"
	[ -n "$POSTGRES_INITDB_LC_MESSAGES" ] && set -- "$@" --lc-messages="$POSTGRES_INITDB_LC_MESSAGES"
	[ -n "$POSTGRES_INITDB_LC_MONETARY" ] && set -- "$@" --lc-monetary="$POSTGRES_INITDB_LC_MONETARY"
	[ -n "$POSTGRES_INITDB_LC_NUMERIC" ] && set -- "$@" --lc-numeric="$POSTGRES_INITDB_LC_NUMERIC"
	[ -n "$POSTGRES_INITDB_LC_TIME" ] && set -- "$@" --lc-time="$POSTGRES_INITDB_LC_TIME"
	[ -n "$POSTGRES_INITDB_LOCALE_PROVIDER" ] && set -- "$@" --locale-provider="$POSTGRES_INITDB_LOCALE_PROVIDER"
	[ -n "$POSTGRES_INITDB_PWFILE" ] && set -- "$@" --pwfile="$POSTGRES_INITDB_PWFILE"
	[ -n "$POSTGRES_INITDB_TEXT_SEARCH_CONFIG" ] && set -- "$@" --text-search-config="$POSTGRES_INITDB_TEXT_SEARCH_CONFIG"
	[ -n "$POSTGRES_INITDB_USERNAME" ] && set -- "$@" --username="$POSTGRES_INITDB_USERNAME"
	[ -n "$POSTGRES_INITDB_WALDIR" ] && set -- "$@" --waldir="$POSTGRES_INITDB_WALDIR"
	[ -n "$POSTGRES_INITDB_WAL_SEGSIZE" ] && set -- "$@" --wal-segsize="$POSTGRES_INITDB_WAL_SEGSIZE"
	[ "$POSTGRES_INITDB_DEBUG" = 1 ] && set -- "$@" --debug
	[ "$POSTGRES_INITDB_DISCARD_CACHES" = 1 ] && set -- "$@" --discard-caches
	[ "$POSTGRES_INITDB_DATA_CHECKSUMS" = 1 ] && set -- "$@" --data-checksums
	[ -n "$POSTGRES_INITDB_SAMPLE_DIR" ] && set -- "$@" -L "$POSTGRES_INITDB_SAMPLE_DIR"
	[ "$POSTGRES_INITDB_NO_CLEAN" = 1 ] && set -- "$@" --no-clean
	[ "$POSTGRES_INITDB_NO_SYNC" = 1 ] && set -- "$@" --no-sync
	[ "$POSTGRES_INITDB_NO_INSTRUCTIONS" = 1 ] && set -- "$@" --no-instructions
	for OPTION in $POSTGRES_INITDB_OPTIONS; do set -- "$@" -c "$OPTION"; done

	suexec sudo -E -u "$PUSER" -g "$PGROUP" "$@" || exit $?
}

set -- postgres
[ -n "$POSTGRES_SHARED_BUFFERS" ] && set -- "$@" -B "$POSTGRES_SHARED_BUFFERS"
[ -n "$POSTGRES_DEBUG_LEVEL" ] && set -- "$@" -d "$POSTGRES_DEBUG_LEVEL"
[ "$POSTGRES_EUROPIAN_DATE" = 1 ] && set -- "$@" -e
[ "$POSTGRES_NO_FSYNC" = 1 ] && set -- "$@" -F
[ -n "$POSTGRES_LISTEN_HOST" ] && set -- "$@" -h "$POSTGRES_LISTEN_HOST"
[ "$POSTGRES_TCP" = 1 ] && set -- "$@" -i
[ -n "$POSTGRES_SOCKET_DIR" ] && set -- "$@" -k "$POSTGRES_SOCKET_DIR"
[ "$POSTGRES_SSL" = 1 ] && set -- "$@" -l
[ -n "$POSTGRES_MAX_CONNECT" ] && set -- "$@" -N "$POSTGRES_MAX_CONNECT"
[ -n "$POSTGRES_LISTEN_PORT" ] && set -- "$@" -p "$POSTGRES_LISTEN_PORT"
[ "$POSTGRES_STATS" = 1 ] && set -- "$@" -s
[ -n "$POSTGRES_WORK_MEM" ] && set -- "$@" -S "$POSTGRES_WORK_MEM"
[ -n "$POSTGRES_FORBID_PLAN_TYPES" ] && set -- "$@" -f "$POSTGRES_FORBID_PLAN_TYPES"
[ "$POSTGRES_NO_SHM_REINIT" = 1 ] && set -- "$@" -n
[ "$POSTGRES_NO_SYS_TABLE_PROTECTION" = 1 ] && set -- "$@" -O
[ "$POSTGRES_NO_SYS_INDEXES" = 1 ] && set -- "$@" -P
[ -n "$POSTGRES_QUERY_STATS" ] && set -- "$@" -t "$POSTGRES_QUERY_STATS"
[ "$POSTGRES_STOP_BACKENDS" = 1 ] && set -- "$@" -T
[ -n "$POSTGRES_WAIT_SEC" ] && set -- "$@" -W "$POSTGRES_WAIT_SEC"
for OPTION in $POSTGRES_OPTIONS; do set -- "$@" -c "$OPTION"; done

suexec sudo -E -u "$PUSER" -g "$PGROUP" "$@" &
