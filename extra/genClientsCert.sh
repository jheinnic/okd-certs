#!/bin/sh

openssl req -config intermediate/clients/openssl.cnf -new -sha256 \
      -key intermediate/clients/private/clients.key.pem \
      -out intermediate/clients/csr/clients.csr.pem

openssl ca -config intermediate/openssl.cnf -extensions v3_intermediate_ca \
      -days 1825 -notext -md sha256 \
      -in intermediate/clients/csr/clients.csr.pem \
      -out intermediate/clients/certs/clients.cert.pem

chmod 444 intermediate/clients/certs/clients.cert.pem

openssl x509 -noout -text \
      -in intermediate/clients/certs/clients.cert.pem
