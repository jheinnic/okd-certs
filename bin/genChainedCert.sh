#!/bin/sh

if ! INSTALL_DIR="$(dirname $(dirname $(realpath "${0}")))"
then
        echo "Cannot locate installation dir relative to ${0}"
        exit -2
fi

SIGNER_DIR="${INSTALL_DIR}/authorities/${1}"
if [ ! -d ${SIGNER_DIR} ]
then
        echo "${SIGNER_DIR} does not exist as a directory"
	exit -3
fi

SIGNED_DIR="${INSTALL_DIR}/authorities/${2}"
if [ ! -d ${SIGNED_DIR} ]
then
        echo "${SIGNED_DIR} does not exist as a directory"
	exit -4
fi

if ! DAYS_SIGNED="$(cat "${SIGNER_DIR}/certExpiryDays")"
then
	echo "Problem reading certExpiryDays from signer"
	exit -5
fi

openssl req -config "${SIGNED_DIR}/openssl.cnf" -new -sha256 \
	-newkey rsa:2048 -key "${SIGNED_DIR}/private/ca.key.pem" \
	-out "${SIGNED_DIR}/csr/ca.csr.pem"

openssl ca -config "${SIGNER_DIR}/openssl.cnf" \
      -extensions v3_intermediate_ca \
      -days ${DAYS_SIGNED} -notext -md sha256 \
      -in "${SIGNED_DIR}/csr/ca.csr.pem" \
      -keyfile "${SIGNED_DIR}/private/ca.key.pem" \
      -out "${SIGNED_DIR}/certs/ca.cert.pem"

chmod 644 "${SIGNED_DIR}/certs/ca.cert.pem"

openssl x509 -noout -text -in "${SIGNED_DIR}/certs/ca.cert.pem"

cat     "${SIGNER_DIR}/certs/ca.cert.pem" \
	"${SIGNER_DIR}/certs/ca-chain.cert.pem" > \
	"${SIGNED_DIR}/certs/ca-chain.cert.pem"

chmod 644 "${SIGNED_DIR}/certs/ca-chain.cert.pem"
