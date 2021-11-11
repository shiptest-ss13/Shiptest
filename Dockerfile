# syntax=docker/dockerfile:1
FROM beestation/byond:514.1560 as base

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
    g++-multilib libc6-i386 zlib1g-dev:i386 \
    libssl-dev:i386 pkg-config:i386 git \
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
    && cargo build --release --all-features --target i686-unknown-linux-gnu

# Build auxmos
FROM rust-build as auxmos
RUN git init \
    && git remote add origin https://github.com/austation/auxmos \
    && /bin/bash -c "source dependencies.sh \
    && git fetch --depth 1 origin \$AUXMOS_VERSION" \
    && git checkout FETCH_HEAD \
    && cargo rustc --target=i686-unknown-linux-gnu --release --features=trit_fire_hook,plasma_fire_hook,generic_fire_hook,xenomedes_fusion,explosive_decompression

# Install nodejs which is required to deploy Shiptest
FROM base as node
COPY dependencies.sh .

RUN . ./dependencies.sh \
    && curl "http://www.byond.com/download/build/${BYOND_MAJOR}/${BYOND_MAJOR}.${BYOND_MINOR}_byond_linux.zip" -o byond.zip \
    && unzip byond.zip \
    && cd byond \
    && sed -i 's|install:|&\n\tmkdir -p $(MAN_DIR)/man6|' Makefile \
    && make install \
    && chmod 644 /usr/local/byond/man/man6/* \
    && apt-get purge -y --auto-remove curl unzip make \
    && cd .. \
    && rm -rf byond byond.zip

# build = byond + shiptest compiled and deployed to /deploy
FROM byond AS build
WORKDIR /shiptest

RUN apt-get install -y --no-install-recommends \
        curl

COPY . .

RUN env TG_BOOTSTRAP_NODE_LINUX=1 tools/build/build \
    && tools/deploy.sh /deploy

# rust = base + rustc and i686 target
FROM base AS rust
RUN apt-get install -y --no-install-recommends \
        curl && \
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y --profile minimal \
    && ~/.cargo/bin/rustup target add i686-unknown-linux-gnu

# rust_g = base + rust_g compiled to /rust_g
FROM rust AS rust_g
WORKDIR /rust_g

RUN apt-get install -y --no-install-recommends \
        pkg-config:i386 \
        libssl-dev:i386 \
        gcc-multilib \
        git \
    && git init \
    && git remote add origin https://github.com/tgstation/rust-g

COPY dependencies.sh .

RUN . ./dependencies.sh \
    && git fetch --depth 1 origin "${RUST_G_VERSION}" \
    && git checkout FETCH_HEAD \
    && env PKG_CONFIG_ALLOW_CROSS=1 ~/.cargo/bin/cargo build --release --target i686-unknown-linux-gnu

# final = byond + runtime deps + rust_g + build
FROM byond
WORKDIR /shiptest

RUN apt-get install -y --no-install-recommends \
        libssl1.0.0:i386 \
        zlib1g:i386
#auxtools fexists memes
RUN ln -s /shiptest/auxtools/libauxmos.so /root/.byond/bin/libauxmos.so

COPY --from=build /deploy ./
COPY --from=rust_g /rust_g/target/i686-unknown-linux-gnu/release/librust_g.so ./librust_g.so

VOLUME [ "/shiptest/config", "/shiptest/data" ]
ENTRYPOINT [ "DreamDaemon", "shiptest.dmb", "-port", "1337", "-trusted", "-close", "-verbose" ]
EXPOSE 1337
