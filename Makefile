.DEFAULT_GOAL := build

current_dir := $(dir $(abspath $(firstword $(MAKEFILE_LIST))))

build:
	sh ./build.sh
.PHONY: build

build-base:
	docker build -t hami-core-dev:base -f dockerfiles/Dockerfile.base .
.PHONY: build-base

build-in-docker: build-base
	docker run -i --rm \
		-v $(current_dir):/libvgpu \
		-w /libvgpu \
		-e DEBIAN_FRONTEND=noninteractive \
		hami-core-dev:base \
		sh -c "bash ./build.sh"
.PHONY: build-in-docker
