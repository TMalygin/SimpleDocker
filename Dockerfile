FROM ubuntu:16.04

MAINTAINER Anon

ARG USER_UID


RUN echo "dash dash/sh boolean false" | debconf-set-selections && \
    dpkg-reconfigure -p critical dash

RUN apt-get update -y && \
    apt-get install -y software-properties-common && \
    add-apt-repository -y ppa:openjdk-r/ppa && \
    apt-get update -y && \
    apt-get install -y sudo python2.7 python-pip bash busybox-static cpio gawk xz-utils openjdk-7-jdk python git-core gnupg flex bison gperf build-essential nano\
    zip curl zlib1g-dev gcc-multilib g++-multilib libc6-dev-i386\
    lib32ncurses5-dev x11proto-core-dev libx11-dev lib32z-dev ccache \
    libgl1-mesa-dev libxml2-utils xsltproc unzip mtools u-boot-tools \
    htop iotop sysstat iftop pigz bc device-tree-compiler lunzip \
    dosfstools wget && \
    apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* &&\
    pip install atc_thrift atcd django-atc-api django-atc-demo-ui django-atc-profile-storage

#WORKDIR /tmp

# All builds will be done by user aosp
#COPY gitconfig /root/.gitconfig
#COPY ssh_config /root/.ssh/config

# The persistent data
#VOLUME ["/tmp/ccache", "/aosp"]

# Work in the build directory
#WORKDIR /mnt/Other/

#COPY utils/docker_entrypoint.sh /root/docker_entrypoint.sh
#ENTRYPOINT ["/root/docker_entrypoint.sh"]

# Set user
RUN ln -sf bash /bin/sh
RUN useradd -m -U user -G sudo,video --uid $USER_UID
RUN echo "user ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers
WORKDIR /home/user
USER user
ENV USER user


