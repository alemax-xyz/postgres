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

FROM library/ubuntu:bionic AS build

ENV LANG=C.UTF-8

RUN export DEBIAN_FRONTEND=noninteractive \
 && apt-get update \
 && apt-get install -y \
        software-properties-common \
        apt-utils

RUN mkdir -p /build /rootfs
WORKDIR /build
RUN export DEBIAN_FRONTEND=noninteractive \
 && apt-get download \
        libedit2 \
        libgpg-error0 \
        libcom-err2 \
        libcomerr2 \
        libsqlite3-0 \
        libkeyutils1 \
        libk5crypto3 \
        libkrb5-3 \
        libkrb5support0 \
        libgmp10 \
        libhogweed4 \
        libidn2-0 \
        libnettle6 \
        libffi6 \
        libp11-kit0 \
        libtasn1-6 \
        libunistring2 \
        libgnutls30 \
        libasn1-8-heimdal \
        libhcrypto4-heimdal \
        libheimntlm0-heimdal \
        libheimbase1-heimdal \
        libhx509-5-heimdal \
        libwind0-heimdal \
        libkrb5-26-heimdal \
        libroken18-heimdal \
        libgssapi3-heimdal \
        libsasl2-modules-db \
        libsasl2-2 \
        liblzma5 \
        liblz4-1 \
        libgcrypt20 \
        libgssapi-krb5-2 \
        libicu60 \
        libldap-2.4-2 \
        libldap-common \
        libpq5 \
        libsystemd0 \
        libuuid1 \
        libxml2 \
        libxslt1.1 \
#        locales \
        postgresql-10 \
        postgresql-client-10
RUN find *.deb | xargs -I % dpkg-deb -x % /rootfs

WORKDIR /rootfs
COPY pg_hba.conf.sample usr/share/postgresql/10/
RUN mkdir -p \
        usr/bin \
        etc/postgresql \
        var/lib/postgresql \
        run/postgresql \
 && echo postgres > etc/postgresql/pwfile \
 && find usr/lib/postgresql/10/bin/* | xargs -I % ln -s /% usr/bin/ \
 && rm -rf \
#        usr/sbin/locale-gen \
#        usr/sbin/update-locale \
#        usr/sbin/validlocale \
#        usr/share/locales \
        usr/share/bug \
        usr/share/doc \
        usr/share/lintian \
        usr/share/man \
        usr/share/postgresql/10/man

COPY --from=base /etc/group /etc/gshadow /etc/passwd /etc/shadow etc/
COPY init.sh etc/

WORKDIR /


FROM clover/common

ENV LANG=C.UTF-8
ENV PAGER=

STOPSIGNAL SIGINT

COPY --from=build /rootfs /

VOLUME ["/var/lib/postgresql"]

CMD ["sh", "/etc/init.sh"]

EXPOSE 5432
