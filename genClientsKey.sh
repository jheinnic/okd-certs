#!/bin/sh

openssl genrsa -aes256 -out intermediate/clients/private/clients.key.pem 4096
chmod 400 intermediate/clients/private/clients.key.pem
