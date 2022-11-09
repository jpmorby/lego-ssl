#!/bin/bash

######
## Script by Jon Morby <jon@redmail.com>
## 2022 - Version 0.01
##

# Actions
# =======
# -m mode (run | renew) - default renew
# -h hook
# -d domains.txt 
# -p Provider (see https://go-acme.github.io/lego/dns/ )

PATH=/usr/bin:/usr/local/bin:/snap/bin:/usr/local/sbin:${PATH}

# SUPPORTED PROVIDER 
# https://go-acme.github.io/lego/dns/

# env variables
# DEBUG

# DEFAULT OPTIONS
MODE=renew
PROVIDER=pdns
DOMAIN_LIST=domains.txt

#########################

function showUsage () {
	echo "Request SAN certificates from LetsEncrypt using LEGO in Docker"
	echo "Script by Jon Morby <jon@redmail.com>"
	echo
	echo "$0 [ -m mode ] [ -h hook-script ] [ -p Provider ] [ -d domains.txt ] [ -k rsa2048 | rsa4096 | rsa8192 | ec256 | ec384 (default: ec256) ] [ -? ]"
	echo
	echo "	mode = run | renew"
	echo "	hook = script (optional)"
	echo "	domains.txt (default)"
	echo "	Provider (default pdns)"
	echo "	-? this help"
	echo
	echo "Reads a file ${DOMAIN_LIST} for the list of domains for the SAN certificate"

	exit 0
}

while getopts "m:h:d:p:k:?" o; do
	case "${o}" in
		d) DOMAIN_LIST=${OPTARG}
			;;

		h) HOOK=${OPTARG}
			;;

		m) MODE=${OPTARG}
			;;

		p) PROVIDER=${OPTARG}
			;;

		k) KEY=${OPTARG}
			;;

		*) echo showUsage
			;;
	esac
done


if [[ ${KEY} != "" ]];
then 
	KEYTYPE_OPT="--key-type ${KEY}"
fi

if [[ ${MODE} == "renew" ]];
then
	if [[ ${HOOK} != "" ]]; then
		HOOK_OPT="--renew-hook=${HOOK}"
	fi
fi


if [[ ${DEBUG} == 1 ]];
then
	echo "Mode: ${MODE}"
	echo "Hook: ${HOOK_OPT}"
	echo "Domain List: ${DOMAIN_LIST}"
	echo "Provider: ${PROVIDER}"
	echo "Key Type: ${KEYTYPE_OPT}"
	exit 0
fi

DOMAINS=$(
for dom in `cat ${DOMAIN_LIST}`
do
        echo "-d $dom "
done
)

sudo	docker run \
	--env-file ${PROVIDER}.config \
	--volume /etc/ssl:/etc/ssl \
	goacme/lego \
	${DOMAINS} \
	-a -m="jon@redmail.com" \
	${KEYTYPE_OPT} \
	--dns="${PROVIDER}" \
	--path /etc/ssl \
	--pem ${MODE} ${HOOK_OPT}

# --renew-hook="./zimbra.sh"
