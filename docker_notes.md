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
`docker search debian` will show you available *debian* docker repos. <br>
`docker pull arm32v7/debian` will download that image to your local system. <br>
You can download and run the image in one command: `docker run arm32v7/debian` <br>
The same command will run a container from the prior downloaded image. <br>
**NOTE**: Containers which have nothing to do will stop running automatically. <br>
To determine which docker containers are currently running, use: `docker ps`. <br>
`docker ps -a` will show you running containers + a history of containers that recently ran. <br>
So while `docker run arm32v7/debian` will straight exit because it has nothing to do …
`docker run -it arm32v7/debian /bin/bash` will give you a bash prompt. <br>
You can enter any command as on an usual arm32v7/debian bash shell – like installing Vim: <br>

```bash
root@d53eba57a5a1:/# apt update; apt install vim
```

<kbd>CTRL</kbd> + <kbd>d</kbd> to exit the container. <br>
**NOTE**: If you exit and re-enter the container, you'll notice that Vim ain't installed. <br>
Docker doesn't save any changes made to a container by default! <br>
If you want to make a permanent change to a container, you have to change the image. <br>
A container is build from the image when you use `docker run`, so what ain't in the image won't be build. <br>
`docker run -it arm32v7/debian` without the */bin/bash* addition brings you to the promt as well. <br>
bash ist the default shell of the debian image and called through the **-it** option.
If you enter `docker run -it -d arm32v7/debian` you'll get some string like this as result: <br>

```sh
1dd819d65581b45611a197d211f2314eee9b8529cfc1ca807fe7a4c148c0cb95
```

If you run `docker ps` now, you'll see, that the container is still running in the background: <br>

```sh
CONTAINER ID        IMAGE               COMMAND             CREATED             STATUS       
1dd819d65581        arm32v7/debian      "bash"              7 minutes ago       Up 7 minutes
```

So let's walk through the `docker run -it -d arm32v7/debian` command: <br>
**-it** is for **interactive terminal** – that will open the default shell. <br>
**-d** the -d option puts the container into **deamon** mode, which means it is running in the **background**. <br>
To get back into that container, use `docker attach 1dd819d65581`. <br>
Docker allows you to type **those letters** from the container id which deffer from those of the other running containers. <br>
<br>
If you detach from the container with <kbd>CTRL</kbd> + <kbd>d</kbd> or `exit`, the container will stop and all the changes made to the container will be lost. <br>
To exit the container while keeping it running in the background, hold <kbd>CTRL</kbd> and type <kbd>p</kbd>, then <kbd>q</kbd>. <br>
You'll get such a message: <br>

```sh
root@1dd819d65581:/# read escape sequence
```

The container will now remain in the background. <br>
If you re-attach to it, you'll realize, your changes have been kept. <br> 

## interacting with containers
### installing a web-server and mapping a port
`docker run -it -d -8080:80 nginx` will run an container of an **nginx** image, with … <br>
* **-it** an interactive shell
* **d** deamon mode
* **port 80** (on which nginx runs by default) **enabled**
* **port 8080** from the **host** system mapped to that port
<br>
Get the ip adress of the host with `ip addr show` or short `ip a`. <br>
Enter your browser, type in that address plus the specified port http://192.168.178.41**:8080/** … <br>
… and you'll hopefully see the ngnix welcome page. <br>
Use `docker run -it -d --restart unless-stopped -p 8080:80 nginx` if you want to keep ngnix alive **until stopped**. <br>


## Remove image
`docker image rm arm32v7/debian` to remove the arm32v7/debian image.
If you get a conflict error message, you should stop containers running the image.
`docker stop 50a4bb400ca7` will stop the container with that id. <br>
If the image still doesn't get deleted or you don't care about running containers, <br>
run `docker image rm -f arm32v7/debian` to **force** the deletion of the image. <br>

