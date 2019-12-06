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
INSTALL_DIR=$(node -p "require('path').normalize('${INSTALL_DIR}')")

openssl req -config "${INSTALL_DIR}/authorities/rootCA/openssl.cnf" \
      -key "${INSTALL_DIR}/authorities/rootCA/private/ca.key.pem" \
      -new -x509 -days 7300 -sha256 -extensions v3_ca \
      -out "${INSTALL_DIR}/authorities/rootCA/certs/ca.cert.pem"

chmod 444 "${INSTALL_DIR}/authorities/rootCA/certs/ca.cert.pem"

cp "${INSTALL_DIR}/authorities/rootCA/certs/ca.cert.pem" \
      "${INSTALL_DIR}/authorities/rootCA/certs/ca-chain.cert.pem"

chmod 444 "${INSTALL_DIR}/authorities/rootCA/certs/ca-chain.cert.pem"
