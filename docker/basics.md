# Basic Usage

### Docker Workflow

![](/assets/dockerworkflow233410.png)

- Changes in the container does not affect the image that the container is created from

* `docker run <IMAGE>` runs the image with the specified image repo and version or image ID

- `docker run -ti <IMAGE>` the -ti flag stands for _terminal interactive_, useful when you want to run a terminal inside of the image
    - Containers have a main process
    - The container stops when the main process stops
    - Can also use the `--rm` flag to remove the container after it exits
    
    
- `docker commit <CONTAINER> <IMAGE>` makes a new image out of a container with a given image name

#### Attaching to a container

- `docker attach <CONTAINER>` jumps into a running container
- To exit an attached container do `ctrl-P, ctrl-Q`

#### Execute a new process in a running container

- `docker exec <CONTAINER> <PROCESS>`

### Manage Containers
#### Obtain logs from a container
- `docker logs <CONTAINER>`

#### Stopping and removing a container
- `docker kill <CONTAINER>`
    - Stops a container
    - Makes it a stopped container
- `docker rm <CONTAINER>`
    - Removes the container
    - Stopped container will continue to exist until you explicitly removes them