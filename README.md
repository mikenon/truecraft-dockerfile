# truecraft-dockerfile
A Dockerfile for building and running TrueCraft

### Info

The Dockerfile is currently based on [mono:4.0.0-onbuild](https://registry.hub.docker.com/_/mono/), which assumes the
Dockerfile is in the root of a project's source.

Place the Dockerfile in the root of the TrueCraft project.

### Building

If you want to tag the image with the git repo's current commit id:

```bash
TAG=`git log --format="%H" -n 1 | cut -c1-10`; docker build -t "truecraft:$TAG" .
```

If not:

    docker build -t truecraft .

### Running

If you used a tag when building replace <TAG> with that tag, if not use "latest".

To keep the server in the foreground and remove the container after it exits use:

    docker run -it --rm -p 25565:25565 truecraft:<TAG>

To run the server in the background use:

    docker run -d -p 25565:25565 truecraft:<TAG>
