override POSTGRES_OLD_TARGETS = 8.2 8.3 8.4 9.0
override POSTGRES_NEW_TARGETS = 9.1 9.2 9.3 9.4 9.5 9.6 10 11 12 13 14 15 16

override POSTGRES_TARGETS = ${POSTGRES_OLD_TARGETS} ${POSTGRES_NEW_TARGETS}

all: ${POSTGRES_TARGETS} latest

.PHONY: all ${POSTGRES_TARGETS} latest

${POSTGRES_OLD_TARGETS}:
	docker buildx build --platform linux/amd64,linux/ppc64le,linux/s390x -t clover/postgres:$@ $@ --push

${POSTGRES_NEW_TARGETS}:
	docker buildx build --platform linux/amd64,linux/arm64/v8,linux/ppc64le,linux/s390x -t clover/postgres:$@ $@ --push

latest:
	docker buildx build --platform linux/amd64,linux/arm64/v8,linux/ppc64le,linux/s390x -t clover/php:$@ $^ --push

latest: 16
