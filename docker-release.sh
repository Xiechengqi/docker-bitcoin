#!/usr/bin/env bash

#
# xiechengqi
# 2021/08/24
#

source /etc/profile
BASEURL="https://gitee.com/Xiechengqi/scripts/raw/master"
source <(curl -SsL $BASEURL/tool/common.sh)

EXEC "cd $(dirname $(readlink -f ${BASH_SOURCE[0]}))"
latest_tag=$(curl -SsL https://api.github.com/repos/ethereum/go-ethereum/releases | grep tag_name | head -1 | awk -F '"' '{print $(NF-1)}')
latest_commit=$(curl -SsL https://api.github.com/repos/ethereum/go-ethereum/commits/${latest_tag} | grep sha | head -1 | awk -F '"' '{print $(NF-1)}' | cut -c 1-8)
EXEC "latest_version='${latest_tag}-${latest_commit}'"

INFO "docker build -t fullnode/bitcoin:${latest_version} --build-arg VERSION=${latest_version} ."
docker build -t fullnode/bitcoin:${latest_version} --build-arg VERSION=${latest_version} .
EXEC "docker tag fullnode/bitcoin:${latest_version} fullnode/bitcoin:latest"
EXEC "docker push fullnode/bitcoin:${latest_version}"
EXEC "docker push fullnode/bitcoin:latest"
