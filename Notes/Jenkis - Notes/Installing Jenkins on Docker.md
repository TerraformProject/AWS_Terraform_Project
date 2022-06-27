# Installing Jenkins on Docker

## Docker

Link: [Installing Jenkins Image on Docker](https://www.jenkins.io/doc/book/installing/docker/)

Docker can be installed as an image in a container. Which means that any operating system suitable in running docker can run a Jenkins image.

\*\* If you are running Docker on a Linux based operating system, ensure you configure Docker so it can be managed as a non-root user. Here is the link to configure docker as a non-root user: [Manage Docker as Non-Root user](https://docs.docker.com/engine/install/linux-postinstall/)
<br>
## Prerequisites

### Minimum hardware requirements:

* 256 MB of RAM.
* 1 GB of drive space (although 10 GB is a recommended minimum if running Jenkins as a Docker container)

### Recommended hardware configuration for a small team:

* 4 GB+ of RAM
* 50 GB+ of drive space

### Comprehensive Harware Recommendations:

[Hardware recommendations](https://www.jenkins.io/doc/book/scaling/hardware-recommendations/)

Downloading and running Jenkins on Docker
There are several Docker Images of Jenkins availabled.

\*\*The recommended Docker image to use is the official Jenkins Image (From the Docker Hub Repositiory). Image contains the current long term support (LTS) release of Jenkins.

[Official Docker Image](https://hub.docker.com/r/jenkins/jenkins/)

\*\* Be sure to record the version of the Docker image initially pulled as there is a new docker image of Jenkins whenever there is a release.

\*\*However, this image does not have the Docker CLI or Blue Ocean pluginS And features. If you would like to use the full functionality of docker follow the installation below.
<br>
### Installing full power of Jenkins on Docker
<br>
#### Linux
<br>
Step 1: Open up a terminal window.
Step 2: Create a bridge network using the following command.

docker network create jenkins

Step 3: In order to execute Docker commands inside Jenkins nodes, download and run the docker:dind Docker image using the following docker run command below.

```
docker run \
```
<br>
\*\*(Optional Specifies the Docker container name to use for running the image. By default, Docker will generate a unique name for the container.

```
--name: jenkins-docker \
```
<br>
\*\*(Optional) Automatically removes the Docker container when it is shut down.

```
--rm \
```
<br>
\*\*(Optional) Runs the Docker container in the background.

```
--detach \
```
<br>
\*\*Running Docker within docker currently requires privileged access.

```
--privileged \
```
<br>
\*\*This corresponds to the docker network created in Step 1

```
--network jenkins \
```
<br>
##Makes the Docker in Docker container available as the hostname docker within the Jenkins network

```
--network-alias docker \
```
<br>
\*\*Enabled the use of TLS in the docker server. Due to the use of the privileged container, this is recommended. Though it requires the use of the shared volume described below. This environment variable controls the rools directory where Docker TLS certificates are managed/

```
--env DOCKER_TLS_CERTDIR=/certs \
```
<br>
\*\*Maps the /certs/client directory inside the container to a docker volume named jenkins-docker-certs as created above.

```
--volume jenkins-docker-certs: /certs/client \
```
<br>
\*\*Maps the /var/jenkins\_home directory inside the container to the Dokcer volume named jenkins-data. This will allow for the docker containers controlled by this docker container's Docker Daemon to mount data from Jenkins.

```
--volume jenkins-data:/var/jenkins_home \
```
<br>
##Exposes the Docker daemon port on the host machine. This is useful for executing docker commands on the host machine to control this inner Docker Daemon.

```
--publish 2367:2367 \
```
<br>
\*\*The docker:dind image itself. This image can be downloaded before running by using the command docker image pull docker:dind

```
docker:dind \
```
<br>
\*\*The storage driver for the docker volume.

```
--storage-driver overlay2
```
<br>
Step 4: Customize official Jenkins Docker Image, by executing below two steps.
    Step 4a: Create Dockerfile with the following content.
            `From jenkins/jenkins:2.346-1-jdk11`
<br>
```
FROM jenkins/jenkins:2.346.1-jdk11
USER root
RUN apt-get update && apt-get install -y lsb-release
RUN curl -fsSLo /usr/share/keyrings/docker-archive-keyring.asc \
  https://download.docker.com/linux/debian/gpg
RUN echo "deb [arch=$(dpkg --print-architecture) \
  signed-by=/usr/share/keyrings/docker-archive-keyring.asc] \
  https://download.docker.com/linux/debian \
  $(lsb_release -cs) stable" > /etc/apt/sources.list.d/docker.list
RUN apt-get update && apt-get install -y docker-ce-cli
USER jenkins
RUN jenkins-plugin-cli --plugins "blueocean:1.25.5 docker-workflow:1.28"
```

step 4b:
    Build a new docker image from this Dockerfile and assign the image a meaningful name, e.g. "myjenkins-blueocean:2.346.1-1":

1.

```
docker build -t myjenkins-blueocean:2.346.1-1 .
```

Keep in mind that the process described above will automatically download the official Jenkins Docker image if this hasn’t been done before.

<span class="colour" style="color:rgb(74, 85, 104)">Run your own `myjenkins-blueocean:2.346.1-1` image as a container in Docker using the following [`docker run`](https://docs.docker.com/engine/reference/run/) command:</span>

<br>
```
docker run \
  --name jenkins-blueocean \  #(1)
  --restart=on-failure \ #(2)
  --detach \ #(3)
  --network jenkins \ #(4)
  --env DOCKER_HOST=tcp://docker:2376 \ #(5)
  --env DOCKER_CERT_PATH=/certs/client \ 
  --env DOCKER_TLS_VERIFY=1 \ 
  --publish 8080:8080 \ #(6)
  --publish 50000:50000 \ #(7)
  --volume jenkins-data:/var/jenkins_home \ #(8)
  --volume jenkins-docker-certs:/certs/client:ro \ #(9)
  myjenkins-blueocean:2.346.1-1 #(10)
```

\| \| \(1\) \( *Optional* \) Specifies the Docker container name for this instance of the Docker image\. \|
\| \| \(2\) Always restart the container if it stops\. If it is manually stopped\, it is restarted only when Docker daemon restarts or the container itself is manually restarted\. \|
\| \| \(3\) \( *Optional* \) Runs the current container in the background \(i\.e\. "detached" mode\) and outputs the container ID\. If you do not specify this option\, then the running Docker log for this container is output in the terminal window\. \|
\| \| \(4\) Connects this container to the `jenkins` network defined in the earlier step. This makes the Docker daemon from the previous step available to this Jenkins container through the hostname `docker`\. \|
\| \| \(5\) Specifies the environment variables used by `docker`, `docker-compose`\, and other Docker tools to connect to the Docker daemon from the previous step\. \|
\| \| \(6\) Maps \(i\.e\. "publishes"\) port 8080 of the current container to port 8080 on the host machine\. The first number represents the port on the host while the last represents the container’s port\. Therefore\, if you specified `-p 49000:8080` for this option\, you would be accessing Jenkins on your host machine through port 49000\. \|
\| \| \(7\) \( *Optional* ) Maps port 50000 of the current container to port 50000 on the host machine. This is only necessary if you have set up one or more inbound Jenkins agents on other machines, which in turn interact with your `jenkins-blueocean` container (the Jenkins "controller"). Inbound Jenkins agents communicate with the Jenkins controller through TCP port 50000 by default. You can change this port number on your Jenkins controller through the [Configure Global Security](https://www.jenkins.io/doc/book/managing/security/) page. If you were to change the **TCP port for inbound Jenkins agents** of your Jenkins controller to 51000 (for example), then you would need to re-run Jenkins (via this `docker run …` command) and specify this "publish" option with something like `--publish 52000:51000`, where the last value matches this changed value on the Jenkins controller and the first value is the port number on the machine hosting the Jenkins controller. Inbound Jenkins agents communicate with the Jenkins controller on that port (52000 in this example). Note that [WebSocket agents](https://www.jenkins.io/blog/2020/02/02/web-socket/) do not need this configuration\. \|
\| \| \(8\) Maps the `/var/jenkins_home` directory in the container to the Docker [volume](https://docs.docker.com/engine/admin/volumes/volumes/) with the name `jenkins-data`. Instead of mapping the `/var/jenkins_home` directory to a Docker volume, you could also map this directory to one on your machine’s local file system. For example, specifying the option
`--volume $HOME/jenkins:/var/jenkins_home` would map the container’s `/var/jenkins_home` directory to the `jenkins` subdirectory within the `$HOME` directory on your local machine, which would typically be `/Users/<your-username>/jenkins` or `/home/<your-username>/jenkins`. Note that if you change the source volume or directory for this, the volume from the `docker:dind` container above needs to be updated to match this\. \|

\| \| \(9\) Maps the `/certs/client` directory to the previously created `jenkins-docker-certs` volume. This makes the client TLS certificates needed to connect to the Docker daemon available in the path specified by the `DOCKER_CERT_PATH` environment variable\. \|
\| \| \(10\) The name of the Docker image\, which you built in the previous step\. \|

### Windows

Use this link to install on windows: [Docker installation on Windows](https://www.jenkins.io/doc/book/installing/docker/)