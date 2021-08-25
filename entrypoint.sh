#!/usr/bin/env bash

#
# xiechengqi
# 2021/08/24
#

# check data dir if empty, if not empty return error
[ "$(ls -A /bitcoin/data)" != "" ] && echo "ERROR: /bitcoin/data is not empty, Please backup it first and remove all old data" && exit 1

if [ "$1" = "testnet" ]; then
bitcoind -conf=/bitcoin/conf/bitcoin.conf --testnet
else
bitcoind -conf=/bitcoin/conf/bitcoin.conf
fi
