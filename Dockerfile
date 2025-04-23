FROM python:3.13

LABEL maintainer="Gopi Desaboyina"

# Install system dependencies
RUN apt-get update && apt-get install -y curl bash yq && rm -rf /var/lib/apt/lists/*

# Install Self Signed Certs
# COPY *.crt /usr/local/share/ca-certificates/
# RUN update-ca-certificates

# set env variables
ENV SSL_CERT_FILE /etc/ssl/certs/ca-certificates.crt
ENV REQUESTS_CA_BUNDLE /etc/ssl/certs/ca-certificates.crt

# purge cache
RUN pip3 cache purge

# Install devpi-server and devpi-client
RUN pip3 install devpi-server devpi-client pyyaml devpi-constrained certifi pip-audit setuptools wheel devpi-common

# Upgrade pip and setup tools
RUN pip3 install --upgrade setuptools pip wheel devpi-server devpi-client devpi-constrained devpi-common

# Create working directory and data directory
WORKDIR /apps

# Copy sync script and YAML config
COPY *.sh *.txt .
RUN chmod ugo+rx *.sh

# Expose devpi port
EXPOSE 3141

ENTRYPOINT ["/apps/entrypoint.sh"]
