#!/bin/bash

# set the certs
export SSL_CERT_FILE=/etc/ssl/certs/ca-certificates.crt
export REQUESTS_CA_BUNDLE=$SSL_CERT_FILE

# Initialize devpi-server if not already initialized
devpi-init --serverdir /data

# Start devpi-server in the background
devpi-server --host 0.0.0.0 --port 3141 --serverdir /data &

BASE_URL=http://localhost:3141

# Wait for server to be ready
until curl -s "$BASE_URL"; do
  echo "Waiting for devpi-server..."
  sleep 2
done

# Use root and set password
devpi use "$BASE_URL"
devpi login root --password=''
devpi user -m root password=admin

# create private user
devpi user -c private password=private123

# Login as root
devpi login root --password=admin

# Create isolated index to have constraints
INDEX_NAME="private/mirror"
devpi index -c "$INDEX_NAME" type=constrained bases=root/pypi

# update whitelist
./get_dependencies.sh > approved-packages-dep.txt
echo cat approved-packages-dep.txt
cat approved-packages-dep.txt
devpi index $INDEX_NAME constraints="$(cat approved-packages-dep.txt)"
devpi index $INDEX_NAME constraints+="*"

# Bring server to foreground
wait

