#!/bin/bash

if [[ `id -u` != 0 ]]; then
    echo "You must run this as root"
    exit 1
fi

read -p 'OVF Tool location: ' OVFTOOL_LOCATION
echo 'export OVFTOOL_LOCATION='$OVFTOOL_LOCATION

read -p 'Container Version: ' VERSION
echo 'export VERSION='$VERSION

docker build --build-arg=OVF=${OVFTOOL_LOCATION} \
            --build-arg=VERSION="${VERSION}" \
            -t vmware-automation-container:${VERSION} \
            -f Dockerfile .
