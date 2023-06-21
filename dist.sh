#!/bin/bash
cd ssl/certificates
rsync -harvP redmail.com.pem root@lb-1.server.morby.net:/etc/loadbalancer.org/certs/redmail/redmail.pem
rsync -arvP redmail.com.pem root@lb-2.server.morby.net:/etc/loadbalancer.org/certs/redmail/redmail.pem
# scp redmail.com.pem root@lb.morby.org:/etc/ssl/redmail/redmail.pem
rsync -arvP redmail.com.* root@lb-1.server.morby.net:/etc/loadbalancer.org/certs/_.morby.org
rsync -arvP redmail.com.* root@lb-2.server.morby.net:/etc/loadbalancer.org/certs/_.morby.org
rsync -arvP redmail.com.* root@web-1.server.morby.net:/etc/ssl/certificates
rsync -arvP redmail.com.pem redmail.com.issuer.crt root@chas.server.morby.net:/etc/ssl
