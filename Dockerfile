FROM ubuntu:xenial
MAINTAINER oliver@weichhold.com

# diagnostic stuff
RUN apt-get -y update && apt-get install -y --no-install-recommends curl unzip

ADD https://github.com/vertcoin/vertcoin/releases/download/v0.11.1.0/vertcoin-v0.11.1.0-linux-64bit.zip /tmp/

RUN cd /tmp && unzip *.zip  && cp -r /tmp/* /usr/bin && \
    rm -rf /usr/share/man/* /usr/share/groff/* /usr/share/info/* /var/cache/man/* /tmp/* /var/lib/apt/lists/*

ADD rootfs /
RUN chmod +x /health-check.sh
RUN mkdir /data && chmod 777 /data

EXPOSE 5888 5889
WORKDIR /tmp
ENTRYPOINT vertcoind -server -testnet -datadir=/data -rpcuser=user -rpcpassword=pass -port=5889 -rpcport=5888 -rpcbind=0.0.0.0 -rpcallowip=::/0
