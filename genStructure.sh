#!/bin/sh

mkdir certs crl newcerts private
chmod 700 private
touch index.txt
echo 1000 > serial
