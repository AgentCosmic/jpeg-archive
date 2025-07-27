FROM debian:12-slim

RUN apt-get update && apt-get install wget build-essential cmake nasm libtool pkg-config libpng-dev -y

RUN wget https://github.com/mozilla/mozjpeg/archive/refs/tags/v4.1.1.tar.gz  && tar xf v4.1.1.tar.gz

RUN cd mozjpeg-4.1.1 \
        && mkdir build && cd build \
        && cmake -G"Unix Makefiles" ..\
        && make && make install

COPY . /jpeg-archive

RUN cd /jpeg-archive \
        && make && make install

# Copy it to the host
# docker run --rm --name ja -itd jpeg-archive bash
# docker cp ja:/usr/local/bin/jpeg-recompress ~/.local/bin
# docker kill ja
# docker image rm jpeg-archive
