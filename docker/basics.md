# Basics

### Docker Workflow

![](/assets/dockerworkflow233410.png)

- Changes in the container does not affect the image that the container is created from

* `docker run <IMAGE>` runs the image with the specified image repo and version or image ID

- `docker run -ti <IMAGE>` the -ti flag stands for _terminal interactive_, useful when you want to run a terminal inside of the image

- `docker commit <CONTAINER> <IMAGE>` makes a new image out of a container with a given image name

