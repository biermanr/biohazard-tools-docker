# biohazard-tools-docker
Dockerized biohazard-tools from https://bitbucket.org/ustenzel/biohazard-tools/src/master/

Docker images here: https://hub.docker.com/repository/docker/rbiermanpu/biohazard-tools/general

Currently "dev" tag is ~850MB when using a Docker single-stage build. amd64 arch only for now.

Attempting to decrease image size with a multi-stage build. Initial success with a ~200MB image with tag "multi_dev". This is pretty good, wonder if it can be better.
- Also needs testing of the different executables


TODO's
- Test the different executables
- Decrease image size by minimizing `apk update` command (step 6)

| Step | Command | Size |
| --- | -------------------------------------------------------------------------------------- | -------------- |
|   1 | ADD  alpine-minirootfs-3.21.3-x86_64.tar.gz / # buildkit                               |        3.47 MB |
|   2 | CMD  ["/bin/sh"]                                                                       |           0 B  |
|   3 | COPY /root/.cabal/bin /usr/local/bin # buildkit                                        |       33.29 MB |
|   4 | RUN  /bin/sh -c chmod +x                                                               |          32 B  |
|   5 | ENV  PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/local/bin  |           0 B  |
|   6 | RUN  /bin/sh -c apk update                                                             |  **145.24 MB** |
|   7 | RUN  /bin/sh -c ldd /usr/local/bin/fastq2bam                                           |          32 B  |
|   8 | RUN  /bin/sh -c fastq2bam --help                                                       |          32 B  |


- Create a macOS amd64 and arm64 platform build
- ??
