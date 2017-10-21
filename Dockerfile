FROM ubuntu:xenial
MAINTAINER oliver@weichhold.com

# diagnostic stuff
RUN apt-get -y update && apt-get install -y --no-install-recommends curl

ADD https://github.com/monacoinproject/monacoin/releases/download/monacoin-0.14.2/monacoin-0.14.2-x86_64-linux-gnu.tar.gz /tmp/

RUN cd /tmp && tar xvf monacoin-0.14.2-x86_64-linux-gnu.tar.gz && cp -r /tmp/monacoin*/bin/* /usr/bin && \
    rm -rf /usr/share/man/* /usr/share/groff/* /usr/share/info/* /var/cache/man/* /tmp/* /var/lib/apt/lists/*

ADD rootfs /
RUN chmod +x /health-check.sh
RUN mkdir /data && chmod 777 /data

EXPOSE 9402 9401
WORKDIR /tmp
ENTRYPOINT monacoind -server -testnet -datadir=/data -rpcuser=user -rpcpassword=pass -port=9401 -rpcport=9402 -rpcbind=0.0.0.0 -rpcallowip=::/0
