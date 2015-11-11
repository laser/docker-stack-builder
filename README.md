
## Overview

NOTE: The image has moved to: https://registry.hub.docker.com/u/laser/stack-builder/

This is a quick attempt to get Stack (wrapping GHC and Cabal) into a Docker
image.

The base image is Debian Linux. I would like to replace this with Alpine (or
something similarly small) in the future.

## Layout

Stack is downloaded from GitHub as a gzipped tarball and is in: `/opt/bin`

`PATH` is updated to include: `/opt/bin` so `stack` will be in the PATH by
default.

`WORKDIR` is set to `/src` so if you `-v` mount your local directory to `/src`
you can run the compiler directly without changing directory first.

## Usage

By using the `-v` flag with `docker run` you can use this image to compile your
Haskell sources without a local Stack installation.  For example, to create and
compile a Stack project:

    stack new demo-project simple

    cd demo-project

    docker run --rm -v `pwd`/.stack:/root/.stack -v `pwd`:/src laser/stack-builder sh -c 'stack setup && stack build'

This will produce a binary in `.stack-work` which too can be run via Stack in
container:

    docker run --rm -v `pwd`/.stack:/root/.stack -v `pwd`:/src laser/stack-builder stack exec demo-project
