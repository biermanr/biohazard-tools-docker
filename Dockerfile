# Install specific verions of ghc and cabal to
# install biohazard and biohazard-tools
# Much of this is stolen from: https://discourse.haskell.org/t/good-way-of-installing-specific-cabal-and-ghc-inside-a-docker-container/9930
FROM alpine:3.21 AS build

# Install necessary dependencies
RUN apk update && apk add --no-cache \
    bash curl git make m4 gcc g++ ocaml \
    ocaml-compiler-libs opam findutils \
    linux-headers gmp-dev \
    binutils-gold libc-dev libffi-dev musl-dev ncurses-dev perl tar xz \
    zlib-dev

# download and install ghcup
RUN curl -L https://downloads.haskell.org/~ghcup/x86_64-linux-ghcup -o /usr/bin/ghcup && \
    chmod +x /usr/bin/ghcup

# Install specific version of cabal and ghc
RUN ghcup install cabal 3.2.0.0 && \
    ghcup install ghc 8.10.7 && \
    ghcup set 8.10.7

# Add cabal and ghc to PATH
ENV PATH="$PATH:/root/.ghcup/bin"

# Install biohazard
WORKDIR /root
RUN git clone https://ustenzel@bitbucket.org/ustenzel/biohazard.git
WORKDIR /root/biohazard
RUN cabal update && \
    cabal configure && \
    cabal build && \
    cabal install --lib .

# Install biohazard-tools
WORKDIR /root
RUN git clone https://ustenzel@bitbucket.org/ustenzel/biohazard-tools.git
WORKDIR /root/biohazard-tools
RUN echo "packages: ./ ./../biohazard" > cabal.project
RUN cabal install .

# Final stage, only copy executables and have minimal dependencies
FROM alpine:3.21 AS final
COPY --from=build /root/.cabal/bin /usr/local/bin
RUN chmod +x /usr/local/bin/*
ENV PATH="$PATH:/usr/local/bin"

# Install necessary dependencies
RUN apk update && apk add --no-cache \
    bash curl git make m4 gcc g++ ocaml \
    ocaml-compiler-libs opam findutils \
    linux-headers gmp-dev \
    binutils-gold libc-dev libffi-dev musl-dev ncurses-dev perl tar xz \
    zlib-dev

RUN ldd /usr/local/bin/fastq2bam
RUN file /usr/local/bin/fastq2bam
RUN fastq2bam --help