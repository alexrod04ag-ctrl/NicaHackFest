#!/usr/bin/env bash
# Emite un certificado firmado por la CA del laboratorio y muestra cada comando.
# Uso:
#   ./emitir.sh servidor     <nombre>
#   ./emitir.sh dispositivo  <nombre> <unidad-organizativa>
set -euo pipefail
umask 022
cd /lab/pki

tipo=${1:-}; nombre=${2:-}; ou=${3:-}
if [[ -z $tipo || -z $nombre || ( $tipo == dispositivo && -z $ou ) ]]; then
  echo "Uso: ./emitir.sh servidor <nombre>  |  ./emitir.sh dispositivo <nombre> <OU>"; exit 1
fi
[[ -f ca.pem && -f ca.key ]] || { echo "Primero crea la CA (paso 1 de la guía 02)."; exit 1; }
[[ -f index.txt ]] || touch index.txt
[[ -f serial ]] || echo 1000 > serial
[[ -f crlnumber ]] || echo 1000 > crlnumber

case $tipo in
  servidor)    subj="/O=NicaHackfest Lab/CN=$nombre.lab"; ext=servidor ;;
  dispositivo) subj="/O=NicaHackfest Lab/OU=$ou/CN=$nombre.lab"; ext=dispositivo ;;
  *) echo "Tipo desconocido: $tipo (usa servidor o dispositivo)"; exit 1 ;;
esac

run() { echo -e "\e[36m\$ $*\e[0m"; "$@"; }

echo "1) Clave privada de $nombre (nunca sale del equipo)"
run openssl genpkey -quiet -algorithm RSA -pkeyopt rsa_keygen_bits:2048 -out "$nombre.key"
echo "2) Solicitud de firma (CSR) con su identidad"
run openssl req -new -key "$nombre.key" -out "$nombre.csr" -subj "$subj" -config ca.cnf
echo "3) La CA firma la solicitud con el perfil '$ext'"
run openssl ca -batch -notext -config ca.cnf -extensions "$ext" -in "$nombre.csr" -out "$nombre.pem" 2>/dev/null
echo "4) Resultado"
openssl x509 -in "$nombre.pem" -noout -subject -issuer -enddate | sed 's/^/   /'
