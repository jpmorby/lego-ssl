# Lego SSL Script using Docker Lego

./genSAN.sh -d domains.txt -p pdns 

## Options
-m mode ( run | renew )
-p provider (default pdns)
-h hook (script to run upon successful completion)
-d doains.txt (list of domains)

## domains.txt
File containing a list of domains, 1 per line to add to the SAN certificate

## provider.config
Config file containing environment variables / secrets for the chosen provider


