#
# Minimum Docker image to build Android AOSP
#
FROM ubuntu:18.04

MAINTAINER Turbine Yan <yanb@newlandpayment.com>



# Keep the dependency list as short as reasonable

# RUN dpkg --add-architecture i386 && \
#     apt-get update && \
#     apt-get install -y git-core gnupg flex bison gperf build-essential \
#     zip curl zlib1g-dev gcc-multilib g++-multilib libc6-dev-i386 \
#     lib32ncurses5-dev x11proto-core-dev libx11-dev lib32z-dev \
#     libgl1-mesa-dev libxml2-utils xsltproc unzip bc lzop genisoimage

RUN dpkg --add-architecture i386 && \
    apt update && \
    apt install -y git ccache \
    lzop bison gperf build-essential zip \
    curl zlib1g-dev g++-multilib python-networkx \
    libxml2-utils bzip2 libbz2-dev libghc-bzlib-dev \
    squashfs-tools pngcrush liblz4-tool optipng libc6-dev-i386 \
    gcc-multilib libssl-dev gnupg flex lib32ncurses5-dev x11proto-core-dev \
    libx11-dev lib32z1-dev libgl1-mesa-dev xsltproc unzip python-pip python-dev \
    libffi-dev libxml2-dev libxslt1-dev libjpeg8-dev

RUN apt install -y openjdk-8-jdk
RUN apt install -y python

# Install latest version of JDK
# See http://source.android.com/source/initializing.html#setting-up-a-linux-build-environment
WORKDIR /tmp

# The persistent data will be in these two directories, everything else is
# considered to be ephemeral
VOLUME ["/tmp/ccache", "/aosp"]

# Improve rebuild performance by enabling compiler cache
ENV USE_CCACHE 1
ENV CCACHE_DIR /tmp/ccache

# Work in the build directory, repo is expected to be init'd here
WORKDIR /aosp

# COPY utils/docker_entrypoint.sh /root/docker_entrypoint.sh
# ENTRYPOINT ["/root/docker_entrypoint.sh"]
