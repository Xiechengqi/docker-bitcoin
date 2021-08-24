#!/usr/bin/env bash

#
# xiechengqi
# 2021/08/24
#

source /etc/profile
BASEURL="https://gitee.com/Xiechengqi/scripts/raw/master"
source <(curl -SsL $BASEURL/tool/common.sh)

latest_version=$(curl -SsL https://bitcoin.org/en/download | grep 'Latest version:' | awk '{print $NF}')

INFO "docker build -t fullnode/bitcoin:${latest_version} --build-arg VERSION=${latest_version} ."
docker build -t fullnode/bitcoin:${latest_version} --build-arg VERSION=${latest_version} . || exit 1
EXEC "docker tag fullnode/bitcoin:${latest_version} fullnode/bitcoin:latest"
EXEC "docker push fullnode/bitcoin:${latest_version}"
EXEC "docker push fullnode/bitcoin:latest"
