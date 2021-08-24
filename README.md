# docker-bitcoin

* https://github.com/bitcoin/bitcoin

**`fullnode`**

* testnet

``` shell
docker run -itd --rm --name bitcoin-testnet -v /data/bitcoin:/bitcoin/data -p 18332:18332 -p 18333:18333 fullnode/bitcoin:latest testnet
```

* mainnet

``` shell
docker run -itd --rm --name bitcoin-mainnet -v /data/bitcoin:/bitcoin/data -p 8332:8332 -p 8333:8333 fullnode/bitcoin:latest
```


