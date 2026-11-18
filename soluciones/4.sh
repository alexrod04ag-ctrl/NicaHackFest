#!/usr/bin/env bash
# Solución del ejercicio 4: activar la regla de la VLAN 30 para OU=IoT
set -e
f=/lab/radius/vlan_por_certificado
sed -i '/# elsif (&TLS-Client-Cert-Subject =~ \/OU=IoT\/)/,/^\t\t# }$/ s/^\(\t*\)# \?/\1/' "$f"
lab reiniciar >/dev/null
