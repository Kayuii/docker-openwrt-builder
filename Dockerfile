FROM ubuntu:20.04

RUN apt-get update &&\
  DEBIAN_FRONTEND="noninteractive" apt-get install -y tzdata

ENV TZ=Asia/Shanghai

RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

RUN apt-get update &&\
    apt-get install -y \
        sudo time git-core subversion build-essential g++ bash make \
        libssl-dev patch libncurses5 libncurses5-dev zlib1g-dev gawk \
        flex gettext wget unzip xz-utils python python-distutils-extra \
        python3 python3-distutils-extra rsync curl libsnmp-dev liblzma-dev \
        libpam0g-dev cpio rsync && \
    apt-get clean && \
    useradd -m ubuntu&& \
    echo 'ubuntu ALL=NOPASSWD: ALL' > /etc/sudoers.d/ubuntu

RUN apt-get update && \
    apt-get install -y \
        ack autopoint bison device-tree-compiler \
        gperf haveged help2man libtool lrzsz \
        pkgconf vim xxd qemu-utils  &&\
    apt-get clean

RUN apt-get update && \
    DEBIAN_FRONTEND="noninteractive" apt-get install -y \
        antlr3 dropbear &&\
    apt-get clean

RUN rm /etc/dropbear/dropbear_dss_host_key /etc/dropbear/dropbear_rsa_host_key

COPY docker-entrypoint.sh /entrypoint.sh

USER ubuntu
WORKDIR /home/ubuntu

# set dummy git config
RUN git config --global user.name "user" && git config --global user.email "user@example.com"

ENTRYPOINT ["/entrypoint.sh"]

CMD ["dropbear"]
