import yaml
import subprocess
import os

with open("sync_packages.yaml") as f:
    config = yaml.safe_load(f)

packages = config.get("packages", [])

for pkg in packages:
    print(f"Syncing {pkg}...")
    subprocess.run(["devpi", "use", "http://localhost:3141"], check=True)
    subprocess.run(["devpi", "login", "root", "--password", ""], check=True)
    subprocess.run(["devpi", "push", pkg, "root/pypi"], check=False)

