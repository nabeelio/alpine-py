#
# Base image I use for Python apps
#

FROM alpine:3.4
MAINTAINER Nabeel S <hi@nabs.io>

RUN apk add --update build-base ca-certificates python3 python3-dev ffmpeg

RUN cd /usr/bin \
  && ln -sf python3.5 python \
  && ln -sf pip3.5 pip

# for numpy install
RUN ln -s /usr/include/locale.h /usr/include/xlocale.h

RUN pip install --no-cache-dir --upgrade \
  pip \
  wheel>0.25.0 \
  distribute \
  chaperone \
  numpy==1.12.0 \
  pycrypto==2.6.1 \
  pyyaml==3.11 \
  pytest==2.9.2 \
  sortedcontainers==1.5.3

RUN mkdir -p /etc/chaperone.d
RUN rm -rf /tmp/*
RUN rm -rf /var/cache/*
