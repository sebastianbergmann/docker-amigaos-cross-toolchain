FROM i386/ubuntu:17.10

RUN apt-get update && apt-get install -y \
    autoconf \
    bison \
    flex \
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
    cd /root && \
    git clone https://github.com/bebbo/amigaos-cross-toolchain.git && \
    cd /root/amigaos-cross-toolchain && \
    git checkout -qf 6c27555fab2dde7e7a2f08ad7c77162580291ce3 && \
    ./toolchain-m68k --prefix=/opt/m68k-amigaos --threads=4 build && \
    cd / && \
    rm -rf /root/amigaos-cross-toolchain && \
    apt-get purge -y \
    autoconf \
    bison \
    flex \
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

ENV PATH /opt/m68k-amigaos/bin:$PATH

