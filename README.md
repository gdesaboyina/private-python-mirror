## Devpi Constrained PyPI Mirror

A self-hosted Devpi PyPI mirror fronted by Nginx with strict package access control and constrained download policies. This setup is ideal for air-gapped or tightly controlled environments where only pre-approved Python packages (and their dependencies) should be accessible.


### build the docker image
`docker-compose build`

### run the docker image
`docker-compose up -d`

### check the running docker containers
`docker-compose ps -a`

### send PR to file approved-packages.txt

### Scan for the Python package vulnerabilities. Make sure to build the image before running scan

`./scan_pip_packages.sh`

### Install in Client from Private Repo.
`pip install -i http://<nginx-server-ip>:8080/myuser/mirror --trusted-host <nginx-server-ip> azure-core`
