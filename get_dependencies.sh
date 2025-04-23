#!/bin/bash

# set -x

tempdir=$(mktemp -d)
trap "rm -rf ~/.remove $tempdir" EXIT

python3 -m venv ~/.remove

pip install --dry-run --no-cache-dir --ignore-installed -r approved-packages.txt \
    | grep -i "Would install" | sed 's;Would install;;g' | sed 's; ;\n;g' >> $tempdir/temp_deps.txt

for package in $(sort -u $tempdir/temp_deps.txt) ; do
  echo "${package%-*}" | tr '[[:upper:]]' '[[:lower:]]' >> $tempdir/final_deps.txt
done

cat $tempdir/final_deps.txt approved-packages.txt | sort -u
