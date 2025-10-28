# syntax=docker/dockerfile:1
FROM beestation/byond:515.1647 as base

# Install the tools needed to compile our rust dependencies
FROM base as rust-build
ENV PKG_CONFIG_ALLOW_CROSS=1 \
    CARGO_HOME=/usr/local/cargo \
    PATH=/usr/local/cargo/bin:$PATH
WORKDIR /build
COPY dependencies.sh .
RUN dpkg --add-architecture i386 \
    && apt-get update \
    && apt-get install -y --no-install-recommends \
    curl ca-certificates gcc-multilib \
    clang g++-multilib libc6-i386 \
    zlib1g-dev:i386 pkg-config:i386 git \
    && /bin/bash -c "source dependencies.sh \
    && curl https://sh.rustup.rs | sh -s -- -y -t i686-unknown-linux-gnu --no-modify-path --profile minimal --default-toolchain \$RUST_VERSION" \
    && rm -rf /var/lib/apt/lists/*

# Build rust-g
FROM rust-build as rustg
RUN git init \
    && git remote add origin https://github.com/tgstation/rust-g \
    && /bin/bash -c "source dependencies.sh \
    && git fetch --depth 1 origin \$RUST_G_VERSION" \
    && git checkout FETCH_HEAD \
    && cargo build --release --target i686-unknown-linux-gnu

# Build auxmos
FROM rust-build as auxmos
RUN git init \
    && /bin/bash -c "source dependencies.sh \
    && git remote add origin \$AUXMOS_REPO \
    && git fetch --depth 1 origin \$AUXMOS_VERSION" \
    && git checkout FETCH_HEAD \
    && env PKG_CONFIG_ALLOW_CROSS=1 cargo build --release --target=i686-unknown-linux-gnu --features "citadel_reactions,katmos"

# Install nodejs which is required to deploy Shiptest
FROM base as node
COPY dependencies.sh .
RUN apt-get update \
    && apt-get install curl -y \
    && /bin/bash -c "source dependencies.sh \
    && curl -fsSL https://deb.nodesource.com/setup_\$NODE_VERSION.x | bash -" \
    && apt-get install -y nodejs

# Build TGUI, tgfonts, and the dmb
FROM node as dm-build
ENV TG_BOOTSTRAP_NODE_LINUX=1
WORKDIR /dm-build
COPY . .
# Required to satisfy our compile_options
COPY --from=auxmos /build/target/i686-unknown-linux-gnu/release/libauxmos.so /dm-build/auxtools/libauxmos.so
RUN tools/build/build \
    && tools/deploy.sh /deploy \
    && apt-get autoremove curl -y \
    && rm -rf /var/lib/apt/lists/*

FROM base
WORKDIR /shiptest
COPY --from=dm-build /deploy ./
COPY --from=rustg /build/target/i686-unknown-linux-gnu/release/librust_g.so /root/.byond/bin/rust_g
VOLUME [ "/shiptest/config", "/shiptest/data" ]
ENTRYPOINT [ "DreamDaemon", "shiptest.dmb", "-port", "1337", "-trusted", "-close", "-verbose" ]
EXPOSE 1337
