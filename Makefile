override TARGETS = 13 14 15 16 17 18

TAG ?= clover/postgres
PLATFORM ?= linux/amd64,linux/arm64/v8,linux/ppc64le


all: ${TARGETS} latest

.PHONY: all ${TARGETS} latest

${TARGETS}:
	docker buildx build --progress plain --platform ${PLATFORM} -t ${TAG}:$@ $@ --push

latest:
	docker buildx build --progress plain --platform ${PLATFORM} -t ${TAG}:$@ $^ --push

latest: 18
