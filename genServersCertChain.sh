#!/bin/sh

cat intermediate/servers/certs/servers.cert.pem \
      intermediate/certs/intermediate.cert.pem \
      certs/ca.cert.pem > intermediate/servers/certs/ca-chain.cert.pem
chmod 444 intermediate/servers/certs/ca-chain.cert.pem
