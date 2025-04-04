# Install specific verions of ghc and cabal to
# install biohazard and biohazard-tools
# Much of this is stolen from: https://discourse.haskell.org/t/good-way-of-installing-specific-cabal-and-ghc-inside-a-docker-container/9930
FROM --platform=linux/amd64 alpine:3.21

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
RUN git clone https://ustenzel@bitbucket.org/ustenzel/biohazard.git
WORKDIR biohazard
RUN cabal update
RUN cabal configure
RUN cabal build
RUN cabal install --lib .

# Install biohazard-tools
WORKDIR ..
RUN git clone https://ustenzel@bitbucket.org/ustenzel/biohazard-tools.git
WORKDIR biohazard-tools
RUN echo "packages: ./ ./../biohazard" > cabal.project
RUN cabal install .

# TODO make a multistage build and just copy the executables

ENTRYPOINT ["ls"]
