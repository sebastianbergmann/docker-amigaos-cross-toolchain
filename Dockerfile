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

# Clone amigaos-cross-toolchain.git repository (at last known good revision)
RUN cd /root && \
    git clone https://github.com/bebbo/amigaos-cross-toolchain.git && \
    cd /root/amigaos-cross-toolchain && \
    git checkout -qf 4b211d94efb842523656192fbc0596d18de1b8ed

# Build M68K AmigaOS Cross-Compilation Toolchain
RUN cd /root/amigaos-cross-toolchain && \
    ./toolchain-m68k --prefix=/opt/m68k-amigaos build

# Cleanup
RUN rm -rf /root/amigaos-cross-toolchain

# Add /opt/m68k-amigaos/bin to $PATH
ENV PATH /opt/m68k-amigaos/bin:$PATH

