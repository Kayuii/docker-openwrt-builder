# Docker OpenWrt Builder

Build [OpenWrt](https://openwrt.org/) images in a Docker container. This is sometimes necessary when building OpenWrt on the host system fails, e.g. when some dependency is too new. The docker image is based on ubuntu 20.04 (focal).

Build tested:

- OpenWrt-21.02.3
- OpenWrt-19.07.10
- OpenWrt-18.06.9

A smaller container based on Alpine Linux is available in the alpine branch. But it does not build the old LEDE images.

## Prerequisites

* Docker installed
* running Docker daemon
* build Docker image:

```
git clone https://github.com/kayuii/docker-openwrt-builder.git
cd docker-openwrt-builder
docker build -t openwrt_builder .
```

Now the docker image is available. These steps only need to be done once.

## Usage GNU/Linux

Create a build folder and link it into a new docker container:
```
mkdir ~/mybuild
docker run -v ~/mybuild:/home/ubuntu -it openwrt_builder /bin/bash
```
or
```
mkdir ~/mybuild
docker run --rm -d --name openwrt_builder -p 22022:22 -v ~/mybuild:/home/ubuntu openwrt_builder
docker exec -it openwrt_builder /bin/bash
```
import key
```
mkdir .ssh
echo "your pubkey" >> ~/.ssh/authorized_keys
chmod 0600 ~/.ssh/authorized_keys
```

ssh
```
ssh ubuntu@127.0.0.1 -p 22022
```

In the container console, enter:
```
git clone https://git.openwrt.org/openwrt/openwrt.git
cd openwrt
./scripts/feeds update -a
./scripts/feeds install -a
make menuconfig
make -j4
```

After the build, the images will be inside `~/mybuild/openwrt/bin/target/`.


## Other Projects

Other, but very similar projects:
* [docker-openwrt-builder](https://github.com/mwarning/docker-openwrt-builder)
* [docker-dropbear](https://github.com/simonswine/docker-dropbear)
* [docker-openwrt-buildroot](https://github.com/noonien/docker-openwrt-buildroot)
* [openwrt-docker-toolchain](https://github.com/mchsk/openwrt-docker-toolchain)
