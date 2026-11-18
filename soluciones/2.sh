#!/usr/bin/env bash
# Solución del ejercicio 2: crear la PKI y emitir los certificados
set -e
cd /lab/pki
if [[ ! -f ca.pem ]]; then
  openssl req -x509 -new -newkey rsa:2048 -nodes -days 365 -keyout ca.key -out ca.pem \
    -subj "/O=NicaHackfest Lab/CN=Lab Root CA" -config ca.cnf -extensions v3_ca 2>/dev/null
fi
[[ -f radius.pem ]]    || ./emitir.sh servidor radius >/dev/null
[[ -f laptop-01.pem ]] || ./emitir.sh dispositivo laptop-01 Corporativo >/dev/null
[[ -f camara-01.pem ]] || ./emitir.sh dispositivo camara-01 IoT >/dev/null
lab reiniciar >/dev/null
