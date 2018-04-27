# Basic Usage

### Docker Workflow

![](/assets/dockerworkflow233410.png)

* Changes in the container does not affect the image that the container is created from

* `docker run <IMAGE>` runs the image with the specified image repo and version or image ID

* `docker run -ti <IMAGE>` the -ti flag stands for _terminal interactive_, useful when you want to run a terminal inside of the image

  * Containers have a main process
  * The container stops when the main process stops
  * Can also use the `--rm` flag to remove the container after it exits

* `docker commit <CONTAINER> <IMAGE>` makes a new image out of a container with a given image name

#### Attaching to a container

* `docker attach <CONTAINER>` jumps into a running container
* To exit an attached container do `ctrl-P, ctrl-Q`

#### Execute a new process in a running container

* `docker exec <CONTAINER> <PROCESS>`

### Manage Containers

#### Obtain logs from a container

* `docker logs <CONTAINER>`

#### Stopping and removing a container

* `docker kill <CONTAINER>`
  * Stops a container
  * Makes it a stopped container
* `docker rm <CONTAINER>`
  * Removes the container
  * Stopped container will continue to exist until you explicitly removes them

### Networking between containers

* You can specify which port to expose in a container using the `-p <INSIDE>:<OUTSIDE>` flag with `docker run`
  * The inside port specify the port that's exposed within the container, the outside post specify the exposed port on the host
  * The OUT port can be omitted to dynamically select the next available port

* Use `docker port <CONTAINER>` to find out which port is available on a container

### Docker Files

* A file for docker that specifies how to build an image
* Docker caches changes in a new image file for each line in the docker file
  * Careful with multi-line operations when working with large images

#### Basic Syntax

`FROM <IMAGE>` - specifies which image to start

`MAINTAINER <firstname> <lastname> <email>` - information regarding the creator \(documentation purposes\)

`RUN <COMMAND>` - run a command through the shell

`ADD <FILE/ARCHIVE/URL>` - can be used to add content to the image \(e.g. from local files, archives, url etc.\)

`ENV <VAR>=<VALUE>` - sets the enviroment variables; the variables will remain set in the image created

`ENTRYPOINT` - specifies the start of the command to run; the arguments specified when you run the image will serve as the argument for the entry point command

`CMD` - specifies an entire command that will be ran; if a command is supplied when running the image the CMD command will get replaced

`EXPOSE <PORT>` - maps a port into the container

`VOLUME` - defines shared or ephemeral volumes

`WORKDIR` - specifies the working directory for the docker file and the resulting image

`USER` - specifies which user that the container will run as



