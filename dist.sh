#!/bin/bash -x
cd ssl/certificates
chmod 0644 redmail.*
rsync -hqarP redmail.com.pem root@lb-1.server.morby.net:/etc/loadbalancer.org/certs/redmail/redmail.pem
rsync -qarP redmail.com.pem root@lb-2.server.morby.net:/etc/loadbalancer.org/certs/redmail/redmail.pem
# scp redmail.com.pem root@lb.morby.org:/etc/ssl/redmail/redmail.pem
rsync -qarP redmail.com.pem root@lb-1.server.morby.net:/etc/loadbalancer.org/certs/_.morby.org
rsync -qarP morby.org.pem root@lb-1.server.morby.net:/etc/loadbalancer.org/certs/_.morby.org
rsync -qarP redmail.com.pem root@lb-2.server.morby.net:/etc/loadbalancer.org/certs/_.morby.org
rsync -qarP morby.org.pem root@lb-2.server.morby.net:/etc/loadbalancer.org/certs/_.morby.org
rsync -qarP morby.org.pem root@lb-3.server.morby.net:/etc/ssl/certificates
rsync -qarP redmail.com.pem root@lb-3.server.morby.net:/etc/ssl/certificates
rsync -qarP redmail.com.* root@web-1.server.morby.net:/etc/ssl/certificates
rsync -qarP redmail.com.pem redmail.com.issuer.crt root@chas.server.morby.net:/etc/ssl
rsync -qarP morby.org.pem redmail.com.pem root@devops.eng.morby.net:/etc/ssl/certificates
rsync -qarP morby.org.pem redmail.com.pem root@192.168.12.50:/etc/ssl/certificates
rsync -qarP morby.org.pem redmail.com.pem root@www-1.redmail.com:/etc/ssl/certificates
rsync -qarP morby.org.pem redmail.com.pem root@dev.redmail.com:/etc/ssl/certificates
rsync -qarP morby.org.pem redmail.com.pem root@193.195.141.253:/etc/ssl/certificates
rsync -qarP morby.org.pem redmail.com.pem root@stats.redmail.com:/etc/ssl/certificates

rsync morby.org.pem root@lb.morby.org:/etc/loadbalancer.org/certs/_.morby.net/_.morby.net.pem
rsync morby.org.pem root@lb.morby.org:/etc/loadbalancer.org/certs/_.morby.org/_.morby.org.pem
rsync morby.org.pem root@lb.morby.org:/etc/loadbalancer.org/certs/morbysan/morbysan.pem
# rsync -4 redmail.com.pem root@91.235.44.100:/etc/loadbalancer.org/certs/_.morby.net/_.morby.net.pem
# rsync -4 redmail.com.pem root@91.235.44.100:/etc/loadbalancer.org/certs/_.morby.org/_.morby.org.pem
# rsync -4 redmail.com.pem root@91.235.44.100:/etc/loadbalancer.org/certs/morbysan/morbysan.pem

chmod 0644 morby.*
rsync -qarP morby.org.pem root@bin.morby.org:/etc/ssl

ssh -l root lb-3.server.morby.net "systemctl reload haproxy.service"
