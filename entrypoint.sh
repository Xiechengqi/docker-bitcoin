#!/usr/bin/env bash

#
# xiechengqi
# 2021/08/24
#

if [ "$1" = "testnet" ]; then
bitcoind -conf=/bitcoin/conf/bitcoin.conf --testnet
else
bitcoind -conf=/bitcoin/conf/bitcoin.conf
fi
