FROM debian:10-slim

RUN apt-get -y update && apt-get install -y --no-install-recommends curl unzip

ADD https://github.com/vertcoin-project/vertcoin-core/releases/download/0.17.1/vertcoind-v0.17.1-linux-amd64.zip /tmp/

RUN cd /tmp && unzip *.zip && cp -r /tmp/vert* /usr/bin && \
    rm -rf /usr/share/man/* /usr/share/groff/* /usr/share/info/* /var/cache/man/* /tmp/* /var/lib/apt/lists/*

EXPOSE 5888
WORKDIR /tmp
ENTRYPOINT vertcoind -server -testnet -datadir=/data -printtoconsole -rpcuser=user -rpcpassword=pass -rpcport=5888 -rpcbind=0.0.0.0 -rpcallowip=::/0 $EXTRA_OPTIONS
