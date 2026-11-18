#!/usr/bin/env bash
# Solución del ejercicio 5: revocar la cámara y revisar la CRL
set -e
cd /lab/pki
grep -q "^R.*camara-01" index.txt 2>/dev/null || ./revocar.sh camara-01 >/dev/null
sed -i -E 's/^(\s*)check_crl = no/\1check_crl = yes/' /lab/radius/eap
lab reiniciar >/dev/null
