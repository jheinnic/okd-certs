#!/bin/bash

if ! INSTALL_DIR="$(dirname $(dirname $(realpath "${0}")))"
then
        echo "Cannot locate installation dir relative to ${0}"
        exit -2
fi

BIN_DIR="${INSTALL_DIR}/bin"

"${BIN_DIR}/genStructure.sh" rootCA
"${BIN_DIR}/genStructure.sh" intermediateCA
"${BIN_DIR}/genStructure.sh" clientsCA
"${BIN_DIR}/genStructure.sh" serversCA

# "${BIN_DIR}/genKey.sh" rootCA 4096
"${BIN_DIR}/genRootCert.sh"

"${BIN_DIR}/genKey.sh" intermediateCA
"${BIN_DIR}/genIntermediateCert.sh" rootCA intermediateCA

"${BIN_DIR}/genKey.sh" clientsCA
"${BIN_DIR}/genIntermediateCert.sh" intermediateCA clientsCA

"${BIN_DIR}/genKey.sh" serversCA
"${BIN_DIR}/genIntermediateCert.sh" intermediateCA serversCA
