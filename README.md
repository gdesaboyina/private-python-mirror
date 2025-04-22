# build the docker image
docker-compose build

# run the docker image
docker-compose up -d

# check the running docker containers
docker-compose ps -a

# send PR to file approved-packages.txt

# Scan for the Python package vulnerabilities. Make sure to build the image before running scan

```bash
./scan_pip_packages.sh
```
