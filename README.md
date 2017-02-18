# Dockerfile for AmigaOS Cross-Compiler Toolchain

`Dockerfile` for [Stefan "Bebbo" Franke](https://github.com/bebbo)'s [fork](https://github.com/bebbo/amigaos-cross-toolchain) of [Krystian Bacławski](https://github.com/cahirwpz)'s [AmigaOS Cross-Compiler Toolchain](https://github.com/cahirwpz/amigaos-cross-toolchain).


## Creating the image

```
$ docker build -t m68k-amigaos-bebbo .
```


## Installed binaries

```
$ docker run -it m68k-amigaos-bebbo \
ls -lha /opt/m68k-amigaos/bin
total 12M
drwxr-xr-x. 1 root root  936 Feb 18 07:33 .
drwxr-xr-x. 1 root root  172 Feb 18 07:28 ..
-rwxr-xr-x. 1 root root  31K Feb 18 07:18 fd2sfd
-rwxr-xr-x. 1 root root 8.5K Feb 18 07:18 gg-fix-includes
-rwxr-xr-x. 1 root root  99K Feb 18 07:33 ira
-rwxr-xr-x. 1 root root 367K Feb 18 07:19 m68k-amigaos-addr2line
-rwxr-xr-x. 2 root root 306K Feb 18 07:19 m68k-amigaos-ar
-rwxr-xr-x. 2 root root 376K Feb 18 07:19 m68k-amigaos-as
-rwxr-xr-x. 1 root root 362K Feb 18 07:19 m68k-amigaos-c++filt
-rwxr-xr-x. 1 root root 1.1M Feb 18 07:33 m68k-amigaos-cpp
-rwxr-xr-x. 2 root root 1.1M Feb 18 07:33 m68k-amigaos-gcc
-rwxr-xr-x. 2 root root 1.1M Feb 18 07:33 m68k-amigaos-gcc-6.3.1
-rwxr-xr-x. 1 root root  36K Feb 18 07:33 m68k-amigaos-gcc-ar
-rwxr-xr-x. 1 root root  36K Feb 18 07:33 m68k-amigaos-gcc-nm
-rwxr-xr-x. 1 root root  36K Feb 18 07:33 m68k-amigaos-gcc-ranlib
-rwxr-xr-x. 1 root root 749K Feb 18 07:33 m68k-amigaos-gcov
-rwxr-xr-x. 1 root root 674K Feb 18 07:33 m68k-amigaos-gcov-tool
-rwxr-xr-x. 2 root root 588K Feb 18 07:19 m68k-amigaos-ld
-rwxr-xr-x. 2 root root 381K Feb 18 07:19 m68k-amigaos-nm
-rwxr-xr-x. 1 root root 609K Feb 18 07:19 m68k-amigaos-objcopy
-rwxr-xr-x. 1 root root 674K Feb 18 07:19 m68k-amigaos-objdump
-rwxr-xr-x. 2 root root 306K Feb 18 07:19 m68k-amigaos-ranlib
-rwxr-xr-x. 1 root root 221K Feb 18 07:19 m68k-amigaos-readelf
-rwxr-xr-x. 1 root root 276K Feb 18 07:19 m68k-amigaos-size
-rwxr-xr-x. 1 root root 279K Feb 18 07:19 m68k-amigaos-strings
-rwxr-xr-x. 2 root root 609K Feb 18 07:19 m68k-amigaos-strip
-rwxr-xr-x. 1 root root 153K Feb 18 07:18 sfdc
-rwxr-xr-x. 1 root root   60 Feb 18 07:18 vasm
-rwxr-xr-x. 1 root root 325K Feb 18 07:18 vasmm68k_mot
-rwxr-xr-x. 1 root root 624K Feb 18 07:18 vbccm68k
-rwxr-xr-x. 1 root root  18K Feb 18 07:18 vc
-rwxr-xr-x. 1 root root  50K Feb 18 07:33 vda68k
-rwxr-xr-x. 1 root root 282K Feb 18 07:18 vlink
-rwxr-xr-x. 1 root root  12K Feb 18 07:18 vobjdump
-rwxr-xr-x. 1 root root 7.7K Feb 18 07:18 vprof
```


## Installed version of GCC

```
$ docker run -it m68k-amigaos-bebbo \
/opt/m68k-amigaos/bin/m68k-amigaos-gcc -v
Using built-in specs.
COLLECT_GCC=/opt/m68k-amigaos/bin/m68k-amigaos-gcc
COLLECT_LTO_WRAPPER=/opt/m68k-amigaos/libexec/gcc/m68k-amigaos/6.3.1/lto-wrapper
Target: m68k-amigaos
Configured with: /root/amigaos-cross-toolchain/submodules/gcc-6/configure --prefix=/opt/m68k-amigaos --host=i686-linux-gnu --build=i686-linux-gnu --target=m68k-amigaos --enable-languages=c --enable-version-specific-runtime-libs --disable-libssp --with-headers=/root/amigaos-cross-toolchain/.build-m68k/sources/ixemul-48.2/include
Thread model: single
gcc version 6.3.1 20170217 (GCC)
```


## "Hello world!" Example

```c
#include <proto/exec.h>
#include <proto/dos.h>

int main(int argc, void *argv[])
{
	struct Library *SysBase;
	struct Library *DOSBase;

	SysBase = *((struct Library **)4UL);
	DOSBase = OpenLibrary("dos.library", 0);

	if (DOSBase) {
		Write(Output(), "Hello world!\n", 13);
		CloseLibrary(DOSBase);
	}

	return(0);
}
```


### Compilation

```
$ docker run -v /home/sb:/host -it m68k-amigaos-bebbo \
/opt/m68k-amigaos/bin/m68k-amigaos-gcc \
/host/hello.c -o /host/hello -noixemul
```


### Execution (using Docker-ized FS-USE emulation)

The following assumes that the `hello` executable created in the previous step has been copied to `$HOME/.config/fs-uae/Data/hello` on the host.

```
$ docker run -it \
  -e DISPLAY=$DISPLAY \
  -v /tmp/.X11-unix:/tmp/.X11-unix \
  -v $HOME/.config/fs-uae/:/home/fsuae/config \
  jamesnetherton/fs-uae \
  --amiga_model=A1200 \
  --hard_drive_0=/home/fsuae/config/Harddrives/workbench-311.hdf \
  --hard_drive_1=/home/fsuae/config/Data
```

![Screenshot](screenshot.png)

