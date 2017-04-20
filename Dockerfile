FROM debian:jessie

RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y \
        autoconf automake autopoint bash bison bzip2 cmake flex \
        gettext git g++ gperf intltool libffi-dev libgdk-pixbuf2.0-dev \
        libtool libltdl-dev libssl-dev libxml-parser-perl make openssl \
        p7zip-full patch perl pkg-config python ruby scons sed \
        unzip wget xz-utils g++-multilib libc6-dev-i386 libtool-bin && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

ARG MXE_TARGETS="x86_64-w64-mingw32.shared"
ARG PACKAGES="gcc cmake qt qt5"

RUN cd /opt/ && \
    git clone https://github.com/mxe/mxe.git && \
    cd mxe && \
    make -j$(nproc) $PACKAGES MXE_TARGETS="$MXE_TARGETS"
    
# set PATH
ENV PATH /opt/mxe/usr/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin

