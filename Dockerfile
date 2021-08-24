FROM ubuntu:latest

ARG VERSION
ENV VERSION ${VERSION}
ENV INSTALLPATH /bitcoin

WORKDIR /bitcoin

RUN set -x \
    && echo ${VERSION} > $INSTALLPATH/version \
    && downloadUrl="https://bitcoincore.org/bin/bitcoin-core-${VERSION}/bitcoin-${VERSION}-x86_64-linux-gnu.tar.gz" \
    && apt update -qq \
    && apt install -y -qq curl \
    && curl -SsL $downloadUrl -o /tmp/bitcoin.tar.gz \
    && tar zxf --strip-components /tmp/bitcoin.tar.gz 1 -C $INSTALLPATH \
    && rm -f /tmp/bitcoin.tar.gz \
    && ln -fs $INSTALLPATH/bin/* /usr/bin/ \
    && bitcoin-cli -version \

VOLUME /bitcoin/data

EXPOSE 8332 8333 18332 18333

COPY bitcoin.conf /bitcoin/conf/
COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
