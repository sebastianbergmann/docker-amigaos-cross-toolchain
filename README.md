# Dockerfile for AmigaOS Cross-Compiler Toolchain

`Dockerfile` for [Stefan "Bebbo" Franke](https://github.com/bebbo)'s [fork](https://github.com/bebbo/amigaos-cross-toolchain) of [Krystian Bacławski](https://github.com/cahirwpz)'s [AmigaOS Cross-Compiler Toolchain](https://github.com/cahirwpz/amigaos-cross-toolchain).

## Creating the image

```
docker build -t m68k-amigaos-bebbo .
```

## Using the image

```
docker run -it m68k-amigaos-bebbo \
/opt/m68k-amigaos/bin/m68k-amigaos-gcc -v
Using built-in specs.
COLLECT_GCC=/opt/m68k-amigaos/bin/m68k-amigaos-gcc
COLLECT_LTO_WRAPPER=/opt/m68k-amigaos/libexec/gcc/m68k-amigaos/6.3.1/lto-wrapper
Target: m68k-amigaos
Configured with: /root/amigaos-cross-toolchain/submodules/gcc-6/configure --prefix=/opt/m68k-amigaos --host=i686-linux-gnu --build=i686-linux-gnu --target=m68k-amigaos --enable-languages=c --enable-version-specific-runtime-libs --disable-libssp --with-headers=/root/amigaos-cross-toolchain/.build-m68k/sources/ixemul-48.2/include
Thread model: single
gcc version 6.3.1 20170217 (GCC)
```

