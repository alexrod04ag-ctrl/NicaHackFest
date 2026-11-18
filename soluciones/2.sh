#!/usr/bin/env bash
# Solución del ejercicio 2: crear la PKI y emitir los certificados
set -e
cd /lab/pki
if [[ ! -f ca.pem ]]; then
  openssl genpkey -quiet -algorithm RSA -pkeyopt rsa_keygen_bits:2048 -out ca.key
  openssl req -x509 -new -key ca.key -days 365 -out ca.pem \
    -subj "/O=NicaHackfest Lab/CN=Lab Root CA" -config ca.cnf -extensions v3_ca
fi
[[ -f radius.pem ]]    || ./emitir.sh servidor radius >/dev/null
[[ -f laptop-01.pem ]] || ./emitir.sh dispositivo laptop-01 Corporativo >/dev/null
[[ -f camara-01.pem ]] || ./emitir.sh dispositivo camara-01 IoT >/dev/null
lab reiniciar >/dev/null
