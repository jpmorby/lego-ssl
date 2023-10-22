#!/bin/bash
cd ssl/certificates
chmod 0644 redmail.*
rsync -harvP redmail.com.pem root@lb-1.server.morby.net:/etc/loadbalancer.org/certs/redmail/redmail.pem
rsync -arvP redmail.com.pem root@lb-2.server.morby.net:/etc/loadbalancer.org/certs/redmail/redmail.pem
# scp redmail.com.pem root@lb.morby.org:/etc/ssl/redmail/redmail.pem
rsync -arvP redmail.com.* root@lb-1.server.morby.net:/etc/loadbalancer.org/certs/_.morby.org
rsync -arvP redmail.com.* root@lb-2.server.morby.net:/etc/loadbalancer.org/certs/_.morby.org
rsync -arvP redmail.com.* root@web-1.server.morby.net:/etc/ssl/certificates
rsync -arvP redmail.com.pem redmail.com.issuer.crt root@chas.server.morby.net:/etc/ssl

rsync morby.org.pem root@lb.morby.org:/etc/loadbalancer.org/certs/_.morby.net/_.morby.net.pem
rsync morby.org.pem root@lb.morby.org:/etc/loadbalancer.org/certs/_.morby.org/_.morby.org.pem
rsync morby.org.pem root@lb.morby.org:/etc/loadbalancer.org/certs/morbysan/morbysan.pem
# rsync -4 redmail.com.pem root@91.235.44.100:/etc/loadbalancer.org/certs/_.morby.net/_.morby.net.pem
# rsync -4 redmail.com.pem root@91.235.44.100:/etc/loadbalancer.org/certs/_.morby.org/_.morby.org.pem
# rsync -4 redmail.com.pem root@91.235.44.100:/etc/loadbalancer.org/certs/morbysan/morbysan.pem

chmod 0644 morby.*
rsync -arvP morby.org.pem root@bin.morby.org:/etc/ssl

