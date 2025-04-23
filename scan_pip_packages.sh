#!/bin/bash

tempdir=$(mktemp -d)
trap "rm -rf ~/.remove $tempdir" EXIT

# build docker image first
docker-compose build

# generate a script in tempdir to the scan
echo '
 # generate package list with dependencies
 ./get_dependencies.sh > approved-packages-dep.txt
 echo cat approved-packages-dep.txt
 cat approved-packages-dep.txt

 # scan using pip-audit
 pip-audit -v -r approved-packages-dep.txt

' > $tempdir/scan_pip_packages.sh

chmod ugo+rx $tempdir/scan_pip_packages.sh

# scan using devpi-server image by volume mounting above script
docker run \
     --rm \
     -v $tempdir/scan_pip_packages.sh:/tmp/scan_pip_packages.sh \
     --entrypoint "bash" devpi-server:latest "-x" "/tmp/scan_pip_packages.sh"

