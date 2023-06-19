#!/bin/sh

if ! INSTALL_DIR="$(dirname $(dirname $(realpath "${0}")))"
then
        echo "Cannot locate installation dir relative to ${0}"
        exit -2
fi

AUTHORITY_DIR="${INSTALL_DIR}/authorities/rootCA"

openssl req -config "${AUTHORITY_DIR}/openssl.cnf" \
	-newkey rsa:4096 -keyout "${AUTHORITY_DIR}/private/ca.key.pem" \
	-out "${AUTHORITY_DIR}/csr/ca.csr.pem"

openssl ca -selfsign -config "${AUTHORITY_DIR}/openssl.cnf" -name ca_default \
	-in "${AUTHORITY_DIR}/csr/ca.csr.pem" -extensions ca_ext \
	-keyfile "${AUTHORITY_DIR}/private/ca.key.pem" \
	-out "${AUTHORITY_DIR}/certs/ca.cert.pem"

rm -f "${AUTHORITY_DIR}/certs/ca-chain.cert.pem" 2>&1
touch "${AUTHORITY_DIR}/certs/ca-chain.cert.pem"
chmod 644 "${AUTHORITY_DIR}/certs/ca.cert.pem"
chmod 644 "${AUTHORITY_DIR}/certs/ca-chain.cert.pem"
