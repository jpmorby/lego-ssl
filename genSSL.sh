#!/bin/bash

######
## Script by Jon Morby <jon@redmail.com>
## 2022 - Version 0.01
##

# Actions
# =======
# -m mode (run | renew) - default renew
# -h hook
# -e email
# -o output directory
# -d domains.txt 
# -p Provider (see https://go-acme.github.io/lego/dns/ )
# -k rsa2048 | rsa4096 | rsa8192 | ec256 | ec384 (default: ec256)

PATH=/usr/bin:/usr/local/bin:/snap/bin:/usr/local/sbin:${PATH}

# SUPPORTED PROVIDER 
# https://go-acme.github.io/lego/dns/

# env variables
# DEBUG
# LEGO="goacme/lego:v4.9.0"
LEGO="goacme/lego:latest"

# DEFAULT OPTIONS
MODE=renew
PROVIDER=pdns
DOMAIN_LIST=domains.txt
OUTPUT_DIR=/etc/ssl
EMAIL=""

#########################

function showUsage () {
	echo "Request SAN certificates from LetsEncrypt using LEGO in Docker"
	echo "Script by Jon Morby <jon@redmail.com>"
	echo
	echo "$0 [ -m mode ] [ -e email ] [ -h hook-script ] [ -p Provider ] [ -d domains.txt ] [ -o output-directory ] [ -k rsa2048 | rsa4096 | rsa8192 | ec256 | ec384 (default: ec256) ] [ -? ]"
	echo
	echo "	mode = run | renew"
	echo "	hook = script (optional)"
	echo "	email = your email"
	echo "	domains.txt (default)"
	echo "	output-directory (default /etc/ssl)"
	echo "	Provider (default pdns)"
	echo "	-? this help"
	echo
	echo "Reads a file ${DOMAIN_LIST} for the list of domains for the SAN certificate"

	exit 0
}

while getopts "m:h:d:p:k:o:e:?" o; do
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

		o) OUTPUT_DIR=${OPTARG}
			if [[ ! -d ${OUTPUT_DIR} ]];
			then
				echo "Error: Output directory: ${OUTPUT_DIR} doesn't exist.  Please create or check your path"
				exit 1;
			fi
			;;

		e) EMAIL=${OPTARG}
			;;

		*) showUsage
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
	echo "Email: ${EMAIL}"
	echo "Hook: ${HOOK_OPT}"
	echo "Output Directory: ${OUTPUT_DIR}"
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

docker \
	run \
	--rm \
	--env-file ${PROVIDER}.config \
	--volume ${OUTPUT_DIR}:/etc/ssl/lego:rw \
	${LEGO} \
	${DOMAINS} \
	-a -m=${EMAIL} \
	${KEYTYPE_OPT} \
	--dns="${PROVIDER}" \
	--path /etc/ssl/lego \
	--dns.resolvers 1.1.1.1:53 \
	--dns.resolvers 8.8.8.8:53 \
	--dns.resolvers [2606:4700:4700::1111]:53 \
	--dns.resolvers [2606:4700:4700::1001]:53 \
	--pem ${MODE} ${HOOK_OPT}

# --renew-hook="./zimbra.sh"
