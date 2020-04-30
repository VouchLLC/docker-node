FROM canvouch/ubuntu2004
SHELL ["/bin/bash", "-c"]
WORKDIR /usr/src/app
COPY services /etc/services

ENV DEBIAN_FRONTEND noninteractive
ENV NODE_VERSION 14.0.0

RUN apt-get update

RUN apt-get dist-upgrade --assume-yes

RUN apt-get install --assume-yes --no-install-recommends --no-install-suggests \
    xz-utils 

RUN curl -SLO "http://nodejs.org/dist/v$NODE_VERSION/node-v$NODE_VERSION-linux-x64.tar.gz" \
  && curl -SLO "http://nodejs.org/dist/v$NODE_VERSION/SHASUMS256.txt.asc" \
  && tar -xzf "node-v$NODE_VERSION-linux-x64.tar.gz" -C /usr/local --strip-components=1 \
  && rm "node-v$NODE_VERSION-linux-x64.tar.gz"


RUN apt-get purge --assume-yes --auto-remove \
    --option APT::AutoRemove::RecommendsImportant=false \
    --option APT::AutoRemove::SuggestsImportant=false
RUN rm -rf /var/lib/apt/lists/*

ENV NODE_PATH /usr/lib/node_modules