# truecraft-dockerfile
A Dockerfile for building and running [TrueCraft](https://github.com/SirCmpwn/TrueCraft)

## Info

To install docker check out [these instructions](https://docs.docker.com/installation/).

The Dockerfile is currently based on [mono:4.0.0](https://registry.hub.docker.com/_/mono/)

## Building

```bash
git clone https://github.com/mikenon/truecraft-dockerfile.git
cd truecraft-dockerfile
docker build -t truecraft .
```

## Running

### start.sh

start.sh has three commands: get, build, and run. It also uses a few environment variables to control those commands.

### examples

```
docker run -it --rm -p 25565:25565 truecraft /start.sh --help
start.sh - TrueCraft Docker utility

Commands:
-h | --help:  Display help
get:          Clone the TrueCraft repository Env var 'force_get' must be
              present to overwrite not-empty /src
build:        Invokes nuget and xbuild in /src. Stores output in /target
run:          Invokes mono against /target/TrueCraft.exe

Environment Variables:
Name                 Default              Current
DIR_SRC              /src                 /src
DIR_TARGET           /target              /target
DIR_DATA             /data                /data
URL_REPO             git://github.com/SirCmpwn/TrueCraft.git git://github.com/SirCmpwn/TrueCraft.git
GET_FORCE
BUILDTYPE            Release              Release
NAME_EXE             TrueCraft.exe        TrueCraft.exe
```


    docker run -it --rm -p 25565:25565 truecraft /start.sh get build run

This will clone the TrueCraft repository, build the source, and start the server.

You can use docker volumes to use your local files.

If you've already cloned TrueCraft and want to use your files instead of cloning it again and you want to save the results of running nuget and xbuild use:

    docker run -it --rm -p 25565:25565 -v /path/to/src:/src -v /path/to/target:/target  truecraft /start.sh build

If you've already built TrueCraft and want to run it use:

    docker run -it --rm -p 25565:25565 -v /path/to/target:/target -v /path/to/data:/data truecraft /start.sh run

The example commands have used "-it --rm" to keep the output in the foreground and remove the container when it closes. If you want to run in the background replace them with "-d"

    docker run -d -p 25565:25565 ...
