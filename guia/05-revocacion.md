# 5 · Revocar un dispositivo (4 min)

**Objetivo:** la cámara fue robada. Hay que quitarle el acceso de inmediato, sin tocar a los demás dispositivos.

## Paso 1 · Revoca el certificado

```bash
cd /lab/pki
./revocar.sh camara-01
cd /lab
```

La CA marca el certificado como revocado y publica una nueva **lista de revocación (CRL)**.

## Paso 2 · Pide al servidor que revise la CRL

Abre `radius/eap` en el editor y busca la línea:

```
		check_crl = no
```

Cámbiala por:

```
		check_crl = yes
```

Guarda el archivo.

## Paso 3 · Aplica y prueba

```bash
lab reiniciar
lab probar camara
lab probar laptop
```

## Resultado esperado

- `camara` → **ACCESO DENEGADO**, con el motivo: *el certificado está revocado (CRL)*.
- `laptop` → sigue entrando sin problema.

## Verifica

```bash
lab verificar 5
```

## Para pensar

- Con contraseñas, habría que cambiar la clave compartida y reconfigurar todo. Con certificados, revocas **solo ese dispositivo**.
- En producción esto se automatiza: cuando el MDM marca un equipo como perdido o una persona deja la empresa, su certificado se revoca.

Sigue con el [bonus: RadSec](06-radsec.md).
