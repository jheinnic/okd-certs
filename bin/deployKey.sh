#!/bin/sh

if ! CURRENT_DIR="$(pwd)"
then
        echo "Cannot find present working directory?"
        exit -1
fi

if ! INSTALL_DIR="$(dirname ${0})/.."
then
        echo "Cannot locate installation dir relative to ${0}"
        exit -2
fi

SIGNER_DIR=$(node -p "require('path').normalize('${INSTALL_DIR}/authorities/serversCA')")
if [ ! -d ${SIGNER_DIR} ]
then
        echo "${SIGNER_DIR} does not exist as a directory"
fi

SIGNED_DIR=$(node -p "require('path').normalize('${INSTALL_DIR}/deployments/${1}')")
if [ -d ${SIGNED_DIR} ]
then
        echo "${SIGNED_DIR} already exists as a directory"
fi

if ! DAYS_SIGNED="$(cat $SIGNER_DIR/certExpiryDays)"
then
	echo "Problem reading certExpiryDays from signer"
	exit -3
fi
 
mkdir ${SIGNED_DIR}
mkdir "${SIGNED_DIR}/certs"
mkdir "${SIGNED_DIR}/private"
mkdir "${SIGNED_DIR}/csr"

openssl genrsa -out "${SIGNED_DIR}/private/ca.key.pem" 4096
chmod 400 "${SIGNED_DIR}/private/ca.key.pem"

openssl req -new -sha256 \
      -config "${SIGNER_DIR}/openssl.cnf" \
      -key "${SIGNED_DIR}/private/ca.key.pem" \
      -out "${SIGNED_DIR}/csr/ca.csr.pem"

openssl ca -config "${SIGNER_DIR}/openssl.cnf" \
      -extensions server_cert \
      -days ${DAYS_SIGNED} -notext -md sha256 \
      -in "${SIGNED_DIR}/csr/ca.csr.pem" \
      -out "${SIGNED_DIR}/certs/ca.cert.pem"

chmod 444 "${SIGNED_DIR}/certs/ca.cert.pem"

openssl x509 -noout -text -in "${SIGNED_DIR}/certs/ca.cert.pem"

cat "${SIGNED_DIR}/certs/ca.cert.pem" \
      "${SIGNER_DIR}/certs/ca-chain.cert.pem" > \
      "${SIGNED_DIR}/certs/ca-chain.cert.pem"

chmod 444 "${SIGNED_DIR}/certs/ca-chain.cert.pem"
