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

SIGNER_DIR=$(node -p "require('path').normalize('${INSTALL_DIR}/authorities/${1}')")
if [ ! -d ${SIGNER_DIR} ]
then
        echo "${SIGNER_DIR} does not exist as a directory"
fi

SIGNED_DIR=$(node -p "require('path').normalize('${INSTALL_DIR}/authorities/${2}')")
if [ ! -d ${SIGNED_DIR} ]
then
        echo "${SIGNED_DIR} does not exist as a directory"
fi

if ! DAYS_SIGNED="$(cat $SIGNER_DIR/certExpiryDays)"
then
	echo "Problem reading certExpiryDays from signer"
	exit -3
fi

echo "Fiz"
openssl req -config "${SIGNED_DIR}/openssl.cnf" -new -sha256 \
      -key "${SIGNED_DIR}/private/ca.key.pem" \
      -out "${SIGNED_DIR}/csr/ca.csr.pem"

echo "Bin"
openssl ca -config "${SIGNER_DIR}/openssl.cnf" \
      -extensions v3_intermediate_ca \
      -days ${DAYS_SIGNED} -notext -md sha256 \
      -in "${SIGNED_DIR}/csr/ca.csr.pem" \
      -out "${SIGNED_DIR}/certs/ca.cert.pem"

echo "Give"
chmod 444 "${SIGNED_DIR}/certs/ca.cert.pem"

openssl x509 -noout -text -in "${SIGNED_DIR}/certs/ca.cert.pem"

cat "${SIGNED_DIR}/certs/ca.cert.pem" \
      "${SIGNER_DIR}/certs/ca-chain.cert.pem" > \
      "${SIGNED_DIR}/certs/ca-chain.cert.pem"

chmod 444 "${SIGNED_DIR}/certs/ca-chain.cert.pem"
