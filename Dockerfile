FROM ubuntu:latest

ARG BUILD_DATE
ARG VERSION
ENV VERSION ${VERSION}
ENV INSTALLPATH /bitcoin

LABEL fullnode.version=$VERSION
LABEL fullnode.build_date=$BUILD_DATE
LABEL fullnode.build_cmd="docker build --force-rm --no-cache --build-arg BUILD_DATE=$(TZ=UTC-8 date +'%Y-%m-%d-%H:%M:%S') --build-arg VERSION=$VERSION -t fullnode/bitcoin:$VERSION -f ./Dockerfile ."
LABEL fullnode.mainnet.run_cmd="docker run -itd --rm --name bitcoin-mainnet -v /data/bitcoin:/bitcoin/data -p 8332:8332 -p 8333:8333 fullnode/bitcoin:${VERSION}"
LABEL fullnode.testnet.run_cmd="docker run -itd --rm --name bitcoin-testnet -v /data/bitcoin:/bitcoin/data -p 18332:18332 -p 18333:18333 fullnode/bitcoin:${VERSION} testnet"

WORKDIR /bitcoin

RUN set -x \
    && echo ${VERSION} > $INSTALLPATH/version \
    && downloadUrl="https://bitcoincore.org/bin/bitcoin-core-${VERSION}/bitcoin-${VERSION}-x86_64-linux-gnu.tar.gz" \
    && apt update -qq \
    && apt install -y -qq curl \
    && curl -SsL $downloadUrl | tar zx --strip-components 1 -C $INSTALLPATH \
    && ln -fs $INSTALLPATH/bin/* /usr/bin/ \
    && bitcoin-cli -version \

VOLUME /bitcoin/data

EXPOSE 8332 8333 18332 18333

COPY bitcoin.conf /bitcoin/conf/
COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
