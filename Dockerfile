FROM ubuntu:latest

ARG VERSION
ENV VERSION ${VERSION}
ENV CHAINID mainnet
ENV INSTALLPATH /bitcoin

RUN set -x \
    && downloadUrl="https://bitcoincore.org/bin/bitcoin-core-${VERSION}/bitcoin-${VERSION}-x86_64-linux-gnu.tar.gz" \
    && apt update \
    && apt install -y curl \
    && mkdir -p $INSTALLPATH/conf \
    && mkdir -p $INSTALLPATH/data \
    && curl -SsL $downloadUrl | tar zx --strip-components 1 -C $INSTALLPATH \
    && ln -fs $INSTALLPATH/bin/* /usr/bin/ \
    && bitcoin-cli -version \

COPY ./bitcoin.conf /bitcoin/conf

VOLUME /data

EXPOSE 8332 8333 18332 18333

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
