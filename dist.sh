#!/bin/bash
cd ssl/certificates
rsync -arv redmail.com.* root@lb-1.server.morby.net:/etc/loadbalancer.org/certs/_.morby.org
rsync -arv redmail.com.* root@lb-2.server.morby.net:/etc/loadbalancer.org/certs/_.morby.org
rsync -arv redmail.com.* root@web-1.server.morby.net:/etc/ssl/certificates
