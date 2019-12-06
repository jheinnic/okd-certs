#!/bin/sh

openssl req -config intermediate/servers/openssl.cnf -new -sha256 \
      -key intermediate/servers/private/servers.key.pem \
      -out intermediate/servers/csr/servers.csr.pem

openssl ca -config intermediate/openssl.cnf -extensions v3_intermediate_ca \
      -days 1825 -notext -md sha256 \
      -in intermediate/servers/csr/servers.csr.pem \
      -out intermediate/servers/certs/servers.cert.pem

chmod 444 intermediate/servers/certs/servers.cert.pem

openssl x509 -noout -text \
      -in intermediate/servers/certs/servers.cert.pem
