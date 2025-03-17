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
 && apt-get update \
 && apt-get install -y \
        --no-install-recommends \
        software-properties-common \
        apt-utils

RUN export DEBIAN_FRONTEND=noninteractive \
 && apt-get install -y \
        wget

RUN export DEBIAN_FRONTEND=noninteractive \
 && echo "deb [trusted=yes] https://apt.postgresql.org/pub/repos/apt bookworm-pgdg main" > /etc/apt/sources.list.d/postgresql.list \
 && apt-get update

RUN mkdir -p /build/image
WORKDIR /build

RUN apt-get download \
        libpq5 \
        libzstd1 \
        liblz4-1 \
        libicu72 \
        libgssapi-krb5-2 \
        libxml2 \
        libldap-2.5-0 \
        libkrb5-3 \
        libkrb5support0 \
        libkeyutils1 \
        libk5crypto3 \
        libssl3 \
        libsystemd0 \
        libcom-err2 \
        liblzma5 \
        libsasl2-2 \
        libsasl2-modules-db \
        libgnutls30 \
        libgmp10 \
        libhogweed6 \
        libidn2-0 \
        libnettle8 \
        libp11-kit0 \
        libtasn1-6 \
        libunistring2 \
        libffi8 \
        libgcrypt20 \
        libgpg-error0 \
        libuuid1 \
        postgresql-9.1 \
        postgresql-client-9.1

RUN for file in *.deb; do dpkg-deb -x ${file} image/; done

WORKDIR /build/image
RUN mkdir -p \
        usr/bin \
        etc/postgresql \
        var/lib/postgresql \
        run/postgresql \
 && echo postgres > etc/postgresql/pwfile \
 && find usr/lib/postgresql/9.1/bin/* | xargs -I % ln -s /% usr/bin/ \
 && rm -rf \
        usr/lib/postgresql/9.1/lib/pgxs/ \
        usr/share/doc \
        usr/share/libgcrypt20/ \
        usr/share/lintian \
        usr/share/locale \
        usr/share/man \
        usr/share/postgresql/9.1/man \
 && truncate -s0 usr/share/postgresql/9.1/*.sample

COPY --from=base /etc/group /etc/gshadow /etc/passwd /etc/shadow etc/
COPY init/ etc/init/
COPY pg_hba.conf.sample usr/share/postgresql/9.1/

FROM clover/common

WORKDIR /
COPY --from=build /build/image /

VOLUME ["/var/lib/postgresql"]

EXPOSE 5432
