#!/bin/sh

./genStructure.sh
./genIntermediate.sh

./genRootKey.sh
./genRootCert.sh

./genIntermediateKey.sh
./genIntermediateCert.sh
./genIntermediateCertChain.sh

./genClientsKey.sh
./genClientsCert.sh
./genClientsCertChain.sh

./genServersKey.sh
./genServersCert.sh
./genServersCertChain.sh

