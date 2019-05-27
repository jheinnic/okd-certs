#!/bin/sh

mkdir servers
cp ../openssl_servers.cnf servers/openssl.cnf
cd servers

../../genStructure.sh
mkdir csr
echo 1000 > /Users/johnheinnickel/rootCa/intermediate/servers/crlnumber

cd ..
