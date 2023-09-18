#!/bin/bash

if ! INSTALL_DIR="$(dirname $(dirname $(realpath "${0}")))"
then
        echo "Cannot locate installation dir relative to ${0}"
        exit -2
fi

AUTH_DIR="${INSTALL_DIR}/authorities/${1}"
if [ ! -d ${AUTH_DIR} ]
then
        echo "${AUTH_DIR} does not exist as a directory"
	exit -3
fi

KEY_SIZE="${2:-2048}"

openssl genrsa -out "${AUTH_DIR}/private/ca.key.pem" "${KEY_SIZE}" 
chmod 400 "${AUTH_DIR}/private/ca.key.pem"

