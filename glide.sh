#!/bin/bash
# Generate Fido Glide SSL Certificates
#
./genSSL.sh -m renew -d glide.txt -k rsa2048 -e jon@fido.net -o /etc/ssl
