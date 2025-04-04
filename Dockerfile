# Install specific verions of ghc and cabal to
# install biohazard and biohazard-tools
# Much of this is stolen from: https://discourse.haskell.org/t/good-way-of-installing-specific-cabal-and-ghc-inside-a-docker-container/9930
FROM --platform=linux/amd64 alpine:3.21

# Install necessary dependencies
RUN apk update && apk add --no-cache \
    bash curl git make m4 gcc g++ ocaml \
    ocaml-compiler-libs opam findutils \
    linux-headers gmp-dev \
    binutils-gold libc-dev libffi-dev musl-dev ncurses-dev perl tar xz

# download and install ghcup
RUN curl -L https://downloads.haskell.org/~ghcup/x86_64-linux-ghcup -o /usr/bin/ghcup && \
    chmod +x /usr/bin/ghcup

ENV PATH="$HOME/.cabal/bin:$HOME/.ghcup/bin:$PATH"

# TODO, convert to single command with &&
RUN ghcup install cabal 3.2.0.0
RUN ghcup install ghc 8.10.7
RUN ghcup set 8.10.7

RUN ~/.ghcup/bin/cabal update

# Install biohazard
RUN git clone https://ustenzel@bitbucket.org/ustenzel/biohazard.git
WORKDIR biohazard
RUN ~/.ghcup/bin/cabal configure
RUN ~/.ghcup/bin/cabal build
RUN ~/.ghcup/bin/cabal install --lib .

# Install biohazard-tools
WORKDIR ..
RUN git clone https://ustenzel@bitbucket.org/ustenzel/biohazard-tools.git
WORKDIR biohazard-tools
RUN echo "packages: ./ ./../biohazard" > cabal.project
RUN ~/.ghcup/bin/cabal install .

# TODO make a multistage build and just copy the executables

ENTRYPOINT ["ls"]
