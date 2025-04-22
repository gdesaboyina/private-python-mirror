#!/bin/bash

tempdir=$(mktemp -d)
trap "rm -rf ~/.remove $tempdir" EXIT

echo '
    # generate package list with dependencies
    ./get_dependencies.sh > approved-packages-dep.txt
    echo cat approved-packages-dep.txt
    cat approved-packages-dep.txt

    # scan using pip-audit
    pip-audit -v -r approved-packages-dep.txt

' > $tempdir/scan_pip_packages.sh

# scan using devpi-server
docker run \
     --rm \
     -v $tempdir/scan_pip_packages.sh:/scan_pip_packages.sh \
     --entrypoint "/scan_pip_packages.sh"
     devpi-server:latest

