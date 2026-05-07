## PostGRE SQL docker image

The world's most advanced open source object-relational database system

This image is based on official postgresql package for Ubuntu and is built on top of [clover/common](https://hub.docker.com/r/clover/common/).

### Enviroment variables

| Name | Default value | Description
| ---- | ------------- | -----------
| `PUID` | _not set_ | desired user id of the process owner
| `PGID` | _not set_ | desired group id of the process pwner (primary group of the `PUID` user)
| `PUSER` | _not set_ | desired `PUID` user name
| `PGROUP` | _not set_ | desired `PGID` group name
| `CHOWN` | _not set_ | space-separated list of directories to change ownership to `PUID`/`PGID` during container startup
| `CRON` | _not set_ (`0`) | will start _cron_ inside the container if set to `1`
| `TZ` / `TIMEZONE` | _not set_ (`UTC`) | desired container timezone
| `PGDATA` | `/var/lib/postgresql` | location for the database cluster (data directory)
| `POSTGRES_INITDB_AUTH` | _not set_ | default authentication method for local connections
| `POSTGRES_INITDB_AUTH_HOST` | `md5` (<=`17`), `scram-sha-256` (=`17`) | default authentication method for local TCP/IP connections
| `POSTGRES_INITDB_AUTH_LOCAL` | `trust` |  default authentication method for local-socket connections
| `POSTGRES_INITDB_ENCODING` | _not set_ (`UTF8`) | default encoding for new databases
| `POSTGRES_INITDB_ALLOW_GROUP_ACCESS` | _not set_ (`0`) | allow group read/execute on data directory
| `POSTGRES_INITDB_ICU_LOCALE` (>=15) | _not set_ | ICU locale for new databases
| `POSTGRES_INITDB_ICU_RULES` (>=16) | _not set_ | additional ICU collation rules for new databases
| `POSTGRES_INITDB_LOCALE` | _not set_ (`C.UTF-8`) | default locale for new databases
| `POSTGRES_INITDB_LC_COLLATE` | _not set_ | default locale for collate category
| `POSTGRES_INITDB_LC_CTYPE` | _not set_ | default locale for ctype category
| `POSTGRES_INITDB_LC_MESSAGES` | _not set_ | default locale for messages category
| `POSTGRES_INITDB_LC_MONETARY` | _not set_ | default locale for monetary category
| `POSTGRES_INITDB_LC_NUMERIC` | _not set_ | default locale for numeric category
| `POSTGRES_INITDB_LC_TIME` | _not set_ | default locale for time category
| `POSTGRES_INITDB_BUILTIN_LOCALE` (>=`17`) | _not set_ | builtin locale name for new databases
| `POSTGRES_INITDB_LOCALE_PROVIDER` (>=`15`) | _not set_ | default locale provider for new databases (`libc`|`icu`), (`builtin`|`libc`|`icu`) >=17
| `POSTGRES_INITDB_PWFILE` | `/etc/postgresql/pwfile` | password file for the new superuser
| `POSTGRES_INITDB_TEXT_SEARCH_CONFIG` | _not set_ (`english`) | default text search configuration
| `POSTGRES_INITDB_USERNAME` | `postgres` | database superuser name
| `POSTGRES_INITDB_WALDIR` | _not set_ (`{PGDATA}/pg_wal/`) | location for the write-ahead log directory
| `POSTGRES_INITDB_WAL_SEGSIZE` | _not set_ | size of WAL segments (in megabytes)
| `POSTGRES_INITDB_OPTIONS` | _not set_ | space separated list of default settings for server parameters in `KEY=VALUE` format
| `POSTGRES_INITDB_DEBUG` | _not set_ | generate lots of debugging output
| `POSTGRES_INITDB_DISCARD_CACHES` | _not set_ | set `debug_discard_caches=1`
| `POSTGRES_INITDB_DATA_CHECKSUMS` | _not set_ | use data page checksums
| `POSTGRES_INITDB_SAMPLE_DIR` | _not set_ (`/usr/share/postgresql/{version}`) | where to find the input files
| `POSTGRES_INITDB_NO_CLEAN` | _not set_ | do not clean up after errors
| `POSTGRES_INITDB_NO_SYNC` | _not set_ | do not wait for changes to be written safely to disk
| `POSTGRES_INITDB_NO_SYNC_DATA_FILES` (>=`17`) | _not set_ | do not sync files within database directories
| `POSTGRES_INITDB_NO_INSTRUCTIONS` (>=`14`) | `1` |  do not print instructions for next steps
| `POSTGRES_INITDB_SYNC_METHOD` (>=`17`) | _not set_ | set method for syncing files to disk (`fsync`|`fdatasync`|`open_sync`|`open_datasync`) _*_
| `POSTGRES_SHARED_BUFFERS` | _not set_ | number of shared buffers
| `POSTGRES_OPTIONS` | _not set_ | space separated list of runtime server parameters in `KEY=VALUE` format
| `POSTGRES_DEBUG_LEVEL` | _not set_ | debugging level (`1` .. `5`)
| `POSTGRES_EUROPIAN_DATE` | _not set_ | use European date input format (`DMY`)
| `POSTGRES_NO_FSYNC` | _not set_ | turn fsync off
| `POSTGRES_LISTEN_HOST` | `*` | host name or IP address to listen on
| `POSTGRES_TCP` | _not set_ | enable TCP/IP connections (deprecated)
| `POSTGRES_SOCKET_DIR` | _not set_ | Unix-domain socket location
| `POSTGRES_SSL` | _not set_ | enable SSL connections
| `POSTGRES_MAX_CONNECT` | `128` | maximum number of allowed connections
| `POSTGRES_LISTEN_PORT` | `5432` | port number to listen on
| `POSTGRES_STATS` | _not set_ | show statistics after each query
| `POSTGRES_WORK_MEM` | _not set_ | set amount of memory for sorts (in kilobytes)
| `POSTGRES_FORBID_PLAN_TYPES` (>=`14`) | _not set_ | forbid use of some plan types [`siobtnmh`] _**_
| `POSTGRES_NO_SHM_REINIT` (>=`14`) | _not set_ | 
| `POSTGRES_NO_SYS_TABLE_PROTECTION` (>=`14`) | _not set_ | allow system table structure changes
| `POSTGRES_NO_SYS_INDEXES` (>=`14`) | _not set_ | disable system indexes
| `POSTGRES_QUERY_STATS` (>=`14`) | _not set_ | show timings after each query (`pa`|`pl`|`ex`) _***_
| `POSTGRES_STOP_BACKENDS` (>=`14`) | _not set_ | send `SIGSTOP` (<=`16`) / `SIGABRT` (>=`17`) to all backend processes if one dies
| `POSTGRES_WAIT_SEC` (>=`14`) | _not set_ | wait NUM seconds to allow attach from a debugger

#### _*_ `POSTGRES_INITDB_SYNC_METHOD` (>=`17`) - set method for syncing files to disk

One of the following:

 * `fsync` - write normally, then `fsync()` (default)
 * `fdatasync` - write normally, then `fdatasync()`
 * `open_sync` - open file with `O_SYNC`
 * `open_datasync` - open file with `O_DSYNC`

#### _**_ `POSTGRES_FORBID_PLAN_TYPES` (>=`14`) - forbid use of some plan types

Any combination of the following:

 * `s` - sequential scan
 * `i` - index scan
 * `o` - index-only scan
 * `b` - bitmap index scan
 * `t` - tuple ID scan
 * `n` - nested loop joins
 * `m` - merge joins
 * `h` - hash joins

#### _***_ `POSTGRES_QUERY_STATS` (>=`14`) - show timings after each query

One of the following:

 * `pa` - parse/plan/execution timing (aggregate-style reporting)
 * `pl` - per-phase (parse + plan + execution breakdown)
 * `ex` - execution-only timing


### Supported platforms

 * `linux/amd64`;
 * `linux/arm64/v8`;
 * `linux/ppc64le`;
