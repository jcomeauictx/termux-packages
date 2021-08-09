#!/bin/sh
set -e -u

CONTAINER=termux-package-builder
IMAGE=termux/package-builder

sudo docker pull $IMAGE

LATEST=$(sudo docker inspect --format "{{.Id}}" $IMAGE)
RUNNING=$(sudo docker inspect --format "{{.Image}}" $CONTAINER)

if [ $LATEST = $RUNNING ]; then
	echo "Image '$IMAGE' used in the container '$CONTAINER' is already up to date"
else
	echo "Image '$IMAGE' used in the container '$CONTAINER' has been updated - removing the outdated container"
	sudo docker stop $CONTAINER
	sudo docker rm -f $CONTAINER
fi

