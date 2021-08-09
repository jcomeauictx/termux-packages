#!/bin/sh
set -e -u

HOME=/home/builder
UNAME=$(uname)
if [ "$UNAME" = Darwin ]; then
	# Workaround for mac readlink not supporting -f.
	REPOROOT=$PWD
else
	REPOROOT="$(dirname $(readlink -f $0))/../"
fi

: ${TERMUX_BUILDER_IMAGE_NAME:=termux/package-builder}
: ${CONTAINER_NAME:=termux-package-builder}

USER=builder

echo "Running container '$CONTAINER_NAME' from image '$TERMUX_BUILDER_IMAGE_NAME'..."

sudo docker start $CONTAINER_NAME > /dev/null 2> /dev/null || {
	echo "Creating new container..."
	sudo docker run \
		--detach \
		--name $CONTAINER_NAME \
		--volume $REPOROOT:$HOME/termux-packages \
		--tty \
		$TERMUX_BUILDER_IMAGE_NAME
    if [ "$UNAME" != Darwin ]; then
	if [ $(id -u) -ne 1000 -a $(id -u) -ne 0 ]
	then
		echo "Changed builder uid/gid... (this may take a while)"
		sudo docker exec --tty $CONTAINER_NAME sudo chown -R $(id -u) $HOME
		sudo docker exec --tty $CONTAINER_NAME sudo chown -R $(id -u) /data
		sudo docker exec --tty $CONTAINER_NAME sudo usermod -u $(id -u) builder
		sudo docker exec --tty $CONTAINER_NAME sudo groupmod -g $(id -g) builder
	fi
    fi
}

if [ "$#" -eq  "0" ]; then
	sudo docker exec --interactive --tty $CONTAINER_NAME bash
else
	sudo docker exec --interactive --tty $CONTAINER_NAME $@
fi


