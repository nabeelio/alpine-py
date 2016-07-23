#
# Base image I use for Python apps
#

FROM alpine:3.4
MAINTAINER Nabeel S <hi@nabs.io>

ENV APP_HOME /opt

RUN apk add --update build-base ca-certificates python3 python3-dev

RUN cd /usr/bin \
  && ln -sf python3.5 python \
  && ln -sf pip3.5 pip
  
RUN pip install --upgrade \
  distribute \
  pip \
  chaperone
  
RUN mkdir -p /etc/chaperone.d
COPY scripts/chaperone.conf /etc/chaperone.d/chaperone.conf

# configure the app
RUN mkdir -p $APP_HOME
WORKDIR $APP_HOME

ONBUILD COPY . $APP_HOME
ONBUILD RUN pip install -r requirements.txt

ENTRYPOINT ["/usr/bin/chaperone"]
