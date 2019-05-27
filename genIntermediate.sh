#!/bin/sh

mkdir intermediate
cp openssl_intermediate.cnf intermediate/openssl.cnf
cd intermediate

../genStructure.sh
mkdir csr
echo 1000 > /Users/johnheinnickel/rootCa/intermediate/crlnumber

../genServers.sh
../genClients.sh

cd ..
