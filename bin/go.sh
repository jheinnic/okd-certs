#!/bin/bash

if ! INSTALL_DIR="$(dirname $(dirname $(realpath "${0}")))"
then
        echo "Cannot locate installation dir relative to ${0}"
        exit -2
fi

BIN_DIR="${INSTALL_DIR}/bin"

/bin/mkdir -p "${INSTALL_DIR}/authorities/rootCA"
/bin/mkdir -p "${INSTALL_DIR}/authorities/intermediateCA"
/bin/mkdir -p "${INSTALL_DIR}/authorities/clientsCA"
/bin/mkdir -p "${INSTALL_DIR}/authorities/serversCA"
echo 3650 > "${INSTALL_DIR}/authorities/rootCA/certExpiryDays"
echo 1825 > "${INSTALL_DIR}/authorities/intermediateCA/certExpiryDays"
echo 730 > "${INSTALL_DIR}/authorities/clientsCA/certExpiryDays"
echo 365 > "${INSTALL_DIR}/authorities/serversCA/certExpiryDays"

"${BIN_DIR}/genStructure.sh" rootCA
"${BIN_DIR}/genStructure.sh" intermediateCA
"${BIN_DIR}/genStructure.sh" clientsCA
"${BIN_DIR}/genStructure.sh" serversCA

# "${BIN_DIR}/genKey.sh" rootCA 4096
"${BIN_DIR}/genRootCert.sh"

"${BIN_DIR}/genKey.sh" intermediateCA
"${BIN_DIR}/genChainedCert.sh" rootCA intermediateCA

"${BIN_DIR}/genKey.sh" clientsCA
"${BIN_DIR}/genChainedCert.sh" intermediateCA clientsCA

"${BIN_DIR}/genKey.sh" serversCA
"${BIN_DIR}/genChainedCert.sh" intermediateCA serversCA
