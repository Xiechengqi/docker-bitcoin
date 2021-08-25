#!/usr/bin/env bash

#
# xiechengqi
# 2021/08/24
#

source /etc/profile
BASEURL="https://gitee.com/Xiechengqi/scripts/raw/master"
source <(curl -SsL $BASEURL/tool/common.sh)

latest_version=$(curl -SsL https://bitcoin.org/en/download | grep 'Latest version:' | awk '{print $NF}')
# curl -SsL https://registry.hub.docker.com/v1/repositories/fullnode/bitcoin/tags | grep ${latest_version} &> /dev/null && exit 0

INFO "docker build --force-rm --no-cache --build-arg BUILD_DATE=$(date -u +'%Y-%m-%dT%H:%M:%SZ') --build-arg VERSION=${latest_version} -t fullnode/bitcoin:${latest_version} -f ./Dockerfile ."
docker build --force-rm --no-cache --build-arg BUILD_DATE="China-$(TZ=UTC-8 date +'%Y-%m-%dT%H:%M:%SZ')" --build-arg VERSION=${latest_version} -t fullnode/bitcoin:${latest_version} -f ./Dockerfile . || exit 1
EXEC "docker tag fullnode/bitcoin:${latest_version} fullnode/bitcoin:latest"
EXEC "docker push fullnode/bitcoin:${latest_version}"
EXEC "docker push fullnode/bitcoin:latest"
