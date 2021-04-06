# DOCKER NOTES
## Installing Docker, first checks and configs
`sudo apt install docker.io` to install Docker <br>
`systemctl status docker` to check if Docker is running. <br>

```bash
● docker.service - Docker Application Container Engine
   Loaded: loaded (/lib/systemd/system/docker.service; enabled; vendor preset: enabled)
   Active: active (running) since Tue 2021-04-06 20:35:19 BST; 3min 46s ago
```

Docker is running and enabled. <br>
If it is **disabled**: `sudo systemctl enable docker` to enable it. <br>
`sudo systemctl start docker` to run Docker if it is **inactive**. <br>
<br>
Run `sudo docker run hello-world` to check if Docker is functional. <br>
Docker will pull the container and display a welcome message. <br>
<br>
Add your user to the **docker group** if you don't want to use **sudo** to run it. <br>
`sudo usermod -aG docker pi` is the command (exchange *pi* with your username). <br>
That change will take effect after the next login. <br>

## Docker commands
`docker images` shows you all installed Docker repositories. <br>
`docker search ubuntu` will show you available *ubuntu* docker repos. <br>
`docker pull ubuntu` will download the image to your local system. <br>
You can download and run the image in one command: `docker run ubuntu` <br>
The same command will run a container from the prior downloaded image. <br>
**NOTE**: Containers which have nothing to do will stop running automatically. <br>
To determine which docker containers are currently running, use: `docker ps`. <br>
`docker ps -a` will show you running containers + a history of containers that recently ran. <br>
So while `docker run ubuntu` will straight exit because it has nothing to do …
`docker run -it ubuntu /bin/bash` will give you a bash prompt. <br>
You can enter any command as on an usual ubuntu bash shell – like installing Vim: <br>

```bash
root@d53eba57a5a1:/# apt update; apt install vim
```

<kbd>CTRL</kbd> <kbd>d</kbd> to exit the container. <br>
**NOTE**: If you exit and re-enter the container, you'll notice that Vim ain't installed. <br>
Docker doesn't save any changes made to a container by default! <br>
If you want to make a permanent change to a container, you have to change the image. <br>
A container is build from the image when you use `docker run`, so what ain't in the image won't be build. <br>

