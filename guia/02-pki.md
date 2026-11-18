# 2 · Crear tu PKI (7 min)

**Objetivo:** crear una autoridad certificadora (CA) y emitir los certificados del servidor RADIUS y de dos dispositivos. Esta es la base de la identidad sin contraseñas.

Entra a la carpeta de la PKI:

```bash
cd /lab/pki
```

## Paso 1 · La CA raíz

La CA es la entidad en la que todos confían. Primero su clave privada, después su certificado autofirmado:

```bash
openssl genpkey -quiet -algorithm RSA -pkeyopt rsa_keygen_bits:2048 -out ca.key
openssl req -x509 -new -key ca.key -days 365 -out ca.pem \
  -subj "/O=NicaHackfest Lab/CN=Lab Root CA" -config ca.cnf -extensions v3_ca
```

Míralo:

```bash
openssl x509 -in ca.pem -noout -subject -issuer -dates
```

El *subject* y el *issuer* son iguales: la CA raíz se firma a sí misma.

## Paso 2 · El certificado del servidor RADIUS

Los dispositivos lo usan para comprobar que hablan con el servidor real y no con uno falso:

```bash
./emitir.sh servidor radius
```

El script muestra cada comando que ejecuta: crea la clave privada, arma la solicitud de firma (CSR) y la CA la firma.

## Paso 3 · Los certificados de los dispositivos

La **unidad organizativa (OU)** del certificado dice qué tipo de dispositivo es. La vamos a usar en el ejercicio 4.

```bash
./emitir.sh dispositivo laptop-01 Corporativo
./emitir.sh dispositivo camara-01 IoT
```

## Paso 4 · Cargar tu PKI en el servidor

```bash
cd /lab
lab reiniciar
```

## Resultado esperado

En `pki/` tienes `ca.pem`, `radius.pem`, `laptop-01.pem` y `camara-01.pem`, cada uno con su `.key`. El servidor dice: *"con los certificados de tu PKI"*.

## Verifica

```bash
lab verificar 2
```

## Para pensar

- La clave privada (`.key`) de cada dispositivo **nunca sale del dispositivo**. En la vida real vive protegida en el TPM y la entrega el MDM.
- ¿Qué pasaría si alguien roba `ca.key`? Por eso en producción la CA raíz se guarda fuera de línea.

Sigue con el [ejercicio 3](03-peap-vs-eaptls.md).
