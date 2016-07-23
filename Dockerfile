#
# Base image I use for Python apps
#

FROM alpine:3.4
MAINTAINER Nabeel S <hi@nabs.io>

RUN apk add --update \
  build-base \
  ca-certificates \
  python3-dev \
  python3-pip

RUN pip install --upgrade \
  distribute \
  pip \
  chaperone
  
RUN mkdir -p /etc/chaperone.d
COPY chaperone.conf /etc/chaperone.d/chaperone.conf

# configure the app
RUN mkdir -p $APP_HOME
WORKDIR $APP_HOME
ONBUILD COPY . $APP_HOME
ONBUILD RUN pip install -r requirements.txt

ENTRYPOINT ["/usr/bin/chaperone"]
