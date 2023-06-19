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

mkdir "${AUTH_DIR}/certs" "${AUTH_DIR}/crl" "${AUTH_DIR}/newcerts" "${AUTH_DIR}/private" "${AUTH_DIR}/csr"
echo 1000 > "${AUTH_DIR}/crlnumber"
# echo 1000 > "${AUTH_DIR}/serial"
openssl rand -hex 16 > "${AUTH_DIR}/serial"
chmod 700 "${AUTH_DIR}/private"
touch "${AUTH_DIR}/index.txt"

