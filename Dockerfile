# Ubuntu 16.04 ("Xenial Xerus") 32-bit
FROM daald/ubuntu32:xenial

# Update base system and install build dependencies
RUN apt-get update && apt-get install -y \
    autoconf \
    bison \
    g++ \
    gcc \
    gettext \
    git \
    gperf \
    libgmp-dev \
    libmpc-dev \
    libmpfr-dev \
    libncurses5-dev \
    make \
    python-dev \
    && rm -rf /var/lib/apt/lists/*

# Build M68K AmigaOS Cross-Compilation Toolchain
RUN cd /root && \
    git clone https://github.com/bebbo/amigaos-cross-toolchain.git && \
    cd /root/amigaos-cross-toolchain && \
    ./toolchain-m68k --prefix=/opt/m68k-amigaos build

