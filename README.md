# Docker Image for methylpy
<h4 align = "right">Colby T. Ford, Ph.D.</h4>
This repository contains the Dockerfile for generating an Ubuntu image with methylpy pre-installed.

## DockerHub
This container image is available from DockerHub: [hub.docker.com/r/cford38/methylpy](https://hub.docker.com/r/cford38/methylpy)

#### Pull Image to Local Machine
```
docker pull cford38/methylpy:latest
```
#### To Run Locally
```
docker run --name methylpy -d cford38/methylpy
docker exec -it methylpy /bin/bash
```

#### Copy File to Container
```
docker cp myfile.txt methylpy:./myfile.txt
```

### Copy Files from Container
```
docker cp methylpy:./root/methylpy/ ./
```

-------------------------------

## Build Instructions
1. Clone this repository to your local machine

2. Open terminal and navigate to the directory of this repository.

3. Run the following command. This will generate the Docker image.
```
docker build -t methylpy .
```
_Note:_ You may have to increase the resource limits in Docker's settings as this container size (and the resources methylpy needs to run) will be quite large.
<p align="center"><img src="DockerSettings.png" width="500px"></p>


4. Once the image has been created successfully, run the container using the following command.
```
docker run -it -p 5000:5000 -v $(pwd):/app methylpy
## remove `-v $(pwd):/app` if on Windows Command Prompt
```

5. Once the container is ready, you can remote into the bash terminal.
```
#docker run --name methylpy -d methylpy
ocker exec -it methylpy /bin/bash
```

----------------------

## To Publish on DockerHub

```
docker image tag methylpy <USERNAME>/methylpy
docker push <USERNAME>/methylpy
```

----------------------
## About methylpy

methylpy, developed by the Yupeng He, is a python-based analysis pipeline for (single-cell) (whole-genome) bisulfite sequencing data, (single-cell) NOMe-seq data, differential methylation analysis. Check out the GitHub repo for more details: [https://github.com/yupenghe/methylpy](https://github.com/yupenghe/methylpy)
