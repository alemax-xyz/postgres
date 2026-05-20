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

ENV LANG=C.UTF-8 \
    SANDBOX_ROOT=/

RUN export DEBIAN_FRONTEND=noninteractive \
 && apt-get update \
 && apt-get install -y wget openssl ca-certificates

ADD https://github.com/alemax-xyz/misc-tools.git#main /usr/local/bin/

RUN mkdir -p /build /rootfs

WORKDIR /build

COPY build/ .

COPY --from=clover/common:latest /var/lib/packages/ var/lib/packages/

RUN apt-sandbox --install --verstamp \
        --apt-config \
            APT::Install-Recommends=false \
            APT::Get::Upgrade==false \
        --repository . \
        --keyring . \
        --installed var/lib/packages \
        --obsolete packages.obsolete \
        --required packages.required

WORKDIR /rootfs

RUN mkdir -p \
        usr/bin \
        etc/postgresql \
        var/lib/postgresql \
        run/postgresql \
 && echo postgres > etc/postgresql/pwfile \
 && find usr/lib/postgresql/16/bin/* | xargs -I % ln -s /% usr/bin/ \
 && rm -rf \
        usr/lib/postgresql/16/lib/pgxs/ \
        usr/share/doc \
        usr/share/libgcrypt20/ \
        usr/share/lintian \
        usr/share/locale \
        usr/share/man \
        usr/share/postgresql/16/man \
 && truncate -s0 usr/share/postgresql/16/*.sample

COPY --from=base /etc/group /etc/gshadow /etc/passwd /etc/shadow etc/
COPY rootfs/ .

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

COPY --from=build /rootfs /

EXPOSE ${POSTGRES_LISTEN_PORT:-5432}
