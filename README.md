# biohazard-tools-docker
Dockerized biohazard-tools from https://bitbucket.org/ustenzel/biohazard-tools/src/master/

Docker images here: https://hub.docker.com/repository/docker/rbiermanpu/biohazard-tools/general

Currently "dev" tag is ~850MB when using a Docker single-stage build. amd64 arch only for now.

Attempting to decrease image size with a multi-stage build. Initial success with a ~200MB image with tag "multi_dev". This is pretty good, wonder if it can be better.
- Also needs testing of the different executables
