# check=skip=SecretsUsedInArgOrEnv

FROM clover/base AS base

RUN groupadd \
        --gid 50 \
        --system \
        postgres \
 && useradd \
        --home-dir /var/lib/postgresql \
        --no-create-home \
        --system \
        --shell /bin/false \
        --uid 50 \
        --gid 50 \
        postgres

FROM library/debian:stable-slim AS build

ENV LANG=C.UTF-8

RUN export DEBIAN_FRONTEND=noninteractive \
 && apt-get update

RUN export DEBIAN_FRONTEND=noninteractive \
 && echo "deb [trusted=yes] http://apt.postgresql.org/pub/repos/apt trixie-pgdg main" > /etc/apt/sources.list.d/postgresql.list \
 && apt-get update

RUN mkdir -p /build/image
WORKDIR /build

RUN apt-get download \
        libpq5 \
        liblz4-1 \
        libicu76 \
        libgssapi-krb5-2 \
        libxml2 \
        libldap2 \
        libkrb5-3 \
        libkrb5support0 \
        libkeyutils1 \
        libk5crypto3 \
        libcom-err2 \
        liblzma5 \
        libsasl2-2 \
        libsasl2-modules-db \
        libgnutls30t64 \
        libgmp10 \
        libhogweed6t64 \
        libidn2-0 \
        libnettle8t64 \
        libp11-kit0 \
        libtasn1-6 \
        libunistring5 \
        libffi8 \
        libgcrypt20 \
        libgpg-error0 \
        libuuid1 \
        libxxhash0 \
        postgresql-17 \
        postgresql-client-17

RUN for file in *.deb; do dpkg-deb -x ${file} image/; done

WORKDIR /build/image
RUN mkdir -p \
        usr/bin \
        etc/postgresql \
        var/lib/postgresql \
        run/postgresql \
 && echo postgres > etc/postgresql/pwfile \
 && find usr/lib/postgresql/17/bin/* | xargs -I % ln -s /% usr/bin/ \
 && rm -rf \
        usr/lib/postgresql/17/lib/pgxs/ \
        usr/share/doc \
        usr/share/libgcrypt20/ \
        usr/share/lintian \
        usr/share/locale \
        usr/share/man \
        usr/share/postgresql/17/man \
 && truncate -s0 usr/share/postgresql/17/*.sample

COPY --from=base /etc/group /etc/gshadow /etc/passwd /etc/shadow etc/
COPY etc/ etc/
COPY usr/ usr/

FROM clover/common

ENV PGDATA=/var/lib/postgresql \
    POSTGRES_INITDB_AUTH_HOST=md5 \
    POSTGRES_INITDB_AUTH_LOCAL=trust \
    POSTGRES_INITDB_PWFILE=/etc/postgresql/pwfile \
    POSTGRES_INITDB_USERNAME=postgres \
    POSTGRES_INITDB_NO_INSTRUCTIONS=1 \
    POSTGRES_LISTEN_HOST=* \
    POSTGRES_LISTEN_PORT=5432 \
    POSTGRES_MAX_CONNECT=128

WORKDIR /
COPY --from=build /build/image /

EXPOSE ${POSTGRES_LISTEN_PORT:-5432}
