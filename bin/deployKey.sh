#!/bin/sh

if ! INSTALL_DIR="$(dirname $(dirname $(realpath "${0}")))"
then
        echo "Cannot locate installation dir relative to ${0}"
        exit -2
fi

SIGNER_DIR="${INSTALL_DIR}/authorities/serversCA"
if [ ! -d ${SIGNER_DIR} ]
then
        echo "${SIGNER_DIR} does not exist as a directory"
	exit -3
fi

SIGNED_DIR="${INSTALL_DIR}/deployments/${1}"
if [ -d ${SIGNED_DIR} ]
then
        echo "${SIGNED_DIR} already exists as a directory"
	exit -4
fi

if ! DAYS_SIGNED="$(cat "${SIGNER_DIR}/certExpiryDays")"
then
	echo "Problem reading certExpiryDays from signer"
	exit -5
fi
 
mkdir "${SIGNED_DIR}"
mkdir "${SIGNED_DIR}/certs"
mkdir "${SIGNED_DIR}/private"
mkdir "${SIGNED_DIR}/csr"

openssl genrsa -out "${SIGNED_DIR}/private/ca.key.pem" -nodes 2048
chmod 400 "${SIGNED_DIR}/private/key.pem"

# TODO: Confirm no extensions specified here
openssl req -new -sha256 -nodes \
      -config "${SIGNED_DIR}/openssl.cnf" \
      -key "${SIGNED_DIR}/private/key.pem" \
      -out "${SIGNED_DIR}/csr/csr.pem"

# TODO: Should be an external extension config to set altSubjectNames correctly
openssl ca -config "${SIGNER_DIR}/openssl.cnf" \
      -extensions server_cert \
      -days ${DAYS_SIGNED} -notext -md sha256 \
      -in "${SIGNED_DIR}/csr/csr.pem" \
      -out "${SIGNED_DIR}/certs/cert.pem"

chmod 644 "${SIGNED_DIR}/certs/cert.pem"

openssl x509 -noout -text -in "${SIGNED_DIR}/certs/cert.pem"

cat     "${SIGNER_DIR}/certs/ca.cert.pem" \
	"${SIGNER_DIR}/certs/ca-chain.cert.pem" > \
	"${SIGNED_DIR}/certs/cert-chain.pem"

chmod 644 "${SIGNED_DIR}/certs/cert-chain.pem"
