# Overview
This project is a simple Docker image that execute the building of a JVM project.  The Docker engine
is available to the container so any builds that use Docker Compose to build and launch containers 
for integration testing will work.

#Prerequisites
* a working [Docker](http://docker.io) engine
* a working [Docker Compose](http://docker.io) installation

# Building
Type `docker-compose build` to build the image.

# Installation
Docker Compose will automatically install the newly built image into the cache.

# Tips and Tricks

## Launching The Image

`docker-compose up` will launch the image, proving it built correctly.

# Troubleshooting

# License and Credits
This project is licensed under the [Apache License Version 2.0, January 2004](http://www.apache.org/licenses/).

