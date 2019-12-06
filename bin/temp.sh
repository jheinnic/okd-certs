#!/bin/sh

CURRENT_DIR="$(pwd)"
ROOT_DIR="$(dirname ${CURRENT_DIR}/$0)/.."
AUTH_DIR="${ROOT_DIR}/authorities/${1}"

echo $1
echo $2
echo $3
echo $ROOT_DIR
echo $AUTH_DIR
