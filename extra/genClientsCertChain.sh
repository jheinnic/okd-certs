#!/bin/sh

cat intermediate/clients/certs/clients.cert.pem \
      intermediate/certs/intermediate.cert.pem \
      certs/ca.cert.pem > intermediate/clients/certs/ca-chain.cert.pem
chmod 444 intermediate/clients/certs/ca-chain.cert.pem
