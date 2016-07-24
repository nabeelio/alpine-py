#
# Base image I use for Python apps
#

FROM alpine:3.4
MAINTAINER Nabeel S <hi@nabs.io>

ENV APP_HOME /opt

RUN echo "App home: $APP_HOME"

RUN apk add --update build-base ca-certificates python3 python3-dev

RUN cd /usr/bin \
  && ln -sf python3.5 python \
  && ln -sf pip3.5 pip
  
RUN pip install --upgrade \
  distribute \
  pip \
  chaperone \
  wheel>0.25.0 \
  pycrypto==2.6.1 \
  pyyaml==3.11 \
  pytest==2.9.2 \
  sortedcontainers==1.5.3

RUN mkdir -p /etc/chaperone.d

RUN mkdir -p $APP_HOME
ONBUILD WORKDIR $APP_HOME

ONBUILD COPY . $APP_HOME
ONBUILD RUN pip install -r requirements.txt
ONBUILD COPY scripts/chaperone.conf /etc/chaperone.d/chaperone.conf

ENTRYPOINT /usr/bin/chaperone --force
