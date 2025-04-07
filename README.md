# biohazard-tools-docker
Dockerized biohazard-tools from https://bitbucket.org/ustenzel/biohazard-tools/src/master/

Docker images here: https://hub.docker.com/repository/docker/rbiermanpu/biohazard-tools/general

Example using docker run: TODO!
```
docker run --rm rbiermanpu/biohazard-tools:dev bash example.bash
```

I checked that the following works on Della:
```
nextflow run -with-singularity rbiermanpu/biohazard-tools:dev biohazard.nf
```

TODO's
- Add documentation example

- Test the different executables (still not testing mangle, meld, rewrap, expound)
    - Run the tests in parallel jobs on GHA?

- Decrease image size by removing unnecessary packages from `apk update` command (step 6)

| Step | Command | Size |
| --- | -------------------------------------------------------------------------------------- | -------------- |
|   1 | ADD  alpine-minirootfs-3.21.3-x86_64.tar.gz / # buildkit                               |        3.47 MB |
|   2 | CMD  ["/bin/sh"]                                                                       |           0 B  |
|   3 | COPY /root/.cabal/bin /usr/local/bin # buildkit                                        |       33.29 MB |
|   4 | RUN  /bin/sh -c chmod +x                                                               |          32 B  |
|   5 | ENV  PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/local/bin  |           0 B  |
|   6 | RUN  /bin/sh -c apk update                                                             |   **23.22 MB** |

- Release version 1.0.0

- Create a macOS amd64 and arm64 platform build

- ??

