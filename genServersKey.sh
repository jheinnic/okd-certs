#!/bin/sh

openssl genrsa -aes256 -out intermediate/servers/private/servers.key.pem 4096
chmod 400 intermediate/servers/private/servers.key.pem
