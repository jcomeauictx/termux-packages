ANDROID_HOME ?= $(HOME)/Downloads/adt-bundle-linux-x86_64-20130717/sdk
export
# https://github.com/termux/termux-packages/wiki/Build-environment
all: scripts/run-docker.sh
	$< ./build-all.sh
/usr/bin/docker:
	sudo apt install docker.io
sdk:
	./scripts/setup-android-sdk.sh
