#!/bin/bash

# Actions
# =======
# $1 - run | renew
# $2 - hook
#

# env variables
# DEBUG

PROVIDER=pdns
DOMAINS=domains.txt

function showUsage {
	echo "Request SAN certificates from LetsEncrypt using LEGO in Docker"
	echo "Script by Jon Morby <jon@redmail.com>"
	echo
	echo "$0 mode hook-script"
	echo
	echo "	mode = run | renew"
	echo "	hook = script (optional)"
	echo
	echo "Reads a file 'domains.txt' for the list of domains for the SAN certificate"

	exit 0
}

if [ -z ${1} ];
then
	MODE=run
else
	MODE=renew
fi

if [[ ${1} == "-h" ]];
then
	showUsage;
fi

if [ "X${2}" != "X" ];
then
	HOOK="--renew-hook=${2}"
fi


if [ ${DEBUG} ];
then
	echo "Mode: ${MODE}"
	echo "Hook: ${HOOK}"
	exit 0
fi

DOMAINS=$(
for dom in `cat domains.txt`
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
	--dns="${PROVIDER}" \
	--path /etc/ssl \
	--pem ${MODE} ${HOOK}

# --renew-hook="./zimbra.sh"
