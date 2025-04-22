#!/bin/bash

# set -x

tempdir=$(mktemp -d)
trap "rm -rf ~/.remove $tempdir" EXIT

python3 -m venv ~/.remove

for package in $(cat approved-packages.txt) ; do
  pip install $package --dry-run --no-cache-dir --ignore-installed | grep -i "Would install" | sed 's;Would install;;g' | sed 's; ;\n;g' >> $tempdir/temp_deps.txt
done

for package in $(sort -u $tempdir/temp_deps.txt) ; do
  echo "${package%-*}" | tr '[[:upper:]]' '[[:lower:]]' >> $tempdir/final_deps.txt
done

sort -u $tempdir/final_deps.txt 
