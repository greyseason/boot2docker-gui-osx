#!/bin/bash

# Get the file
curl -o ~/bin/docker http://get.docker.io/builds/Darwin/x86_64/docker-latest

# Mark it executable
chmod +x ~/bin/docker

~/bin/docker version

