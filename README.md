1. build the docker image
```bash
docker-compose build
```

2. run the docker image
```bash
docker-compose up -d
```

3. check the running docker containers
```bash
docker-compose ps -a
```

4. Manage the approved packages in approved-packages.txt. Can be specified with version too.

5. Scan for the Python package vulnerabilities. Make sure to build the image before running scan

```bash
./scan_pip_packages.sh
```

6. PIP Install from Client Side
```bash
pip install -i http://<nginx-server-ip>:8080/private/mirror --trusted-host <nginx-server-ip> azure-core
```

