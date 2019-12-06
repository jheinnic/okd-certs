#!/bin/bash

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

AUTH_DIR=$(node -p "require('path').normalize('${INSTALL_DIR}/authorities/${1}')")
if [ ! -d ${AUTH_DIR} ]
then
        echo "${AUTH_DIR} does not exist as a directory"
fi
echo "${AUTH_DIR}"


openssl genrsa -out "${AUTH_DIR}/private/ca.key.pem" 4096 
chmod 400 "${AUTH_DIR}/private/ca.key.pem"

