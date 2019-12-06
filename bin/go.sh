#!/bin/bash

if ! CURRENT_DIR="$(pwd)"
then
	echo "Cannot find present working directory?"
	exit -1
fi

if ! INSTALL_DIR="$(dirname ${CURRENT_DIR}/$0)/.."
then
	echo "Cannot locate installation dir relative to ${0}"
	exit -2
fi
echo $(node -p "require('path').normalize('${INSTALL_DIR}')")
INSTALL_DIR=$(node -p "require('path').normalize('${INSTALL_DIR}')")

"${INSTALL_DIR}/bin/genStructure.sh" rootCA
"${INSTALL_DIR}/bin/genStructure.sh" intermediateCA
"${INSTALL_DIR}/bin/genStructure.sh" clientsCA
"${INSTALL_DIR}/bin/genStructure.sh" serversCA

"${INSTALL_DIR}/bin/genKey.sh" rootCA
"${INSTALL_DIR}/bin/genRootCert.sh"

"${INSTALL_DIR}/bin/genKey.sh" intermediateCA
"${INSTALL_DIR}/bin/genIntermediateCert.sh" rootCA intermediateCA

"${INSTALL_DIR}/bin/genKey.sh" clientsCA
"${INSTALL_DIR}/bin/genIntermediateCert.sh" intermediateCA clientsCA

"${INSTALL_DIR}/bin/genKey.sh" serversCA
"${INSTALL_DIR}/bin/genIntermediateCert.sh" intermediateCA serversCA
