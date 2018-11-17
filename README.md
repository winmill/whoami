# whoami multi-arch image

[![Build status](https://ci.appveyor.com/api/projects/status/00kox7yldxe9xpg2?svg=true)](https://ci.appveyor.com/project/BillMilleker/whoami)
[![This image on DockerHub](https://img.shields.io/docker/pulls/winmill/whoami.svg)](https://hub.docker.com/r/winmill/whoami/)

Simple HTTP docker service that prints it's container ID - for (almost) any Docker platform

## CI pipeline

![CI pipeline with Travis and AppVeyor](images/pipeline.png)

* AppVeyor CI
  * Matrix build for several Linux architectures
    * linux/amd64
    * linux/arm
    * linux/arm64
  * Build Windows image for nanoserver 2016 SAC
    * windows/amd64 10.0.14393.x
    * Rebase this image to nanoserver:1709 SAC
      * windows/amd64 10.0.16299.x
    * Rebase this image to nanoserver:1803 SAC
      * windows/amd64 10.0.17134.x
    * Rebase this image to nanoserver:1809 SAC
      * windows/amd64 10.0.17763.x
  * Wait for all images to be on Docker Hub
  * Create and push the manifest list
    * preview of `docker manifest` command

## Linux

    $ docker run -d -p 8080:8080 --name whoami -t stefanscherer/whoami
    736ab83847bb12dddd8b09969433f3a02d64d5b0be48f7a5c59a594e3a6a3541

    $ curl http://localhost:8080
    I'm 736ab83847bb running on linux/amd64

## Windows

    $ docker run -d -p 8080:8080 --name whoami -t stefanscherer/whoami
    736ab83847bb12dddd8b09969433f3a02d64d5b0be48f7a5c59a594e3a6a3541

    $ (iwr http://$(docker inspect -f '{{ .NetworkSettings.Networks.nat.IPAddress }}' whoami):8080 -UseBasicParsing).Content
    I'm 736ab83847bb on windows/amd64

Used for a first
[swarm-mode demo](https://github.com/StefanScherer/docker-windows-box/tree/master/swarm-mode)
with Windows containers.

## Query all supported platforms

```
$ docker run --rm mplatform/mquery stefanscherer/whoami
Image: stefanscherer/whoami
 * Manifest List: Yes
 * Supported platforms:
   - linux/amd64
   - linux/arm/v6
   - linux/arm64/v8
   - windows/amd64:10.0.14393.2248
   - windows/amd64:10.0.16299.431
   - windows/amd64:10.0.17134.48
```
