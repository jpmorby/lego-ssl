all: morby home push
install: push

morby:
	./morby.sh

home:
	./home.sh

push: push-lb push-all push-wazuh push-zabbix push-proxmox
	# ./push.sh
	@echo ... done

push-lb:
	./push-lb.yml

push-all:
	./push-all.yml

push-wazuh:
	./push-wazuh.yml

push-zabbix:
	./push-zabbix.yml

push-proxmox:
	./push-proxmox.yml