
FROM alpine
MAINTAINER Nabeel S <hi@nabs.io>

RUN apk add --update \
  build-base \
  ca-certificates \
  python3-dev \
  python3-dev

RUN pip install --upgrade \
  distribute \
  pip \
  chaperone
  
RUN mkdir -p /etc/chaperone.d
COPY chaperone.conf /etc/chaperone.d/chaperone.conf

# configure the app
RUN mkdir -p $APP_HOME

ENTRYPOINT ["/usr/bin/chaperone"]
