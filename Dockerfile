# Ubuntu 17.04 ("Zesty Zapus") 32-bit
FROM i386/ubuntu:zesty

# Update base system and install build dependencies
RUN apt-get update && apt-get install -y \
    autoconf \
    bison \
    g++ \
    gcc \
    gettext \
    git \
    gperf \
    libgmp10 \
    libgmpxx4ldbl \
    libgmp-dev \
    libmpc3 \
    libmpc-dev \
    libmpfr4 \
    libmpfr-dev \
    libncurses5-dev \
    make \
    python-dev \
    && rm -rf /var/lib/apt/lists/* && \

# Clone amigaos-cross-toolchain.git repository (at last known good revision)
    cd /root && \
    git clone https://github.com/bebbo/amigaos-cross-toolchain.git && \
    cd /root/amigaos-cross-toolchain && \
    git checkout -qf 58a009b7db619618e505f777b15e4dce0a21bc08 && \

# Build M68K AmigaOS Cross-Compilation Toolchain
    ./toolchain-m68k --prefix=/opt/m68k-amigaos build && \

# Cleanup
    cd / && \
    rm -rf /root/amigaos-cross-toolchain && \
    apt-get purge -y \
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
    && apt-get -y autoremove

# Add /opt/m68k-amigaos/bin to $PATH
ENV PATH /opt/m68k-amigaos/bin:$PATH

