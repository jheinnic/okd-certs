#!/bin/sh

mkdir clients
cp ../openssl_clients.cnf clients/openssl.cnf
cd clients

../../genStructure.sh
mkdir csr
echo 1000 > /Users/johnheinnickel/rootCa/intermediate/clients/crlnumber

cd ..
