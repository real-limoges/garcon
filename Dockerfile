# ── Builder ──────────────────────────────────────────────
FROM haskell:9.12.2 AS builder

RUN apt-get update && \
    apt-get install -y --no-install-recommends git && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /build

# Clone workspace dependencies from GitHub
RUN git clone --depth 1 https://github.com/real-limoges/chompsky.git chompsky && \
    git clone --depth 1 https://github.com/real-limoges/hazy.git hazy

# Copy cabal files first for dependency caching
COPY garcon.cabal  garcon/garcon.cabal
COPY cabal.project.docker garcon/cabal.project

WORKDIR /build/garcon
RUN cabal update && cabal build --only-dependencies --enable-optimization=2

# Copy full garcon source
WORKDIR /build
COPY . garcon/
# Restore docker-specific cabal.project (COPY . overwrites it)
COPY cabal.project.docker garcon/cabal.project

WORKDIR /build/garcon
RUN cabal install exe:garcon \
    --enable-optimization=2 \
    --install-method=copy \
    --overwrite-policy=always \
    --installdir=/build/bin

# ── Runtime ──────────────────────────────────────────────
FROM debian:bookworm-slim

RUN apt-get update && \
    apt-get install -y --no-install-recommends libgmp10 && \
    rm -rf /var/lib/apt/lists/*

COPY --from=builder /build/bin/garcon /usr/local/bin/garcon
COPY --from=builder /build/chompsky/config /etc/chompsky/config

ENV CHOMPSKY_CONFIG_DIR=/etc/chompsky/config

EXPOSE 7444

ENTRYPOINT ["garcon"]
