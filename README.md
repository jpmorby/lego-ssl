# Lego SSL Script using Docker Lego

./genSSL.sh -d domains.txt -p pdns 

## Options
Option | Description
----- | -----
-m | mode ( run | renew )
-p | provider (default pdns)
-h | hook (script to run upon successful completion)
-d | doains.txt (list of domains)
-e | email
-o | output directory
-d | domains.txt 
-p | Provider (see https://go-acme.github.io/lego/dns/ )
-k | rsa2048 | rsa4096 | rsa8192 | ec256 | ec384 (default: ec256)


## domains.txt

File containing a list of domains, 1 per line to add to the SAN certificate

## provider.config

Config file containing environment variables / secrets for the chosen provider


### pdns.config

```
PDNS_API_KEY=<API KEY>
PDNS_API_URL=<API URL>
```
