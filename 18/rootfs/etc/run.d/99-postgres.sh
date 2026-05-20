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
