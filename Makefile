TERMUX_ARCH ?= arm
ANDROID_HOME ?= $(HOME)/lib/android-sdk
SDKMANAGER ?= $(ANDROID_HOME)/tools/bin/sdkmanager
export
# https://github.com/termux/termux-packages/wiki/Build-environment
all: scripts/run-docker.sh
	$< ./build-all.sh -a arm
/usr/bin/docker:
	sudo apt install docker.io
sdk:
	./scripts/setup-android-sdk.sh
docker: scripts/run-docker.sh
	$<
clean: scripts/run-docker.sh
	$< ./clean.sh  # doesn't seem to work
	scripts/update-docker.sh
env:
	$@
