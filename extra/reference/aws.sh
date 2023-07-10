#!/bin/sh

aws iam upload-server-certificate --server-certificate-name pseudo-ha-us-dso-jfrog --certificate-body file:///home/ionadmin/Git/JchPtf/Certs/okd-certs/authorities/serversCA/certs/ca.cert.pem --certificate-chain file:///home/ionadmin/Git/JchPtf/Certs/okd-certs/authorities/serversCA/certs/ca-chain.cert.pem --private-key file:///home/ionadmin/Git/JchPtf/Certs/okd-certs/authorities/serversCA/private/ca.key.pem --tags '{"Key": "costcenter", "Value": "10051227"}' --profile irtemp --region us-east-1 
