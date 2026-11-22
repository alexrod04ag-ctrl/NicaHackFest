#!/usr/bin/env bash
# Revoca un certificado y publica la lista de revocación (CRL).
# Uso: ./revocar.sh <nombre>
set -euo pipefail
umask 022
cd /lab/pki
nombre=${1:-}
[[ -n $nombre && -f $nombre.pem ]] || { echo "Uso: ./revocar.sh <nombre>  (debe existir $nombre.pem)"; exit 1; }
run() { echo -e "\e[36m\$ $*\e[0m"; "$@"; }

echo "1) Marcar el certificado como revocado en la base de la CA"
run openssl ca -config ca.cnf -revoke "$nombre.pem" 2>&1 | grep -v "^Using configuration" || true
echo "2) Publicar la nueva lista de revocación (CRL)"
run openssl ca -config ca.cnf -gencrl -out crl.pem 2>/dev/null
echo "3) Certificados revocados en la CRL"
openssl crl -in crl.pem -noout -text | grep -A1 "Serial Number" | sed 's/^/   /'
