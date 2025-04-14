# biohazard-tools-docker
Dockerized biohazard-tools from https://bitbucket.org/ustenzel/biohazard-tools/src/master/ to provide the following tools:
- bam-dir
- bam-fixpair
- bam-mangle
- bam-meld
- bam-rewrap
- bam-rmdup
- expound
- fastq2bam

Docker images here: https://hub.docker.com/repository/docker/rbiermanpu/biohazard-tools/general

Currently only supports the `linux/amd64` architecture.

Examples of usage:
---
Example getting the help message for `bam-fixpair` using the docker image:
```
docker run --rm rbiermanpu/biohazard-tools bam-fixpair --help
```

To run the tests with nextflow and docker:
```
nextflow run -with-docker rbiermanpu/biohazard-tools biohazard.nf
```

To run the tests with nextflow and singularity:
```
nextflow run -with-singularity rbiermanpu/biohazard-tools:dev biohazard.nf
```

Further TODO's
---

- Test the all executables (still not testing mangle, meld, rewrap, expound)

- Release version 1.0.0

- Create a macOS amd64 and arm64 platform build
