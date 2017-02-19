# Dockerfile for AmigaOS Cross-Compiler Toolchain

`Dockerfile` for [Stefan "Bebbo" Franke](https://github.com/bebbo)'s [fork](https://github.com/bebbo/amigaos-cross-toolchain) of [Krystian Bacławski](https://github.com/cahirwpz)'s [AmigaOS Cross-Compiler Toolchain](https://github.com/cahirwpz/amigaos-cross-toolchain).


## Creating the image

```
$ docker build -t m68k-amigaos-bebbo .
```

## "Hello world!" Example

### AmigaOS Style

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


### POSIX Style

```c
#include <stdio.h>

int main()
{
    printf("Hello world!\n");

    return(0);
}
```


### Compilation

```
$ docker run -v /home/sb:/host -it m68k-amigaos-bebbo \
/opt/m68k-amigaos/bin/m68k-amigaos-gcc \
/host/hello.c -o /host/hello -noixemul
```


### Execution (using Docker-ized FS-UAE emulation)

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

