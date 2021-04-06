# DOCKER NOTES
## Installing Docker
`sudo apt install docker.io` to install Docker <br>
`systemctl status docker` to check if Docker is running. <br>

```bash
● docker.service - Docker Application Container Engine
   Loaded: loaded (/lib/systemd/system/docker.service; enabled; vendor preset: enabled)
   Active: active (running) since Tue 2021-04-06 20:35:19 BST; 3min 46s ago
```

Docker is running and enabled. <br>
If it is **disabled**: `sudo systemctl enable docker` to enable it. <br>
`sudo systemctl start docker` to run it if it is **inactive**. <br>
