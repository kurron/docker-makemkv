FROM ubuntu:18.04

MAINTAINER Ron Kurr <kurr@jvmguy.com>

ENTRYPOINT ["ls -alh /tmp"]

USER root

# For MakeMKV -- https://www.makemkv.com/forum/viewtopic.php?f=3&t=224
RUN apt-get update && \
    apt-get --yes install build-essential \
                          pkg-config \
                          libc6-dev \
                          libssl-dev \
                          libexpat1-dev \
                          libavcodec-dev \
                          libgl1-mesa-dev \
                          libqt4-dev \
                          zlib1g-dev

# For FFMpeg -- https://trac.ffmpeg.org/wiki/CompilationGuide/Ubuntu
RUN apt-get --yes install autoconf \
                          automake \
                          build-essential \
                          cmake \
                          git-core \
                          libass-dev \
                          libfreetype6-dev \
                          libsdl2-dev \
                          libtool \
                          libva-dev \
                          libvdpau-dev \
                          libvorbis-dev \
                          libxcb1-dev \
                          libxcb-shm0-dev \
                          libxcb-xfixes0-dev \
                          pkg-config \
                          texinfo \
                          wget \
                          zlib1g-dev \
                          nasm \
                          libx264-dev \
                          libx265-dev \
                          libnuma-dev \
                          libvpx-dev \
                          libfdk-aac-dev \
                          libmp3lame-dev \
                          libopus-dev


ENV MAKE_MKV_VERSION 1.12.3
ENV FFMPEG_VERSION 4.0.2


ADD http://www.makemkv.com/download/makemkv-bin-${MAKE_MKV_VERSION}.tar.gz /tmp/makemkv-bin-${MAKE_MKV_VERSION}.tar.gz
ADD http://www.makemkv.com/download/makemkv-oss-${MAKE_MKV_VERSION}.tar.gz /tmp/makemkv-oss-${MAKE_MKV_VERSION}.tar.gz
ADD https://ffmpeg.org/releases/ffmpeg-${FFMPEG_VERSION}.tar.bz2 /tmp/ffmpeg-${FFMPEG_VERSION}.tar.bz2

RUN tar --extract --verbose --directory /tmp --file /tmp/makemkv-bin-${MAKE_MKV_VERSION}.tar.gz && \
    rm -f /tmp/makemkv-bin-${MAKE_MKV_VERSION}.tar.gz

RUN tar --extract --verbose --directory /tmp --file /tmp/makemkv-oss-${MAKE_MKV_VERSION}.tar.gz && \
    rm -f /tmp/makemkv-oss-${MAKE_MKV_VERSION}.tar.gz

RUN bunzip2 --verbose /tmp/ffmpeg-${FFMPEG_VERSION}.tar.bz2
RUN tar --extract --verbose --directory /tmp --file /tmp/ffmpeg-${FFMPEG_VERSION}.tar && \
    rm -f /tmp/ffmpeg-${FFMPEG_VERSION}.tar

RUN cd /tmp/makemkv-bin-${MAKE_MKV_VERSION} && \
    make && \
    make install

#RUN cd /tmp/ffmpeg-${FFMPEG_VERSION} && \
#    ./configure --prefix=/tmp/ffmpeg --enable-static --disable-shared --enable-pic --enable-libfdk-aac && \
#    make install && \
#    cd / && \
#    rm -rf /tmp/ffmpeg-${FFMPEG_VERSION}

#USER powerless
